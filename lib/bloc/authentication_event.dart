import 'dart:io';

import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class ReloadUser extends AuthenticationEvent {}

class SwapUser extends AuthenticationEvent {
  final String password;

  SwapUser(this.password) : assert(password != null && password.isNotEmpty);
}

class AddMetierEvent extends AuthenticationEvent {
  final String password;

  AddMetierEvent(this.password)
      : assert(password != null && password.isNotEmpty);
}

class AddEvent extends AuthenticationEvent {
  final String password;

  AddEvent(this.password) : assert(password != null && password.isNotEmpty);
}

class RemoveMetierEvent extends AuthenticationEvent {
  final String password;

  RemoveMetierEvent(this.password)
      : assert(password != null && password.isNotEmpty);
}

class AddCursusEvent extends AuthenticationEvent {
  final String password;

  AddCursusEvent(this.password)
      : assert(password != null && password.isNotEmpty);
}

class AddCompetenceEvent extends AuthenticationEvent {
  final String password;

  AddCompetenceEvent(this.password)
      : assert(password != null && password.isNotEmpty);
}

class AddBioEvent extends AuthenticationEvent {
  final String password;

  AddBioEvent(this.password) : assert(password != null && password.isNotEmpty);
}

class LoggedIn extends AuthenticationEvent {
  final UserModel user;

  const LoggedIn({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user.id, user.accountType];

  @override
  String toString() => 'LoggedIn { user: $user }';
}

class ChangePicture extends AuthenticationEvent {
  final File image;

  const ChangePicture({@required this.image}) : assert(image != null);

  @override
  List<Object> get props => [image];
}

class EditUser extends AuthenticationEvent {
  final UserModel user;

  const EditUser({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [
        user.id,
        user.nom,
        user.prenom,
        user.dateDeNaissance,
        user.motDePasse,
        user.telephone
      ];
}

class LoggedOut extends AuthenticationEvent {}
