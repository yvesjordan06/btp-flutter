import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String telephone;
  final String motDePasse;
  final String type;

  const LoginButtonPressed({
    @required this.telephone,
    @required this.motDePasse,
    this.type,
  });

  @override
  List<Object> get props => [telephone, motDePasse];

  @override
  String toString() =>
      'LoginButtonPressed { telephone: $telephone, password: $motDePasse }';
}

class SignUpPressed extends LoginEvent {
  final UserModel user;

  SignUpPressed(this.user);

  @override
  List<Object> get props => [user];
}
