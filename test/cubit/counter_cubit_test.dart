import 'package:statemanagement/cubit/counter_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;
    // in setUp we instantiate the object we are going to work with
    setUp(() {
      counterCubit = CounterCubit();
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
  });
}
