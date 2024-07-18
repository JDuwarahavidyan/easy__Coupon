import 'package:bloc/bloc.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:easy_coupon/repositories/qrcode/qr_repositoryy.dart';
import 'qrr_event.dart';
import 'qrr_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final QrRepository _qrRepository;

  ReportBloc(this._qrRepository) : super(ReportInitial()) {
    on<GetData>(_onGetData);
  }

  void _onGetData(GetData event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    try {
      List<QRModel> reportData;
      if (event.startDate.isEmpty && event.endDate.isEmpty) {
        reportData = await _qrRepository.getUser('CxSPsu4WoKaplrKEKN1Dy2KTOZZ2');
      } else {
        reportData = await _qrRepository.getByDateRange(event.startDate, event.endDate);
      }
      emit(ReportLoaded(reportData: reportData));
    } catch (e) {
      emit(ReportError(error: e.toString()));
    }
  }
}
