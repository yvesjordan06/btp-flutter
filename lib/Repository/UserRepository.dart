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
    Response a;

    try {
      if (type == null || type == 'annonceur')
        a = await authApi.annonceurLogin(
            {'telephone': telephone.trim(), 'mot_de_passe': motDePasse});

      if (type == 'travailleur' || a.statusCode == 404) {
        type = 'travailleur';
        a = await authApi.travailleurLogin(
            {'telephone': telephone.trim(), 'mot_de_passe': motDePasse});
      }

      if (!a.isSuccessful) throw 'json.decode(a.error)';
      print(a.body['annonceur'] ?? a.body['travailleur']);
      bool isTravailleur = a.body['travailleur'] != null;

      UserModel user =
          UserModel.fromJson(a.body['annonceur'] ?? a.body['travailleur']);

      if (isTravailleur)
        user = user.copyWith(
            metiers: List<MetierModel>.generate(a.body['metiers'].length,
                    (index) => MetierModel.fromJson(a.body['metiers'][index])));

      print('!!!! ${a.body['travailleur']}');
      print('!!!! ${user.cv}');
      print('!!!! ${user.metiers}');

      user.accountType = user.raisonSociale == null
          ? AccountType.particulier
          : AccountType.entreprise;

      user.userType =
          type == 'travailleur' ? UserType.travailleur : UserType.annonceur;
      //print('User repo 121 error ${user}');
      user.pictureLink = mainUrl + (user.pictureLink ?? '');
      return user;
    } catch (e) {
      print('User repo 121 error $e');
      throw e;
      if (e['code'] == 'NotFound') throw 'Telephone ou mot de passe incorrect';
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

  Future<UserModel> getUser(int id,
      {String usertype = UserType.annonceur,
      String accounttype = AccountType.particulier}) async {
    Response a;

    if (usertype == UserType.travailleur) {
      a = await authApi.getTravailleurById(id);
    } else if (usertype == UserType.annonceur) {
      if (accounttype == AccountType.particulier) {
        a = await authApi.getAnnonceurParticulierById(id);
      } else if (accounttype == AccountType.entreprise) {
        a = await authApi.getAnnonceurEntrepriseById(id);
      } else {
        throw 'Invalid accountype';
      }
    } else {
      throw 'Invalid usertype';
    }
    print('refresh result');
    print(a.body);
    print(a.error);
    if (!a.isSuccessful) throw 'Impossible de traiter la demande actuellement';
    return UserModel.fromJson(a.body)
      ..pictureLink = mainUrl + a.body['picture_link']
      ..userType = usertype
      ..accountType = accounttype;
  }

  Future<UserModel> create({
    @required UserModel user,
  }) async {
    Response a;
    Response b;

    try {
      print(user.accountType);
      switch (user.userType) {
        case UserType.travailleur:
          a = await authApi.createTravailleur(user.toJson());

          break;
        case UserType.annonceur:
          if (user.accountType == AccountType.particulier)
            a = await authApi.createAnnonceurParticulier(user.toJson());
          else
            a = await authApi.createAnnonceurEntreprises(user.toJson());
          break;
      }
      print(a.statusCode);
      print(a.error);
      print(a.body);
      if (!a.isSuccessful) throw a.error;
      if (a.body['result'] == 'exist') throw 'Ce compte existe deja';
      UserModel temp =
          UserModel.fromJson(a.body['travailleur'] ?? a.body['annonceur']);
      user.id = temp.id;

      if (user.localPicture != null) {
        switch (user.userType) {
          case UserType.travailleur:
            b = await authApi.changeTravailleurPicture(
                temp.idInt, user.localPicture.path);
            break;
          case UserType.annonceur:
            if (user.accountType == AccountType.particulier)
              b = await authApi.changeAnnonceurParticulierPicture(
                  temp.idInt, user.localPicture.path);
            else
              b = await authApi.changeAnnonceurEntreprisePicture(
                  temp.idInt, user.localPicture.path);
            break;
        }
      }
    } catch (e) {
      print('long 176 $e');
      throw e is String ? e : 'error';
    }
    //await Future.delayed(Duration(seconds: 3));
    // return user..id = Random().nextInt(500000).toString();
    return user;
  }

  Future<UserModel> editUser(UserModel user) async {
    Response a;
    //UserModel _user = authBloc.currentUser;

    try {
      if (user.accountType == AccountType.entreprise)
        a = await authApi
            .updateAnnonceurEntreprise(user.idInt, user.toJson())
            .timeout(Duration(seconds: 30));
      else if (user.userType == UserType.annonceur)
        a = await authApi
            .updateAnnonceurParticulier(user.idInt, user.toJson())
            .timeout(Duration(seconds: 30));
      else
        a = await authApi
            .updateTravailleur(user.idInt, user.toJson())
            .timeout(Duration(seconds: 30));
    } catch (e) {
      throw 'Erreur ';
    }
    if (!a.isSuccessful) throw 'Error';
    // await Future.delayed(Duration(seconds: 2));
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
    Response a = await authApi
        .changeAnnonceurParticulierPicture(int.parse(user.id), image)
        .timeout(Duration(seconds: 30));
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

  Future<List<MetierModel>> getMetiers() async {
    try {
      Response a = await authApi.getMetiers().timeout(Duration(seconds: 30));
      if (!a.isSuccessful) throw 'Error';
      return List<MetierModel>.generate(
        a.body.length,
        (index) {
          return MetierModel.fromJson(a.body[index]);
        },
      );
    } catch (e) {
      print('Metier Fetching error : $e');
    }
  }
}
