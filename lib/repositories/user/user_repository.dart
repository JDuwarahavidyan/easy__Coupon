import 'package:easy_coupon/models/user/user_model.dart';
import 'package:easy_coupon/services/user/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the necessary package

class UserRepository {
  final UserService _userService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Initialize the _firestore variable

  UserRepository(this._userService);

  Stream<List<UserModel>> getUsersStream() {
    return _userService.getUsersStream();
  }

  Future<UserModel?> getUser(String userId) async {
    return _userService.getUser(userId);
  }

  Future<void> updateUser(UserModel user) async {
    return _userService.updateUser(user);
  }

  Future<void> deleteUser(String userId) async {
    return _userService.deleteUser(userId);
  }

  Future<void> updateCount(int val, String userId) async {
    return _userService.updateCount(val, userId);
  }

  Future<String> generateQRData(String userId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final userRole = userDoc.data()?['role'] ?? 'unknown';
    return userRole;
  }
  
}
