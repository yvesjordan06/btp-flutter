import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import './bloc.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  // Repository
  final UserRepository userRepository = UserRepository();

  // Bloc Variables
  UserModel currentUser;
  List<MetierModel> appMetiers = [];
  AppStatusModel _status;

  // Bloc Methods
  List<TacheModel> get taches {
    Set<TacheModel> temp = Set<TacheModel>();
    for (MetierModel m in appMetiers) {
      temp = temp.union(m.taches.toSet());
    }

    return temp.toList();
  }

  List<CategorieTacheModel> get categories {
    List<CategorieTacheModel> temp = List<CategorieTacheModel>();

    for (TacheModel t in taches) {
      if (temp.contains((CategorieTacheModel c) => c.id == t.categorie.id)) {
        int index =
            temp.indexWhere((CategorieTacheModel c) => c.id == t.categorie.id);
        temp[index].taches.add(t);
      } else {
        CategorieTacheModel x = CategorieTacheModel(
            id: t.categorie.id,
            intitule: t.categorie.intitule,
            description: t.categorie.description);
        x.taches.add(t);
        temp.add(x);
      }
    }
    return temp;
  }

  void loadAppMetier() {
    try {
      userRepository.getMetiers().then((metier) {
        appMetiers = metier;
        add(AppStarted());
      });
    } catch (e) {
      print('Error auth bloc 22 $e');
    }
  }

  // Bloc Initial State

  @override
  AuthenticationState get initialState {
    //print('error auth bloc line 21 ');
    //print("error auth bloc line 22 ${super.initialState}");
    return super.initialState ?? AuthenticationUninitialized();
  }

  // Bloc load from storage
  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    try {
      print('error auth bloc line 29 $json');
      _status = AppStatusModel.fromJson(json);
      currentUser = _status.currentUser;
      appMetiers = _status.appMetier;
      print('user ${_status.isfirstTime}');
      print('user ${_status.currentUser}');
      if (_status.isfirstTime) return AuthenticationUninitialized();
      if (!_status.isLoggedin()) return AuthenticationUnauthenticated();
      // print('init $currentUser');
      /* return currentUser.id != null
          ? AuthenticationAuthenticated(currentUser)
          : AuthenticationUnauthenticated(); */
      loadAppMetier();
      return AuthenticationAuthenticated(currentUser);
    } catch (_) {
      print('error auth bloc line 39 $_');
      return null;
    }
  }

  // Bloc save to storage
  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      _status = AppStatusModel(
          isfirstTime: false, currentUser: state.user, appMetier: appMetiers);

      return _status.toJson();
    } else if (state is AuthenticationUnauthenticated) {
      //print("authBloc 53 I'm saving");
      try {
        return AppStatusModel(
          isfirstTime: false,
          currentUser: _status?.currentUser,
          appMetier: appMetiers,
        ).toJson();
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    try {
      if (event is AppStarted) {
        //print('app started');
        if (currentUser != null) {
          try {
            //print('authbloc 73 $currentUser');
            currentUser = await userRepository.getUser(
              int.parse(currentUser.id),
              accounttype: currentUser.accountType,
              usertype: currentUser.userType,
            );
            // print('authbloc 75 $currentUser');
            yield AuthenticationAuthenticated(currentUser);
          } catch (e) {
            print('error auth line 71 $e');
          }
        } else {
          //print('Authbloc 82 this is null');
          yield AuthenticationUnauthenticated();
        }
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
        //print('user got authenticated authbloc 102');

        yield AuthenticationAuthenticated(currentUser);
        //print('DONE0');
      }

      if (event is LoggedOut) {
        yield AuthenticationUnauthenticated();
        currentUser = null;
        _status = AppStatusModel(
            appMetier: appMetiers,
            currentUser: null,
            isfirstTime: _status.isfirstTime);
        (BlocSupervisor.delegate as HydratedBlocDelegate).storage.clear();
        this.add(AppStarted());
        await userRepository.logout();
      }

      if (event is EditUser) {
        yield EditingUser(currentUser);
        currentUser = await userRepository.editUser(event.user);
        yield UserEdited(currentUser);
      }

      if (event is SwapUser) {
        yield EditingUser(currentUser);

        try {
          currentUser = await userRepository.authenticate(
              telephone: currentUser.telephone,
              motDePasse: event.password,
              type: UserType.toggleType(currentUser.userType).toLowerCase());
          yield AuthenticationAuthenticated(currentUser);
          annoncesBloc.add(FetchAnnonce());
          chatsBloc.add(ChatsFetch());
        } catch (e) {
          yield AuthFailureState(currentUser,
              error: "Impossible d'effectuer cette requette");
        }
      }
    } catch (e) {
      print("Auth Bloc error $e");
    }
  }
}
