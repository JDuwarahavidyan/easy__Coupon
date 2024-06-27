import 'package:easy_coupon/models/students/student.dart';
import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportError extends ReportState {
  final String error;

  ReportError(this.error);

  @override
  List<Object> get props => [error];
}

class ReportLoading extends ReportState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ReportLoaded extends ReportState {
  List<ReportDataModel> reportData;

  ReportLoaded(this.reportData);

  @override
  List<Object> get props => [reportData];
}
