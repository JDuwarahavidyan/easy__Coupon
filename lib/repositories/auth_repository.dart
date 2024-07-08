import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_coupon/models/user/user_model.dart';
import 'package:easy_coupon/services/auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository({FirebaseAuthService? firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService ?? FirebaseAuthService();

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    // Sign in with email and password
    await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    return _firebaseAuthService.getCurrentUser()!;
  }

  Future<User> registerNewUser(
      String email, String password, String username, String role) async {
    // Sign up with email and password
    await _firebaseAuthService.registerNewUser(email, password, username, role);
    return _firebaseAuthService.getCurrentUser()!;
  }

  Future<User> signInWithUsernameAndPassword(
      String username, String password) async {
    final email = await _firebaseAuthService.getEmailFromUsername(username);
    await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    return _firebaseAuthService.getCurrentUser()!;
  }

  Future<void> signOut() async {
    // Sign out
    await _firebaseAuthService.signOut();
  }

 
}
