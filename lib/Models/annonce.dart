class AnnonceModel {
  final String intitule;
  final String lieu;
  final String description;
  final DateTime createAt;


  AnnonceModel(this.intitule, this.description, this.createAt, this.lieu);
}

class TacheModel {
  final String intitule;
  final String metier;
  final String description;

  TacheModel(this.intitule, this.metier, this.description);
}

class UserModel {
  final String nom;
  final String prenom;
  final String telephone;
  // ignore: non_constant_identifier_names
  final String mot_de_passe;
  final DateTime dateDeNaissance;
  final String status;
  final String accountType;
  final String userType;

  UserModel(this.nom, this.prenom, this.dateDeNaissance, this.status, this.accountType, this.userType, this.telephone, this.mot_de_passe);

}

class AccountType {
  static final String particulier = 'Particulier';
  static final String entreprise = 'Entreprise';

}

class UserType {
  static final String annonceur = 'Annonceur';
  static final String travailleur = 'Travailleur';

  static String toggleType(String type) {
    if (type == annonceur) {
      return travailleur;
    }
    return annonceur;
  }
}

