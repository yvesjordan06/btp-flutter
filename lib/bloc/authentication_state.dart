import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

class AuthDoingState extends AuthenticationAuthenticated {
  AuthDoingState(UserModel user) : super(user);
}

class AuthDoingSuccessState extends AuthenticationAuthenticated {
  AuthDoingSuccessState(UserModel user) : super(user);
}

class UserEdited extends AuthenticationAuthenticated {
  UserEdited(UserModel user) : super(user);
}

class PictureChanged extends AuthenticationAuthenticated {
  PictureChanged(UserModel user) : super(user);
}

class AuthFailureState extends AuthenticationAuthenticated {
  final String error;

  AuthFailureState(UserModel user, {@required this.error})
      : assert(error != null && error.isNotEmpty),
        super(user);
}

class AuthDoingFailedState extends AuthenticationAuthenticated {
  final String error;

  AuthDoingFailedState(UserModel user, {@required this.error})
      : assert(error != null && error.isNotEmpty),
        super(user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
