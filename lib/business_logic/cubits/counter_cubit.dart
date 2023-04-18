import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:statemanagement/business_logic/cubits/internet_cubit.dart';
import 'package:statemanagement/constant/enums.dart';
part "counter_state.dart";

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetSubscription;
  CounterCubit({required this.internetCubit})
      : super(CounterState(counterValue: 0, wasIncremented: false)) {
    monitorInternetCubit();
  }
  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));
  @override
  Future<void> close() async {
    internetSubscription.cancel();
    super.close();
  }
}
