import 'dart:async';
import 'dart:io';

import 'package:btpp/Models/annonce.dart';
import 'package:flutter/foundation.dart';

class UserState extends ChangeNotifier {
  /// Internal, private state of the cart.
  UserModel _user;
  String _error = '';

  /// An unmodifiable view of the items in the cart.
  UserModel get currentUser => _user;
  String get error => _error;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  Future<void> login(String telephone, String motDePasse,
      {String type = 'Annonceur'}) {
    // This call tells the widgets that are listening to this model to rebuild.
    if (telephone.trim() == "1234567") {
      _error = '';
      _user = UserModel(
        nom: 'Hiro',
        prenom: 'Hamada',
        dateDeNaissance: DateTime.now(),
        status: 'status',
        accountType: AccountType.particulier,
        userType: UserType.annonceur,
        telephone: '694842185',
        motDePasse: '123456',
        pays: 'Cameroun',
        ville: 'Yaoundé',
        pictureLink:
            'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg',
      );
    } else {
      _error = 'Mot de passe incorrect';
    }

    return Future.delayed(Duration(seconds: 3), () {
      notifyListeners();
    });
  }

  void logout() {
    print('logging out');
    _user = null;
    notifyListeners();
  }

  void changePicture(File img) {
    _user.localPicture = img;
    notifyListeners();
  }

  void changeAccount([String motDePasse = '']) {
    if (motDePasse.length == 0) {
      motDePasse = _user.motDePasse;
    }
    login(_user.telephone, motDePasse,
        type: UserType.toggleType(_user.userType));
  }

  void setExampleUser() {
    _user = UserModel(
        nom: 'Hiro',
        prenom: 'Hamada',
        dateDeNaissance: DateTime.now(),
        status: 'status',
        accountType: AccountType.particulier,
        userType: UserType.annonceur,
        telephone: '694842185',
        motDePasse: '123456');
    notifyListeners();
  }
}

UserModel otherUser = UserModel(
    nom: 'Cristophe',
    prenom: 'Colombre',
    dateDeNaissance: DateTime.now(),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '694842185',
    motDePasse: '123456');
