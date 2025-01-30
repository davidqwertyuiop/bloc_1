import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

  class CounterCubit extends Cubit<CounterState> {
    final Connectivity internetCubit;
    StreamSubscription<List<ConnectivityResult>>? _streamSubscription;

    void increment() => emit(CounterState(counter: state.counter + 1, wasIncremented: true));
    void decrement() => emit(CounterState(counter: state.counter - 1, wasIncremented: false));

    CounterCubit({required this.internetCubit}) : super(CounterState(counter: 0, wasIncremented: false)) {
      _streamSubscription = internetCubit.onConnectivityChanged.listen((internetState) {
        for (var result in internetState) {
          if (result == ConnectivityResult.wifi) {
            increment();
          } else if(result == ConnectivityResult.mobile){
            decrement();
          }
        }
        
    });

    
  }
  
}

