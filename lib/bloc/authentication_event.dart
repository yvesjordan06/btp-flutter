import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final UserModel user;

  const LoggedIn({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user.id, user.accountType];

  @override
  String toString() => 'LoggedIn { user: $user }';
}

class LoggedOut extends AuthenticationEvent {}
