import 'package:btpp/Models/annonce.dart';
import 'package:btpp/api/chopper.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

List<AnnonceModel> annonces = [
  AnnonceModel(
    intitule: 'Maison de Osakas',
    description: 'Je veux une maison dans osaka au japon',
    createdAt: DateTime(2006),
    lieu: 'Japon, Tokyo',
    id: '1',
  ),
  AnnonceModel(
    intitule:
        'Imeuble Rouge a very long title to this annonce is made by me to test the following behaviors',
    description:
        'If i pass the more than 3  again it is not sufficient for all those lineslines it becomes an overflow and i dont know what will happen I do speak some english and chinese but i really prefere to be an engineer because here it is not easy to get work',
    createdAt: DateTime(2014),
    lieu: 'USA, New York',
    id: '2',
  ),
  AnnonceModel(
    intitule: 'Macabo Bar',
    description: 'J\'ai rien a dire',
    createdAt: DateTime(2018),
    lieu: 'Bamenda, my17',
    id: '3',
  ),
  AnnonceModel(
    intitule: 'Gratte cielle',
    description:
        'Je ne sais pas ce que je veux mais je suis tres fort avec les gens quand je commence a travailler',
    createdAt: DateTime(2020),
    lieu: 'Japon, Tokyo',
    id: '4',
  ),
  AnnonceModel(
    intitule: 'Masonnerie',
    description: 'Je suis un maçon tres veillant et je cherche un emploie',
    createdAt: DateTime(2019),
    lieu: 'Yaounde, Tokyo',
    id: '5',
  ),
  AnnonceModel(
    intitule: 'Masonnerie',
    description: 'Je suis un maçon tres veillant et je cherche un emploie',
    createdAt: DateTime(2019),
    lieu: 'Yaounde, Tokyo',
    id: '6',
  ),
  AnnonceModel(
    intitule: 'Masonnerie',
    description: 'Je suis un maçon tres veillant et je cherche un emploie',
    createdAt: DateTime(2019),
    lieu: 'Yaounde, Tokyo',
    id: '7',
  ),
]; // Annonces de l'api

class AnnoncesRepository {
  /// Recupere toute les annonces

  Future<List<AnnonceModel>> fetchAll() async {
    Response a;
    UserModel user = authBloc.currentUser;
    try {
      if (user.accountType == AccountType.entreprise)
        a = await annonceApi
            .getAnnonceByEntreprise(user.idInt)
            .timeout(Duration(seconds: 30));
      else if (user.userType == UserType.annonceur)
        a = await annonceApi
            .getAnnonceByParticulier(user.idInt)
            .timeout(Duration(seconds: 30));
      else
        a = await annonceApi
            .getAnnoncesForTravailleur(user.idInt)
            .timeout(Duration(seconds: 30));
    } catch (e) {
      debugPrint(
          '!!! Annonce repository: FetchAll Status in Error : ${a.statusCode}');
      throw 'Erreur ';
    }
    debugPrint('!!! Annonce repository: FetchAll Status : ${a.statusCode}');
    if (!a.isSuccessful) throw 'Error';
    AnnonceListModel b = AnnonceListModel(List<AnnonceModel>.generate(
        a.body.length,
        (index) => AnnonceModel.fromJson(a.body[index]['annonce'])));

    int index = 0;
    for (AnnonceModel annonce in b.list) {
      List taches = a.body[index]['taches'];
      annonce.taches = List<TacheModel>.generate(
          taches.length, (index2) => TacheModel.fromJson(taches[index2]));
      index++;
    }
    // print(b);
    return b.list;
    return Future.delayed(
        Duration(seconds: 4), () => List<AnnonceModel>.of(annonces));
  }

  /// Recupere toute les d'un utilisateur (travailleur) en parametre
  Future<List<AnnonceModel>> fetchMyOwn(UserModel user) async {
    await Future.delayed(Duration(seconds: 4));
    return annonces.where((annonce) => annonce.id == user.id);
  }

  /// Ajouter une annonces
  Future<AnnonceModel> create(AnnonceModel annonce) async {
    if (authBloc.currentUser.accountType == AccountType.entreprise)
      annonce.idAnnonceurEntreprise = authBloc.currentUser.idInt;
    else
      annonce.idAnnonceurParticulier = authBloc.currentUser.idInt;
    annonce.createdAt = DateTime.now();
    print(annonce.annonceur.id);
    try {
      annonce.makeNew();
      print(annonce.makeNew().toJson());
    } catch (e) {
      print(e);
    }

    Response body;
    if (authBloc.currentUser.accountType == AccountType.entreprise)
      body = await annonceApi.postAnnonceEntreprise(annonce.makeNew().toJson());
    else
      body =
          await annonceApi.postAnnonceParticulier(annonce.makeNew().toJson());
    if (!body.isSuccessful) {
      print(body.error);
      throw ' Impossible d\'effectuer votre demande a cette instant';
    }

    return AnnonceModel.fromJson(body.body['annonce'])
      ..taches = List<TacheModel>.generate(body.body['taches'].length,
          (index2) => TacheModel.fromJson(body.body['taches'][index2]));
  }

  /// Retirer une annonces
  Future delete(AnnonceModel annonce) async {
    await Future.delayed(Duration(seconds: 4));
    return annonces..removeWhere((ann) => ann.id == annonce.id);
  }

  /// Modifier une annonces
  Future<AnnonceModel> update(AnnonceModel annonce) async {
    await Future.delayed(Duration(seconds: 4));
    int index = annonces.indexWhere((ann) => ann.id == annonce.id);
    annonces[index] = annonce;
    return annonce;
  }

  /// Postuler a une annonces
  Future<ChatModel> postule(
      UserModel user, AnnonceModel annonce, List<int> taches) async {
    Response a;

    try {
      a = await annonceApi.postuler({
        "id_travailleur": user.idInt,
        "id_annonceur": annonce.annonceur.idInt,
        "id_annonce": int.parse(annonce.id),
        "ids_taches": taches
      });
      if (!a.isSuccessful) throw 'Impossible de postuler';
      ChatModel chat = ChatModel.fromJson(a.body);
      chatsBloc.add(ChatsAddNew(chat));
      return chat;
    } catch (e) {
      print("Annonce Repo 157 Error : $e");
      throw 'Impossible de postuler';
    }
  }

  /// Attribuer les taches d'une annonce a un travailleur
  Future<void> attribuer(
      UserModel user, AnnonceModel annonce, List<int> taches) async {
    Response a;
    try {
      a = await annonceApi.attribuer({
        "idannonce": int.parse(annonce.id),
        "idtravailleur": user.idInt,
        "date_attribution": DateTime.now().toIso8601String(),
        "taches": taches
      });
      if (!a.isSuccessful)
        throw 'Impossible d\'attribuer les taches actuellement';
    } catch (e) {
      print("Annonce Repo 157 Error : $e");
      throw e is String ? e : 'Operation impossible actuellement';
    }
  }
}
