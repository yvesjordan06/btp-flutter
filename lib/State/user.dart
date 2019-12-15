

import 'dart:async';

import 'package:btpp/Models/annonce.dart';
import 'package:flutter/foundation.dart';

class UserState extends ChangeNotifier {
  /// Internal, private state of the cart.
  UserModel _user;
  String _error = '';

  /// An unmodifiable view of the items in the cart.
  get currentUser => _user;
  String get error => _error;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  Future<void> login(String telephone, String motDePasse, {String type = 'Annonceur'}) {
    // TODO Call login function and set User or Error
    // This call tells the widgets that are listening to this model to rebuild.
    _user = UserModel('Hiro', 'Hamada', DateTime.now(), 'status', AccountType.particulier, UserType.annonceur, '694842185', '123456');
    return Future.delayed(Duration(seconds: 10), (){
      notifyListeners();
    });
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
  
  void changeAccount([String motDePasse = '']) {
    if (motDePasse.length == 0) {
      motDePasse = _user.mot_de_passe;
  }
    login(_user.telephone, motDePasse, type: UserType.toggleType(_user.userType));
  }

  void setExampleUser() {
    _user = UserModel('Hiro', 'Hamada', DateTime.now(), 'status', AccountType.particulier, UserType.annonceur, '694842185', '123456');
    notifyListeners();
  }

  Future loadSavedUser() {
    return Future.delayed(Duration(seconds: 1));
  }

}

UserState appUser = UserState();
