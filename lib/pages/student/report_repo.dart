import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/models/students/student.dart';
import 'package:flutter/foundation.dart';

class ReportRepository {
  final CollectionReference _fireCloud =
      FirebaseFirestore.instance.collection("MealsPerDayByUser");

  Future<void> create({required String Number, required String Time}) async {
    try {
      await _fireCloud.add({"Number": Number, "Time": Time});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with an Error '${e.code}':${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ReportDataModel>> get() async {
    List<ReportDataModel> proList = [];
    try {
      final pro = await _fireCloud.get();
      for (var element in pro.docs) {
        proList.add(
            ReportDataModel.fromJson(element.data() as Map<String, dynamic>));
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
