import 'package:bloc_1/Business%20logic%20layer/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit(internetCubit: Connectivity());
    });

    tearDown(() {
      counterCubit.close();
    });

    test('initial state is CounterState(counter: 0, wasIncremented: false)', () {
      expect(counterCubit.state, CounterState(counter: 0, wasIncremented: false));
    });

    blocTest<CounterCubit, CounterState>(
      'emits [CounterState(counter: 1, wasIncremented: true)] when increment is called',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [CounterState(counter: 1, wasIncremented: true)],
    );

    blocTest<CounterCubit, CounterState>(
      'emits [CounterState(counter: -1, wasIncremented: false)] when decrement is called',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [CounterState(counter: -1, wasIncremented: false)],
    );
  });
}