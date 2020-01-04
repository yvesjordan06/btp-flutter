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

NewAnnonceModel _$NewAnnonceModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id_taxation']);
  return NewAnnonceModel(
    intitule: json['intitule'] as String,
    description: json['description'] as String,
    lieu: json['lieu'] as String,
    dateDebut: json['date_debut'] as String,
    dateFin: json['date_fin'] as String,
    taches: (json['taches'] as List)?.map((e) => e as int)?.toList(),
    idEntreprise: json['id_annonceur_entreprise'] as int,
    idParticulier: json['id_annonceur_particulier'] as int,
    etat: json['etat'] as String,
    idTaxation: json['id_taxation'] as int ?? 1,
  );
}

Map<String, dynamic> _$NewAnnonceModelToJson(NewAnnonceModel instance) =>
    <String, dynamic>{
      'intitule': instance.intitule,
      'lieu': instance.lieu,
      'description': instance.description,
      'date_debut': instance.dateDebut,
      'date_fin': instance.dateFin,
      'taches': instance.taches,
      'etat': instance.etat,
      'id_annonceur_entreprise': instance.idEntreprise,
      'id_annonceur_particulier': instance.idParticulier,
      'id_taxation': instance.idTaxation,
    };

AppStatusModel _$AppStatusModelFromJson(Map<String, dynamic> json) {
  return AppStatusModel(
    isfirstTime: json['isfirstTime'] as bool ?? true,
    currentUser: json['currentUser'] == null
        ? null
        : UserModel.fromJson(json['currentUser'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStatusModelToJson(AppStatusModel instance) =>
    <String, dynamic>{
      'isfirstTime': instance.isfirstTime,
      'currentUser': instance.currentUser,
    };

AnnonceModel _$AnnonceModelFromJson(Map<String, dynamic> json) {
  return AnnonceModel(
    intitule: json['intitule'] as String,
    description: json['description'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    lieu: json['lieu'] as String,
    dateDebut: json['date_debut'] == null
        ? null
        : DateTime.parse(json['date_debut'] as String),
    dateFin: json['date_fin'] == null
        ? null
        : DateTime.parse(json['date_fin'] as String),
    taches: (json['taches'] as List)
        ?.map((e) =>
            e == null ? null : TacheModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: _stringFromInt(json['id'] as int),
    annonceur: json['annonceur'] == null
        ? null
        : UserModel.fromJson(json['annonceur'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AnnonceModelToJson(AnnonceModel instance) =>
    <String, dynamic>{
      'id': _stringToInt(instance.id),
      'intitule': instance.intitule,
      'lieu': instance.lieu,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
      'taches': instance.taches,
      'annonceur': instance.annonceur,
    };

AuthenticationModel _$AuthenticationModelFromJson(Map<String, dynamic> json) {
  return AuthenticationModel(
    currentUser: json['currentUser'] == null
        ? null
        : UserModel.fromJson(json['currentUser'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$AuthenticationModelToJson(
        AuthenticationModel instance) =>
    <String, dynamic>{
      'currentUser': instance.currentUser,
      'token': instance.token,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: _stringFromInt(json['id'] as int),
    nom: json['nom'] as String,
    prenom: json['prenom'] as String,
    telephone: json['telephone'] as String,
    dateDeNaissance: json['date_de_naissance'] == null
        ? null
        : DateTime.parse(json['date_de_naissance'] as String),
    raisonSociale: json['raisonSociale'] as String,
    status: json['status'] as String,
    accountType: json['accountType'] as String,
    userType: json['userType'] as String,
    motDePasse: json['mot_de_passe'] as String,
    pictureLink: json['picture_link'] as String,
    pays: json['pays'] as String ?? 'Cameroun',
    ville: json['ville'] as String,
    quartier: json['quartier'] as String,
    boitePostal: json['boitePostal'] as String,
  )..createdAt = json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': _stringToInt(instance.id),
      'nom': instance.nom,
      'prenom': instance.prenom,
      'raisonSociale': instance.raisonSociale,
      'telephone': instance.telephone,
      'mot_de_passe': instance.motDePasse,
      'date_de_naissance': instance.dateDeNaissance?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'status': instance.status,
      'accountType': instance.accountType,
      'userType': instance.userType,
      'picture_link': instance.pictureLink,
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
    annonceur: json['annonceur'] == null
        ? null
        : UserModel.fromJson(json['annonceur'] as Map<String, dynamic>),
    travailleur: json['travailleur'] == null
        ? null
        : UserModel.fromJson(json['travailleur'] as Map<String, dynamic>),
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
      'annonceur': instance.annonceur,
      'travailleur': instance.travailleur,
      'annonceModel': instance.annonceModel,
      'messages': instance.messages,
      'unread': instance.unread,
    };

ActuModel _$ActuModelFromJson(Map<String, dynamic> json) {
  return ActuModel(
    id: json['id'] as int,
    intitule: json['intitule'] as String,
    lieu: json['lieu'] as String,
    pictures:
        (json['pictures_link'] as List)?.map((e) => e as String)?.toList(),
    date: json['date_realisation'] == null
        ? null
        : DateTime.parse(json['date_realisation'] as String),
    description: json['description'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$ActuModelToJson(ActuModel instance) => <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'lieu': instance.lieu,
      'pictures_link': instance.pictures,
      'date_realisation': instance.date?.toIso8601String(),
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
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
