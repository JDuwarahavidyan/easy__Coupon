// report_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:easy_coupon/models/students/student.dart';
import 'package:easy_coupon/pages/student/report_repo.dart';

import 'report_event.dart';
import 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository _reportRepository;

  ReportBloc(this._reportRepository) : super(ReportInitial()) {
    on<GetData>(_onGetData);
  }

  void _onGetData(GetData event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    try {
      List<ReportDataModel> reportData;
      if (event.startDate.isEmpty && event.endDate.isEmpty) {
        reportData = await _reportRepository.get();
      } else {
        reportData = await _reportRepository.getByDateRange(
            event.startDate, event.endDate);
      }
      emit(ReportLoaded(reportData: reportData));
    } catch (e) {
      emit(ReportError(error: e.toString()));
    }
  }
}
