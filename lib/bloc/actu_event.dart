import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class ActuEvent extends Equatable {
  const ActuEvent();
}

class ActuFetch extends ActuEvent {
  @override
  List<Object> get props => null;
}

class ActuAdd extends ActuEvent {
  final ActuModel actu;

  ActuAdd(this.actu);
  @override
  List<Object> get props => null;
}
