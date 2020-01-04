import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import './bloc.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();
  UserModel currentUser;
  AppStatusModel _status;

  @override
  AuthenticationState get initialState {
    print('error auth bloc line 21 ');
    print("error auth bloc line 22 ${super.initialState}");
    return super.initialState ?? AuthenticationUninitialized();
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    try {
      print('error auth bloc line 29 $json');
      _status = AppStatusModel.fromJson(json);
      currentUser = _status.currentUser;
      print('user ${_status.isfirstTime}');
      print('user ${_status.currentUser}');
      if (_status.isfirstTime) return AuthenticationUninitialized();
      if (!_status.isLoggedin()) return AuthenticationUnauthenticated();
      // print('init $currentUser');
      /* return currentUser.id != null
          ? AuthenticationAuthenticated(currentUser)
          : AuthenticationUnauthenticated(); */

      return AuthenticationAuthenticated(currentUser);
    } catch (_) {
      print('error auth bloc line 39 $_');
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      _status.currentUser = state.user;
      return _status.toJson();
    } else if (state is AuthenticationUnauthenticated) {
      print("authBloc 53 I'm saving");
      try {
        return AppStatusModel(
                isfirstTime: false, currentUser: _status?.currentUser)
            .toJson();
      } catch (e) {
        print(e);
      }
    }
    /* else if (state is AuthenticationUnauthenticated) {
      return UserModel().toJson();
    } */

    return null;
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      print('app started');
      if (currentUser != null) {
        try {
          print('authbloc 73 $currentUser');
          currentUser = await userRepository.getUser(
            int.parse(currentUser.id),
            accounttype: currentUser.accountType,
            usertype: currentUser.userType,
          );
          print('authbloc 75 $currentUser');
          yield AuthenticationAuthenticated(currentUser);
        } catch (e) {
          print('error auth line 71 $e');
        }
      }
      print('Authbloc 82 this is null');
      yield AuthenticationUnauthenticated();
    }

    if (event is ChangePicture) {
      currentUser.localPicture = event.image;
      yield AuthenticationAuthenticated(currentUser);
      yield ChangingPicture(currentUser);

      await userRepository.changePicture(event.image.path, currentUser);
      yield PictureChanged(currentUser);
    }
    if (event is LoggedIn) {
      // await userRepository.persist();
      currentUser = event.user;

      yield AuthenticationAuthenticated(currentUser);
    }

    if (event is LoggedOut) {
      yield AuthenticationUnauthenticated();
      currentUser = null;
      _status.currentUser = null;
      (BlocSupervisor.delegate as HydratedBlocDelegate).storage.clear();
      this.add(AppStarted());
      await userRepository.logout();
    }

    if (event is EditUser) {
      yield EditingUser(currentUser);
      currentUser = await userRepository.editUser(event.user);
      yield UserEdited(currentUser);
    }
  }
}
