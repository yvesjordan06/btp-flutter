import 'dart:io';

import 'package:btpp/bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'cv.model.dart';

part 'annonce.g.dart';

@JsonSerializable()
class TacheModel {
  final int id;
  final String intitule;
  MetierModel get metier => null;
  final String description;
  @JsonKey(name: 'categorie_tache')
  final CategorieTacheModel categorie;

  TacheModel({this.intitule, this.description, this.id, this.categorie});

  factory TacheModel.fromJson(Map<String, dynamic> json) =>
      _$TacheModelFromJson(json);

  Map<String, dynamic> toJson() => _$TacheModelToJson(this);
}

@JsonSerializable()
class MetierModel {
  final int id;
  final String intitule;
  final String description;
  final List<TacheModel> taches;

  MetierModel(this.taches, {this.id, this.intitule, this.description});

  factory MetierModel.fromJson(Map<String, dynamic> json) =>
      _$MetierModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetierModelToJson(this);
}

int _stringToInt(String number) =>
    (number == null) || number.isEmpty ? null : int.parse(number);

String _stringFromInt(int number) {
  //print(number);
  return number.toString();
}

@JsonSerializable()
class NewAnnonceModel {
  final String intitule;
  final String lieu;
  final String description;

  @JsonKey(name: 'date_debut')
  final String dateDebut;
  @JsonKey(name: 'date_fin')
  final String dateFin;
  List<int> taches;
  final String etat;
  @JsonKey(name: 'id_annonceur_entreprise', nullable: true)
  final int idEntreprise;
  @JsonKey(name: 'id_annonceur_particulier', nullable: true)
  final int idParticulier;
  @JsonKey(name: 'id_taxation', defaultValue: 1, required: true)
  final int idTaxation;

  NewAnnonceModel({
    this.intitule = '',
    this.description = '',
    //this.createdAt,
    this.lieu = '',
    this.dateDebut,
    this.dateFin,
    this.taches,
    this.idEntreprise,
    this.idParticulier,
    this.etat = 'encours',
    this.idTaxation = 0,
  });

  factory NewAnnonceModel.fromJson(Map<String, dynamic> json) =>
      _$NewAnnonceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewAnnonceModelToJson(this);
}

@JsonSerializable()
class AppStatusModel {
  @JsonKey(defaultValue: true)
  final bool isfirstTime;
  final UserModel currentUser;
  final List<MetierModel> appMetier;

  AppStatusModel({this.isfirstTime = true, this.currentUser, this.appMetier});

  copyWith(
      {bool isfirstTime, UserModel currentUser, List<MetierModel> appMetier}) {
    return AppStatusModel(
        isfirstTime: isfirstTime ?? this.isfirstTime,
        currentUser: currentUser ?? this.currentUser,
        appMetier: appMetier ?? this.appMetier);
  }

  bool isLoggedin() {
    return (currentUser != null) && (currentUser.id != null);
  }

  factory AppStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AppStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppStatusModelToJson(this);
}

