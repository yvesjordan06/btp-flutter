import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();

  AuthenticationBloc();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final UserModel currentUser = await userRepository.loggedInUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(currentUser);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persist();
      yield AuthenticationAuthenticated(event.user);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.logout();
      yield AuthenticationUnauthenticated();
    }
  }
}
