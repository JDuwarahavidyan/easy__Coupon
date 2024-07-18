import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/exception/exceptions.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:flutter/foundation.dart';

class QrRepository {
  final CollectionReference _qrCollection =
      FirebaseFirestore.instance.collection('qrcodes');
      

  Stream<List<QRModel>> getQrRecordsStream() {
    
    return _qrCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => QRModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<List<QRModel>> getUser(String studentId) async {
    try {
      QuerySnapshot querySnapshot = await _qrCollection
          .where('studentId', isEqualTo: studentId)
          .get();
      return querySnapshot.docs
          .map((doc) => QRModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CustomException('Error getting user: $e');
    }
  }

  Future<List<QRModel>> getByDateRange(
      String startDate, String endDate) async {
    List<QRModel> proList = [];
    try {
      final pro = await _qrCollection
          .where("scanedAt", isGreaterThanOrEqualTo: startDate)
          .where("scanedAt", isLessThanOrEqualTo: endDate)
          .get();
      for (var element in pro.docs) {
        proList.add(
            QRModel.fromJson(element.data() as Map<String, dynamic>));
      }
      return proList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with an Error '${e.code}':${e.message}");
      }
      return proList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
