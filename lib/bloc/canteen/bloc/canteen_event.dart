import 'package:equatable/equatable.dart';

abstract class CanteenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAuthorizedUsers extends CanteenEvent {}
