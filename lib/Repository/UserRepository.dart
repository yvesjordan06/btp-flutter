import 'dart:math';

import 'package:btpp/Models/annonce.dart';
import 'package:meta/meta.dart';

List<UserModel> exampleUser = [
  UserModel(
    id: '1',
    nom: 'Nguejip Mukete',
    prenom: 'Yves Jordan',
    dateDeNaissance: DateTime(2001, 9, 26),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '699663061',
    motDePasse: '123456',
    ville: 'Yaoundé',
    pays: 'Cameroun',
    quartier: 'Nkomkana',
  ),
  UserModel(
    id: '2',
    nom: 'Hiro Hamda',
    prenom: 'Hamada Jordan',
    dateDeNaissance: DateTime(1997, 9, 26),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '678576421',
    motDePasse: '123456',
    ville: 'Yaoundé',
    pays: 'Cameroun',
    quartier: 'Nkomkana',
  ),
  UserModel(
    id: '3',
    nom: 'Nguejip Mukete',
    prenom: 'Yves Jordan',
    dateDeNaissance: DateTime(2001, 9, 26),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '694842185',
    motDePasse: '123456',
    ville: 'Yaoundé',
    pays: 'Cameroun',
    quartier: 'Nkomkana',
  ),
  UserModel(
    id: '4',
    nom: 'Nguejip Mukete',
    prenom: 'Yves Jordan',
    dateDeNaissance: DateTime(2001, 9, 26),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.travailleur,
    telephone: '694842185',
    motDePasse: '123456',
    ville: 'Yaoundé',
    pays: 'Cameroun',
    quartier: 'Nkomkana',
  ),
  UserModel(
    id: '5',
    nom: 'Nako Noutong',
    prenom: 'Ericka Priscille',
    dateDeNaissance: DateTime(2001, 1, 7),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '61234567',
    motDePasse: '123456',
    ville: 'Yaoundé',
    pays: 'Cameroun',
    quartier: 'Nkomkana',
  ),
  UserModel(
    id: '6',
    nom: 'Makamte Meffeja',
    prenom: 'Leandra Gaelle',
    dateDeNaissance: DateTime(2000, 1, 2),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '693763455',
    motDePasse: '123456',
    ville: 'Yaoundé',
    pays: 'Cameroun',
    quartier: 'Oyom abang',
  ),
];

class UserRepository {
  Future<UserModel> authenticate({
    @required String telephone,
    @required String motDePasse,
    String type,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    // return exampleUser;
    try {
      return exampleUser
          .firstWhere((user) =>
              (user.telephone == telephone.trim()) &&
              (user.motDePasse == motDePasse))
          .copy();
    } catch (e) {
      throw ('Compte introuvable');
    }
  }

  Future<UserModel> create({
    @required UserModel user,
  }) async {
    await Future.delayed(Duration(seconds: 3));
    return user..id = Random().nextInt(500000).toString();
  }

  Future<UserModel> editUser(UserModel user) async {
    await Future.delayed(Duration(seconds: 2));
    return user.copy();
  }

  Future<void> logout() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persist() async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 5));
    return;
  }

  Future<UserModel> loggedInUser() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
