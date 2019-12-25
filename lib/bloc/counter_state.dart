import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();
}

class InitialCounterState extends CounterState {
  @override
  List<Object> get props => [];
}
