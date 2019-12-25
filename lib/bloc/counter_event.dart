import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

class CounterIncrement extends CounterEvent {
  @override
  List<Object> get props => null;
}

class CounterDecrement extends CounterEvent {
  @override
  List<Object> get props => null;
}
