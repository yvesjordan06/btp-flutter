import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserModel user;

  AuthenticationAuthenticated(this.user);

  @override
  List<Object> get props => [user.id, user.accountType];
}

class ChangingPicture extends AuthenticationAuthenticated {
  ChangingPicture(UserModel user) : super(user);
}

class EditingUser extends AuthenticationAuthenticated {
  EditingUser(UserModel user) : super(user);
}

class UserEdited extends AuthenticationAuthenticated {
  UserEdited(UserModel user) : super(user);
}

class PictureChanged extends AuthenticationAuthenticated {
  PictureChanged(UserModel user) : super(user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
