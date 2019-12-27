import 'dart:io';

class AnnonceModel {
  String id = '';
  String intitule = '';
  String lieu = '';
  String description = '';
  DateTime createdAt;
  DateTime dateDebut;
  DateTime dateFin;
  List<TacheModel> taches = [];

  AnnonceModel({
    this.intitule = '',
    this.description = '',
    this.createdAt,
    this.lieu = '',
    this.dateDebut,
    this.dateFin,
    this.taches,
    this.id = '',
  });
}

class TacheModel {
  final int id;
  final String intitule;
  final MetierModel metier;
  final String description;

  TacheModel({this.intitule, this.metier, this.description, this.id});
}

class MetierModel {
  final int id;
  final String intitule;
  final String description;

  MetierModel({this.id, this.intitule, this.description});
}

class UserModel {
  String id = '';
  String nom = '';
  String prenom = '';
  String telephone = '';
  String motDePasse = '';
  DateTime dateDeNaissance;
  String status = '';
  String accountType = '';
  String userType = '';
  File localPicture;
  String pictureLink = '';
  String pays = '';
  String ville = '';
  String quartier = '';
  String boitePostal = '';

  UserModel({
    this.id = '',
    this.nom = '',
    this.prenom = '',
    this.telephone = '',
    this.dateDeNaissance,
    this.status = '',
    this.accountType = '',
    this.userType = '',
    this.motDePasse = '',
    this.localPicture,
    this.pictureLink = '',
    this.pays = '',
    this.ville = '',
    this.quartier = '',
    this.boitePostal = '',
  });

  @override
  String toString() {
    return 'id :$id, type: $userType, name: $nom';
  }
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

class CategorieTacheModel {
  final int id;
  final String intitule;
  final String description;
  final List<TacheModel> taches;

  CategorieTacheModel({this.id, this.intitule, this.description, this.taches});
}

MetierModel metier1 =
    MetierModel(intitule: 'Macon', description: 'Metier de maconnerie', id: 1);
MetierModel metier2 = MetierModel(
    intitule: 'Acoustique', description: 'Metier de Acoustique', id: 2);
MetierModel metier3 = MetierModel(
    intitule: 'Carreleur', description: 'Metier de Carreleur', id: 3);
MetierModel metier4 =
    MetierModel(intitule: 'Peintre', description: 'Metier de Peintre', id: 4);

TacheModel tache1 = TacheModel(
    intitule: 'Tache1', description: 'Description de la tache une 1', id: 1);
TacheModel tache2 = TacheModel(
    intitule: 'Tache2', description: 'Description de la tache une 2', id: 2);
TacheModel tache3 = TacheModel(
    intitule: 'Tache3', description: 'Description de la tache une 3', id: 3);
TacheModel tache4 = TacheModel(
    intitule: 'Tache4', description: 'Description de la tache une 4', id: 4);
TacheModel tache5 = TacheModel(
    intitule: 'Tache5', description: 'Description de la tache une 5', id: 5);
TacheModel tache6 = TacheModel(
    intitule: 'Tache6', description: 'Description de la tache une 6', id: 6);
TacheModel tache7 = TacheModel(
    intitule: 'Tache7', description: 'Description de la tache une 7', id: 7);
TacheModel tache8 = TacheModel(
    intitule: 'Tache8', description: 'Description de la tache une 8', id: 8);

CategorieTacheModel cat1 = CategorieTacheModel(
    id: 1,
    intitule: 'Gros oeuvre',
    description: 'Ceci est une description',
    taches: [tache1, tache2]);
CategorieTacheModel cat2 = CategorieTacheModel(
    id: 1,
    intitule: 'Second oeuvre',
    description: 'Ceci est une autre description',
    taches: [tache3, tache4]);
CategorieTacheModel cat3 = CategorieTacheModel(
    id: 1,
    intitule: 'Troisieme oeuvre',
    description: 'Ceci est une chose final',
    taches: [tache5, tache6]);
CategorieTacheModel cat4 = CategorieTacheModel(
    id: 1,
    intitule: 'Final oeuvre',
    description: 'Ceci est une autre',
    taches: [tache7, tache8]);
List<CategorieTacheModel> exampleCat = [cat1, cat2, cat3, cat4];

List<TacheModel> exampleTache = [];
