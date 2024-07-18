import 'package:equatable/equatable.dart';

class QRModel extends Equatable {
  final String? id;
  final String studentId;
  final String canteenId;
  final String canteenType;
  final String studentName;
  final String canteenName;
  final String scanedAt;
  final int count;

  const QRModel({
     this.id,
    required this.studentId,
    required this.canteenId,
    required this.canteenType,
    required this.studentName,
    required this.canteenName,
    required this.scanedAt,
    required this.count,
  });

  factory QRModel.fromJson(Map<String, dynamic> json) {
    return QRModel(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      canteenId: json['canteenId'] as String,
      canteenType: json['canteenType'] as String,
      studentName: json['studentName'] as String,
      canteenName: json['canteenName'] as String,
      scanedAt: json['scanedAt'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'canteenId': canteenId,
      'canteenType': canteenType,
      'studentName': studentName,
      'canteenName': canteenName,
      'scanedAt': scanedAt,
      'count': count,
    };
  }

  @override
  List<Object?> get props => [
        studentId,
        canteenId,
        canteenType,
        studentName,
        canteenName,
        scanedAt,
        count,
      ];
}
