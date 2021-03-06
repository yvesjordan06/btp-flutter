import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btpp/Repository/UserRepository.dart';
import 'package:meta/meta.dart';

import 'authentication_bloc.dart';
import 'authentication_event.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = UserRepository();
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        // print(event.telephone + ' ' + event.motDePasse);
        final user = await userRepository.authenticate(
            telephone: event.telephone,
            motDePasse: event.motDePasse,
            type: event.type);

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is SignUpPressed) {
      yield LoginLoading();
      try {
        // print(event.telephone + ' ' + event.motDePasse);
        final user = await userRepository.create(user: event.user);

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
