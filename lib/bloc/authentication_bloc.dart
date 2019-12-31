import 'dart:async';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './bloc.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();
  UserModel currentUser;
  AuthenticationBloc();

  @override
  AuthenticationState get initialState {
    return super.initialState ?? AuthenticationUnauthenticated();
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    try {
      currentUser = UserModel.fromJson(json);
      print('init $currentUser');
      return currentUser.id.isNotEmpty
          ? AuthenticationAuthenticated(currentUser)
          : AuthenticationUnauthenticated();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      return state.user.toJson();
    } else if (state is AuthenticationUnauthenticated) {
      return UserModel().toJson();
    } else {
      return null;
    }
  }

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
      (BlocSupervisor.delegate as HydratedBlocDelegate).storage.clear();
      await userRepository.logout();
    }

    if (event is EditUser) {
      yield EditingUser(currentUser);
      currentUser = await userRepository.editUser(event.user);
      yield UserEdited(currentUser);
    }
  }
}
