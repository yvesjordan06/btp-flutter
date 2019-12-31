import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'annonce.g.dart';

@JsonSerializable()
class TacheModel {
  final int id;
  final String intitule;
  final MetierModel metier;
  final String description;

  TacheModel({this.intitule, this.metier, this.description, this.id});

  factory TacheModel.fromJson(Map<String, dynamic> json) =>
      _$TacheModelFromJson(json);
  Map<String, dynamic> toJson() => _$TacheModelToJson(this);
}

@JsonSerializable()
class MetierModel {
  final int id;
  final String intitule;
  final String description;

  MetierModel({this.id, this.intitule, this.description});

  factory MetierModel.fromJson(Map<String, dynamic> json) =>
      _$MetierModelFromJson(json);
  Map<String, dynamic> toJson() => _$MetierModelToJson(this);
}

@JsonSerializable()
class AnnonceModel {
  String id = '';
  String intitule = '';
  String lieu = '';
  String description = '';
  DateTime createdAt;
  DateTime dateDebut;
  DateTime dateFin;
  List<TacheModel> taches = [];
  UserModel annonceur;

  AnnonceModel({
    this.intitule = '',
    this.description = '',
    this.createdAt,
    this.lieu = '',
    this.dateDebut,
    this.dateFin,
    this.taches,
    this.id = '',
    this.annonceur,
  });

  factory AnnonceModel.fromJson(Map<String, dynamic> json) =>
      _$AnnonceModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnnonceModelToJson(this);
}

@JsonSerializable()
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
  @JsonKey(ignore: true)
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

  UserModel copy() {
    return UserModel(
      id: this.id,
      nom: this.nom,
      prenom: this.prenom,
      telephone: this.telephone,
      dateDeNaissance: this.dateDeNaissance,
      status: this.status,
      accountType: this.accountType,
      userType: this.userType,
      motDePasse: this.motDePasse,
      localPicture: this.localPicture,
      pictureLink: this.pictureLink,
      pays: this.pays,
      ville: this.ville,
      quartier: this.quartier,
      boitePostal: this.boitePostal,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
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

@JsonSerializable()
class CategorieTacheModel {
  final int id;
  final String intitule;
  final String description;
  final List<TacheModel> taches;

  CategorieTacheModel({this.id, this.intitule, this.description, this.taches});

  factory CategorieTacheModel.fromJson(Map<String, dynamic> json) =>
      _$CategorieTacheModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategorieTacheModelToJson(this);
}

@JsonSerializable()
class MessageModel {
  String id;
  String text;
  String image;
  bool sender;
  DateTime sentAt;

  MessageModel(
      {this.id, this.text, this.image, this.sender = false, this.sentAt});

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
  final String id;
  final UserModel contact;
  final AnnonceModel annonceModel;
  //final MessageModel lastMessage;
  final List<MessageModel> messages;
  int unread = 0;

  ChatModel({this.id, this.contact, this.annonceModel, this.messages});

  MessageModel get lastMessage => messages.first;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

@JsonSerializable()
class ActuModel {
  String id;
  String intitule;
  String lieu;
  List<String> pictures;
  DateTime date;
  String description;
  @JsonKey(ignore: true)
  List<Asset> assetPictures;

  ActuModel({
    this.id,
    this.intitule,
    this.lieu,
    this.pictures,
    this.date,
    this.description,
  });

  factory ActuModel.fromJson(Map<String, dynamic> json) =>
      _$ActuModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActuModelToJson(this);
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
