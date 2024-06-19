import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeClickPlusButtonEvent>(homeClickPlusButtonEvent);
    on<HomeClickMinusButtonEvent>(homeClickMinusButtonEvent);
    on<HomeScannerButtonNavigatorEvent>(homeScannerButtonNavigatorEvent);
  }

  FutureOr<void> homeClickPlusButtonEvent(
      HomeClickPlusButtonEvent event, Emitter<HomeState> emit) {
    print("Plus Button Clicked");
  }

  FutureOr<void> homeClickMinusButtonEvent(
      HomeClickMinusButtonEvent event, Emitter<HomeState> emit) {
    print("Minus Button Clicked");
  }

  FutureOr<void> homeScannerButtonNavigatorEvent(
      HomeScannerButtonNavigatorEvent event, Emitter<HomeState> emit) {
    print("Navigate to QR Scanner");
  }
}