@JsonSerializable()
class AnnonceModel {
  @JsonKey(fromJson: _stringFromInt, toJson: _stringToInt)
  String id;
  String intitule;
  String lieu;
  String description;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'date_debut')
  DateTime dateDebut;
  @JsonKey(name: 'date_fin')
  DateTime dateFin;
  @JsonKey(name: 'id_annonceur_entreprise')
  int idAnnonceurEntreprise;
  @JsonKey(name: 'id_annonceur_particulier')
  int idAnnonceurParticulier;
  List<TacheModel> taches;
  UserModel get annonceur => idAnnonceurEntreprise != null
      ? UserModel(
          userType: UserType.annonceur,
          accountType: AccountType.entreprise,
          id: idAnnonceurEntreprise.toString())
      : UserModel(
          userType: UserType.annonceur,
          accountType: AccountType.particulier,
          id: idAnnonceurParticulier.toString());

  AnnonceModel({
    this.intitule = '',
    this.description = '',
    this.createdAt,
    this.lieu = '',
    this.dateDebut,
    this.dateFin,
    this.taches,
    this.id = '',
    //this.annonceur,
    this.idAnnonceurEntreprise,
    this.idAnnonceurParticulier,
  });

  NewAnnonceModel makeNew() {
    return NewAnnonceModel(
      intitule: intitule,
      description: description,
      lieu: lieu,
      dateDebut: dateDebut.toString(),
      dateFin: dateFin.toString(),
      idParticulier: annonceur.accountType == AccountType.particulier
          ? int.tryParse(annonceur.id)
          : null,
      idEntreprise: annonceur.accountType == AccountType.entreprise
          ? int.tryParse(annonceur.id)
          : null,
      idTaxation: annonceur.accountType == AccountType.particulier ? 1 : 2,
      taches: List<int>.generate(taches.length, (index) => taches[index].id),
    );
  }

  bool get isExpired => dateFin.isBefore(DateTime.now());

  String get expiresIn {
    Duration d = dateFin.difference(DateTime.now());
    if (d.inDays < 0) return 'Obselete';
    if (d.inDays == 1) return "1 Jour";
    if (d.inDays < 1) return 'Avant demain';
    return "${d.inDays} Jours";
  }

  factory AnnonceModel.fromJson(Map<String, dynamic> json) =>
      _$AnnonceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnnonceModelToJson(this);
}

@JsonSerializable()
class AuthenticationModel {
  UserModel currentUser;
  String token;

  AuthenticationModel({this.currentUser, this.token});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(fromJson: _stringFromInt, toJson: _stringToInt)
  String id;
  String email;
  String nom = '';
  String prenom = '';
  @JsonKey(name: 'raison_sociale')
  String raisonSociale = '';
  String telephone = '';
  @JsonKey(name: 'mot_de_passe')
  String motDePasse = '';
  @JsonKey(name: 'date_de_naissance')
  DateTime dateDeNaissance;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  String status = '';
  String accountType = '';
  String userType = '';
  @JsonKey(ignore: true)
  File localPicture;
  @JsonKey(name: 'picture_link')
  String pictureLink = '';
  @JsonKey(defaultValue: 'Cameroun')
  String pays = '';
  String ville = '';
  String quartier = '';
  @JsonKey(name: 'boite_postale')
  String boitePostal = '';
  @JsonKey(nullable: true)
  final CVModel cv;
  @JsonKey(nullable: true)
  final List<MetierModel> metiers;

  UserModel({this.id = '',
    this.nom = '',
    this.prenom = '',
    this.telephone = '',
    this.dateDeNaissance,
    this.raisonSociale,
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
    this.createdAt,
    this.email,
    this.cv,
    this.metiers});

  String get name => (raisonSociale) ?? (nom + ' ' + prenom);

  String get address => ville + ',' + (boitePostal ?? quartier);

  String get type => (userType ?? 'No type') + ' ' + (accountType ?? 'No type');

  int get idInt => int.tryParse(id);

  String get birthday => dateDeNaissance != null
      ? DateFormat.yMMMd().format(dateDeNaissance)
      : null;

  @override
  String toString() {
    return 'nom :$name, address: $address, type: $type , birthday: $birthday';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String id,
    String email,
    String nom,
    String prenom,
    String raisonSociale,
    String telephone,
    String motDePasse,
    DateTime dateDeNaissance,
    DateTime createdAt,
    String status,
    String accountType,
    String userType,
    File localPicture,
    String pictureLink,
    String pays,
    String ville,
    String quartier,
    String boitePostal,
    CVModel cv,
    List<MetierModel> metiers,
  }) {
    return UserModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      raisonSociale: raisonSociale ?? this.raisonSociale,
      telephone: telephone ?? this.telephone,
      motDePasse: motDePasse ?? this.motDePasse,
      dateDeNaissance: dateDeNaissance ?? this.dateDeNaissance,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      accountType: accountType ?? this.accountType,
      userType: userType ?? this.userType,
      localPicture: localPicture ?? this.localPicture,
      pictureLink: pictureLink ?? this.pictureLink,
      pays: pays ?? this.pays,
      ville: ville ?? this.ville,
      quartier: quartier ?? this.quartier,
      boitePostal: boitePostal ?? this.boitePostal,
      email: email ?? this.email,
      metiers: metiers ?? this.metiers,
      cv: cv ?? this.cv,
    );
  }
}

