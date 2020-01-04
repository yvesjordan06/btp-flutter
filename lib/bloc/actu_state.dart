import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class ActuState extends Equatable {
  const ActuState();
}

class InitialActuState extends ActuState {
  @override
  List<Object> get props => [];
}

class ActuFetchingState extends ActuState {
  @override
  List<Object> get props => [];
}

class ActuFetchedState extends ActuState {
  final List<ActuModel> list;

  ActuFetchedState(this.list);

  @override
  List<Object> get props => [list];
}

class ActuFetchedFailedState extends ActuState {
  final String error;

  ActuFetchedFailedState(this.error);

  @override
  List<Object> get props => [];
}

class ActuCreatingState extends ActuState {
  @override
  List<Object> get props => [];
}

class ActuCreatedState extends ActuFetchedState {
  ActuCreatedState(List<ActuModel> list) : super(list);

  @override
  List<Object> get props => [];
}

class ActuCreatedFailedState extends ActuState {
  final String error;

  ActuCreatedFailedState(this.error);

  @override
  List<Object> get props => [];
}
