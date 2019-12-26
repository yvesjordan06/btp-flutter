import 'package:btpp/Models/annonce.dart';
import 'package:meta/meta.dart';

UserModel exampleUser = UserModel(
  id: '2251',
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
);

class UserRepository {
  Future<UserModel> authenticate({
    @required String telephone,
    @required String motDePasse,
    String type,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    // return exampleUser;
    if (telephone.trim().startsWith(RegExp(r'[6][7|2|6|9]')))
      return exampleUser;
    throw ('Votre numero de telephone n\'est pas Camerounais');
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
