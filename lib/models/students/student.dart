class StudentDataModel {
  final String email;
  final String username;
  final int count;
  final String? picture;

  StudentDataModel(
      {required this.email,
      required this.username,
      required this.count,
      required this.picture});
}

class ReportDataModel {
  final String Number;
  final String Time;

  ReportDataModel({required this.Number, required this.Time});

  factory ReportDataModel.fromJson(Map<String, dynamic> json) {
    return ReportDataModel(Number: json['Number'], Time: json['Time']);
  }
}
