part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionClass extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<StudentDataModel> student;

  HomeLoadedSuccessState({required this.student});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToReportActionState extends HomeActionClass {}

class HomeNavigateToScannerActionState extends HomeActionClass {}
