// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TacheModel _$TacheModelFromJson(Map<String, dynamic> json) {
  return TacheModel(
    intitule: json['intitule'] as String,
    metier: json['metier'] == null
        ? null
        : MetierModel.fromJson(json['metier'] as Map<String, dynamic>),
    description: json['description'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$TacheModelToJson(TacheModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'metier': instance.metier,
      'description': instance.description,
    };

MetierModel _$MetierModelFromJson(Map<String, dynamic> json) {
  return MetierModel(
    id: json['id'] as int,
    intitule: json['intitule'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$MetierModelToJson(MetierModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'description': instance.description,
    };

AnnonceModel _$AnnonceModelFromJson(Map<String, dynamic> json) {
  return AnnonceModel(
    intitule: json['intitule'] as String,
    description: json['description'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    lieu: json['lieu'] as String,
    dateDebut: json['dateDebut'] == null
        ? null
        : DateTime.parse(json['dateDebut'] as String),
    dateFin: json['dateFin'] == null
        ? null
        : DateTime.parse(json['dateFin'] as String),
    taches: (json['taches'] as List)
        ?.map((e) =>
            e == null ? null : TacheModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
    annonceur: json['annonceur'] == null
        ? null
        : UserModel.fromJson(json['annonceur'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AnnonceModelToJson(AnnonceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'lieu': instance.lieu,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'dateDebut': instance.dateDebut?.toIso8601String(),
      'dateFin': instance.dateFin?.toIso8601String(),
      'taches': instance.taches,
      'annonceur': instance.annonceur,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    nom: json['nom'] as String,
    prenom: json['prenom'] as String,
    telephone: json['telephone'] as String,
    dateDeNaissance: json['dateDeNaissance'] == null
        ? null
        : DateTime.parse(json['dateDeNaissance'] as String),
    status: json['status'] as String,
    accountType: json['accountType'] as String,
    userType: json['userType'] as String,
    motDePasse: json['motDePasse'] as String,
    pictureLink: json['pictureLink'] as String,
    pays: json['pays'] as String,
    ville: json['ville'] as String,
    quartier: json['quartier'] as String,
    boitePostal: json['boitePostal'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'telephone': instance.telephone,
      'motDePasse': instance.motDePasse,
      'dateDeNaissance': instance.dateDeNaissance?.toIso8601String(),
      'status': instance.status,
      'accountType': instance.accountType,
      'userType': instance.userType,
      'pictureLink': instance.pictureLink,
      'pays': instance.pays,
      'ville': instance.ville,
      'quartier': instance.quartier,
      'boitePostal': instance.boitePostal,
    };

AnnonceListModel _$AnnonceListModelFromJson(Map<String, dynamic> json) {
  return AnnonceListModel(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : AnnonceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AnnonceListModelToJson(AnnonceListModel instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

CategorieTacheModel _$CategorieTacheModelFromJson(Map<String, dynamic> json) {
  return CategorieTacheModel(
    id: json['id'] as int,
    intitule: json['intitule'] as String,
    description: json['description'] as String,
    taches: (json['taches'] as List)
        ?.map((e) =>
            e == null ? null : TacheModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategorieTacheModelToJson(
        CategorieTacheModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'description': instance.description,
      'taches': instance.taches,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    id: json['id'] as String,
    text: json['text'] as String,
    image: json['image'] as String,
    sender: json['sender'] as bool,
    sentAt: json['sentAt'] == null
        ? null
        : DateTime.parse(json['sentAt'] as String),
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'sender': instance.sender,
      'sentAt': instance.sentAt?.toIso8601String(),
    };

NewMessageModel _$NewMessageModelFromJson(Map<String, dynamic> json) {
  return NewMessageModel(
    json['message'] == null
        ? null
        : MessageModel.fromJson(json['message'] as Map<String, dynamic>),
    json['chatID'] as String,
  );
}

Map<String, dynamic> _$NewMessageModelToJson(NewMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'chatID': instance.chatID,
    };

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    id: json['id'] as String,
    contact: json['contact'] == null
        ? null
        : UserModel.fromJson(json['contact'] as Map<String, dynamic>),
    annonceModel: json['annonceModel'] == null
        ? null
        : AnnonceModel.fromJson(json['annonceModel'] as Map<String, dynamic>),
    messages: (json['messages'] as List)
        ?.map((e) =>
            e == null ? null : MessageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..unread = json['unread'] as int;
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'contact': instance.contact,
      'annonceModel': instance.annonceModel,
      'messages': instance.messages,
      'unread': instance.unread,
    };

ActuModel _$ActuModelFromJson(Map<String, dynamic> json) {
  return ActuModel(
    id: json['id'] as String,
    intitule: json['intitule'] as String,
    lieu: json['lieu'] as String,
    pictures: (json['pictures'] as List)?.map((e) => e as String)?.toList(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$ActuModelToJson(ActuModel instance) => <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'lieu': instance.lieu,
      'pictures': instance.pictures,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
    };

ActuListModel _$ActuListModelFromJson(Map<String, dynamic> json) {
  return ActuListModel(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ActuModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActuListModelToJson(ActuListModel instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) {
  return ChatListModel(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ChatModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatListModelToJson(ChatListModel instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
