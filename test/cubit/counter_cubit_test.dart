import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:statemanagement/business_logic/cubits/counter_cubit.dart';
import 'package:statemanagement/business_logic/cubits/internet_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;
    // in setUp we instantiate the object we are going to work with
    setUp(() {
      counterCubit = CounterCubit(
          internetCubit: InternetCubit(connectivity: Connectivity()));
    });
    //tearDown is a function that is called after each test is run
    tearDown(() {
      counterCubit.close();
    });
    test(
        "the initial state for the counterCubit is CounterState(counterValue: 0,wasIncremented: false)",
        () {
      expect(counterCubit.state,
          CounterState(counterValue: 0, wasIncremented: false));
    });
    blocTest<CounterCubit, CounterState>(
      "Test for increment",
      build: () => counterCubit,
      act: (bloc) => bloc.increment(),
      expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    );
    blocTest<CounterCubit, CounterState>(
      "Test for decrement",
      build: () => counterCubit,
      act: (bloc) => bloc.decrement(),
      expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
