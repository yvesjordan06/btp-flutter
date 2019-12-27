import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();
  UserModel currentUser;
  AuthenticationBloc();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      currentUser = await userRepository.loggedInUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(currentUser);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is ChangePicture) {
      currentUser.localPicture = event.image;
      yield AuthenticationAuthenticated(currentUser);
      yield ChangingPicture(currentUser);
      await userRepository.persist();
      yield PictureChanged(currentUser);
    }
    if (event is LoggedIn) {
      // await userRepository.persist();
      currentUser = event.user;
      print('authenticated with id : ' + currentUser.id);
      yield AuthenticationAuthenticated(currentUser);
    }

    if (event is LoggedOut) {
      yield AuthenticationUnauthenticated();
      currentUser = null;
      await userRepository.logout();
    }

    if (event is EditUser) {
      yield EditingUser(currentUser);
      currentUser = await userRepository.editUser(event.user);
      yield UserEdited(currentUser);
    }
  }
}
