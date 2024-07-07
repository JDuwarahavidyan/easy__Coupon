import 'package:bloc/bloc.dart';
import 'package:easy_coupon/models/students/student.dart';
import 'package:easy_coupon/pages/student/report_repo.dart';
import 'report_event.dart';
import 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;

  ReportBloc({required this.reportRepository}) : super(ReportInitial()) {
    on<GetData>((event, emit) async {
      emit(ReportLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await reportRepository.get();
        emit(ReportLoaded(data));
      } catch (e) {
        emit(ReportError(e.toString()));
      }
    });
  }
}
