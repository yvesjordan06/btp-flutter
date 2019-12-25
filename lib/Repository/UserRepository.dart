import 'package:btpp/Models/annonce.dart';
import 'package:meta/meta.dart';

UserModel exampleUser = UserModel(
    nom: 'Hiro',
    prenom: 'Hamada',
    dateDeNaissance: DateTime.now(),
    status: 'status',
    accountType: AccountType.particulier,
    userType: UserType.annonceur,
    telephone: '694842185',
    motDePasse: '123456');

class UserRepository {
  Future<UserModel> authenticate({
    @required String username,
    @required String password,
    String type,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return exampleUser;
  }

  Future<void> logout() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persist() async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<UserModel> loggedInUser() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 5));
    return null;
  }
}
