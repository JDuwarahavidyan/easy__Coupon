import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_coupon/models/user/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthService(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firestore ?? FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User?> registerNewUser(
      String email, String password, String username, String role) async {
    // Check if the username is already taken
    final QuerySnapshot query = await _firebaseFirestore
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
    if (query.docs.isNotEmpty) {
      throw Exception('The Username is already taken.');
    }

    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = userCredential.user;

    if (user != null) {
      final userModel = UserModel(
        id: user.uid,
        userName: username,
        email: email,
        createdAt: DateTime.now().toIso8601String(),
        isFirstTime: true,
        role: role,
        studentCount: 30,
        canteenCount: 0,
      );
      await _firebaseFirestore.collection('users').doc(user.uid).set(
            userModel.toJson(),
          );
    }
    return user;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  
   Future<String> getEmailFromUsername(String username) async {
    final QuerySnapshot query = await _firebaseFirestore
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
    if (query.docs.isEmpty) {
      throw Exception('No user found with this username.');
    }
    return (query.docs.first.data() as Map<String, dynamic>)['email'];
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  

 
}
