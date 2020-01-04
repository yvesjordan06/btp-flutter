import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/api/chopper.dart';

import 'package:chopper/chopper.dart';
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
    if (type == null || type == 'annonceur') {
      try {

        Response a = await authApi.annonceurLogin(
            {'telephone': telephone.trim(), 'mot_de_passe': motDePasse});


        if (!a.isSuccessful) throw json.decode(a.error);
        UserModel user = UserModel.fromJson(a.body['annonceur']);

        //print('User repo 121 error ${user}');

        user.accountType = user.raisonSociale == null
            ? AccountType.particulier
            : AccountType.entreprise;
        user.userType = UserType.annonceur;
        user.pictureLink = mainUrl + user.pictureLink;
        return user;
      } catch (e) {
        print('User repo 121 error $e');
        throw e;
        if (e['code'] == 'NotFound')
          throw 'Telephone ou mot de passe incorrect';
      }
    }



    /*  await Future.delayed(Duration(seconds: 1));
    // return exampleUser;
    try {
      return exampleUser
          .firstWhere((user) =>
              (user.telephone == telephone.trim()) &&
              (user.motDePasse == motDePasse))
          .copy();
    } catch (e) {
      throw ('Compte introuvable');
    } */
  }
  Future<UserModel> getUser(int id, {String usertype = UserType.annonceur, String accounttype = AccountType.particulier}) async {
    Response a;

    if (usertype == UserType.travailleur) {
      a = await authApi.getTravailleurById(id);
    } else if (usertype == UserType.annonceur) {
      if (accounttype == AccountType.particulier) {
        a = await authApi.getAnnonceurParticulierById(id);
      }else if(accounttype == AccountType.entreprise) {
        a = await authApi.getAnnonceurEntrepriseById(id);
      }else {
        throw 'Invalid accountype';
      }
    }else {
      throw 'Invalid usertype';
    }
    print('refresh result');
    print(a.body);
    print(a.error);
    if(!a.isSuccessful) throw 'Impossible de traiter la demande actuellement';
    return UserModel.fromJson(a.body)
      ..pictureLink=mainUrl+a.body['picture_link']
    ..userType = usertype
        ..accountType = accounttype;


  }
  Future<UserModel> create({
    @required UserModel user,
  }) async {
    await Future.delayed(Duration(seconds: 3));
    return user..id = Random().nextInt(500000).toString();
  }

  Future<UserModel> editUser(UserModel user) async {
    await Future.delayed(Duration(seconds: 2));
    return user;
  }

  Future<void> logout() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> changePicture(String image, UserModel user) async {
    /// write to keystore/keychain
    print('user repo 191 $image');
    Response a = await authApi.changeAnnonceurParticulierPicture(int.parse(user.id), image);
    print(a.headers);
    print(a.statusCode);
    print(a.error);
    return;
  }

  Future<UserModel> loggedInUser() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
