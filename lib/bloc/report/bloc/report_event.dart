import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetData extends ReportEvent {
  GetData();
}