@JsonSerializable()
class AnnonceListModel {
  final List<AnnonceModel> list;

  AnnonceListModel(this.list);

  factory AnnonceListModel.fromJson(Map<String, dynamic> json) =>
      _$AnnonceListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnnonceListModelToJson(this);
}

class AccountType {
  static const String particulier = 'Particulier';
  static const String entreprise = 'Entreprise';
}

class UserType {
  static const String annonceur = 'Annonceur';
  static const String travailleur = 'Travailleur';

  static String toggleType(String type) {
    if (type == annonceur) {
      return travailleur;
    }
    return annonceur;
  }
}

@JsonSerializable()
class CategorieTacheModel {
  final int id;
  final String intitule;
  final String description;
  List<TacheModel> taches = [];

  CategorieTacheModel({this.id, this.intitule, this.description}) : taches = [];

  factory CategorieTacheModel.fromJson(Map<String, dynamic> json) =>
      _$CategorieTacheModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategorieTacheModelToJson(this);
}

@JsonSerializable()
class MessageModel {
  @JsonKey(fromJson: _stringFromInt, toJson: _stringToInt)
  String id;
  String text;
  UserModel travailleur;
  UserModel annonceur;
  String image;
  @JsonKey(ignore: true)
  File localImage;

  bool get sender {
    return (authBloc.currentUser.userType == UserType.annonceur &&
            annonceur == null) ||
        (authBloc.currentUser.userType == UserType.travailleur &&
            travailleur == null);
  }

  @JsonKey(name: 'datePost')
  DateTime sentAt;

  MessageModel(
      {this.id,
      this.text,
      this.image,
      this.annonceur,
      this.travailleur,
      this.sentAt});

  bool get hasImage => image != null || localImage != null;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

@JsonSerializable()
class NewMessageModel {
  final MessageModel message;
  final String chatID;

  NewMessageModel(this.message, this.chatID);

  factory NewMessageModel.fromJson(Map<String, dynamic> json) =>
      _$NewMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewMessageModelToJson(this);
}

@JsonSerializable()
class ChatModel {
  final int id;

  //final UserModel contact;
  final UserModel annonceur;
  final UserModel travailleur;
  @JsonKey(name: 'annonce')
  final AnnonceModel annonceModel;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<TacheModel> taches;

  //final MessageModel lastMessage;
  final List<MessageModel> messages;
  @JsonKey(defaultValue: 0)
  int unread = 0;

  ChatModel(
      {this.id,
      this.taches,
      this.annonceur,
      this.travailleur,
      this.annonceModel,
      this.messages,
      this.createdAt});

  MessageModel get lastMessage => (messages != null && messages.length > 0)
      ? messages.last
      : MessageModel(sentAt: DateTime(1990), text: 'Aucun Echage');

  UserModel get contact => annonceur ?? travailleur;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

@JsonSerializable()
class ActuModel {
  int id;
  String intitule;
  String lieu;
  @JsonKey(name: 'pictures_link')
  List<String> pictures;
  @JsonKey(name: 'date_realisation')
  DateTime date;
  String description;
  @JsonKey(ignore: true)
  List<Asset> assetPictures;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  ActuModel(
      {this.id,
      this.intitule,
      this.lieu,
      this.pictures,
      this.date,
      this.description,
      this.createdAt});

  factory ActuModel.fromJson(Map<String, dynamic> json) =>
      _$ActuModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActuModelToJson(this);
}

@JsonSerializable()
class ActuListModel {
  final List<ActuModel> list;

  ActuListModel(this.list);

  factory ActuListModel.fromJson(Map<String, dynamic> json) =>
      _$ActuListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActuListModelToJson(this);
}

@JsonSerializable()
class ChatListModel {
  final List<ChatModel> list;

  ChatListModel(this.list);

  factory ChatListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatListModelToJson(this);
}
