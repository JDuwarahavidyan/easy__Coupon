import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/exception/exceptions.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';

class QrCodeService {
  final CollectionReference _qrCodeCollection =
      FirebaseFirestore.instance.collection('qrcodes');

  Future<void> createQrCode(QRModel qrcode) async {
    try {
      String id = _qrCodeCollection.doc().id;
      final newQrCode = QRModel(
        id: id,
        studentId: qrcode.studentId,
        canteenId: qrcode.canteenId,
        canteenType: qrcode.canteenType,
        studentName: qrcode.studentName,
        canteenName: qrcode.canteenName,
        scannedAt: qrcode.scannedAt,
        count: qrcode.count,
      );
      await _qrCodeCollection.doc(id).set(newQrCode.toJson());
    } catch (e) {
      throw CustomException('Error creating qrcode: $e');
    }
  }

  Stream<List<QRModel>> getQRCodeStream() {
    return _qrCodeCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => QRModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<QRModel?> getQRCode(String qrCodeId) async {
    try {
      DocumentSnapshot doc = await _qrCodeCollection.doc(qrCodeId).get();
      if (doc.exists) {
        return QRModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw CustomException('Error getting qrcode: $e');
    }
  }

  Future<void> deleteQrCode(String qrCodeId) async {
    try {
      await _qrCodeCollection.doc(qrCodeId).delete();
    } catch (e) {
      throw CustomException('Error deleting qrcode: $e');
    }
  }

  Future<QRModel> getPastScannedData(String uid) async {
  final snapshot = await _qrCodeCollection.where("uid", isEqualTo: uid).get();
  final qrData = snapshot.docs.map((e) => QRModel.fromJson(e.data() as Map<String, dynamic>)).single;
  return qrData;
  }

}
