part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeClickPlusButtonEvent extends HomeEvent {}

class HomeClickMinusButtonEvent extends HomeEvent {}

class HomeScannerButtonNavigatorEvent extends HomeEvent {}
