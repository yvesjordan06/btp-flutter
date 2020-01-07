import 'package:btpp/Models/annonce.dart';
import 'package:btpp/api/chopper.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:chopper/chopper.dart';

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
  Response a;
  Future<List<AnnonceModel>> fetchAll() async {
    try {
      a = await annonceApi
          .getAnnonceByParticulier(int.parse(authBloc.currentUser.id))
          .timeout(Duration(seconds: 30));
    } catch (e) {
      throw 'Erreur ';
    }
    if (!a.isSuccessful) throw 'Error';
    AnnonceListModel b = AnnonceListModel(List<AnnonceModel>.generate(
        a.body.length,
        (index) => AnnonceModel.fromJson(a.body[index]['annonce'])));
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
    annonce.annonceur = authBloc.currentUser;
    annonce.createdAt = DateTime.now();
    print(annonce.annonceur.id);
    try {
      annonce.makeNew();
      print(annonce.makeNew().toJson());
    } catch (e) {
      print(e);
    }

    Response body =
        await annonceApi.postAnnonceParticulier(annonce.makeNew().toJson());
    if (!body.isSuccessful)
      throw ' Impossible d\'effectuer votre demande a cette instant';

    return AnnonceModel.fromJson(body.body['annonce']);
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
  Future postule(UserModel user, AnnonceModel annonce, List<int> taches) async {
    await Future.delayed(Duration(seconds: 4));
    int index = annonces.indexWhere((ann) => ann.id == annonce.id);
    annonces[index] = annonce;
    return annonces;
  }

  /// Attribuer les taches d'une annonce a un travailleur
  Future attribuer(
      UserModel user, AnnonceModel annonce, List<int> taches) async {
    await Future.delayed(Duration(seconds: 4));
    int index = annonces.indexWhere((ann) => ann.id == annonce.id);
    annonces[index] = annonce;
    return annonces;
  }
}
