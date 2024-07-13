import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_coupon/models/models.dart';
import 'package:easy_coupon/services/services.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository({FirebaseAuthService? firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService ?? FirebaseAuthService();

  Future<bool> isSignedIn() async {
    try {
      final currentUser = _firebaseAuthService.getCurrentUser();
      return currentUser != null;
    } catch (e) {
      print('Error checking if user is signed in: $e');
      return false;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuthService.signInWithEmailAndPassword(email, password);
      return _firebaseAuthService.getCurrentUser()!;
    } catch (e) {
      print('Error signing in with email and password: $e');
      rethrow; // Propagate the error to the caller
    }
  }

  Future<User> registerNewUser(
      String email, String password, String username, String role) async {
    try {
      await _firebaseAuthService.registerNewUser(
          email, password, username, role);
      return _firebaseAuthService.getCurrentUser()!;
    } catch (e) {
      print('Error registering new user: $e');
      rethrow;
    }
  }

  Future<User> signInWithUsernameAndPassword(
      String username, String password) async {
    try {
      final email = await _firebaseAuthService.getEmailFromUsername(username);
      await _firebaseAuthService.signInWithEmailAndPassword(email, password);
      return _firebaseAuthService.getCurrentUser()!;
    } catch (e) {
      print('Error signing in with username and password: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuthService.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  Future<UserModel> getUserDetails(String userId) async {
    try {
      return await _firebaseAuthService.getUserDetails(userId);
    } catch (e) {
      print('Error getting user details: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    return _firebaseAuthService.getCurrentUser();
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      await _firebaseAuthService.validateAndUpdatePassword(
          currentPassword, newPassword);
    } catch (e) {
      print('Error updating password: $e');
      rethrow;
    }
  }

  Future<bool> isFirstTimeLogin(User user) async {
    try {
      return await _firebaseAuthService.isFirstTimeLogin(user);
    } catch (e) {
      print('Error checking if first time login: $e');
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuthService.sendPasswordResetEmail(email);
    } catch (e) {
      print('Error sending password reset email: $e');
      rethrow;
    }
  }
}
