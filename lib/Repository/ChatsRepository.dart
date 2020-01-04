import 'dart:math';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';
import 'package:btpp/api/chopper.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

import 'AnnoncesRepository.dart';

List<ChatModel> exampleChatList = List<ChatModel>.generate(
  10,
  (index1) => ChatModel(
    id: index1.toString(),
    annonceur: exampleUser[Random().nextInt(exampleUser.length)],
    annonceModel: annonces[Random().nextInt(annonces.length)],
    messages: List<MessageModel>.generate(
        8,
        (index) => MessageModel(
            id: index.toString(),
            text: 'message $index',
            sender: index.isEven,
            sentAt: DateTime.now())),
  ),
);

class ChatsRepository {
  Future<List<ChatModel>> fetchAll() async {
    Response a =
        await chatApi.getChatsForAnnonceur(int.parse(authBloc.currentUser.id));
    await Future.delayed(Duration(seconds: 4));
    return List<ChatModel>.from(exampleChatList);
  }

  Future<MessageModel> send(
      {@required MessageModel message, @required String chatID}) async {
    assert(message != null && chatID != null);
    await Future.delayed(Duration(seconds: 2));
    ChatModel chat = exampleChatList.firstWhere((ch) => ch.id == chatID);
    message.id = Random().nextInt(2500).toString();
    chat.messages.add(message);
    return message;
  }

  Stream<NewMessageModel> recieve() async* {
    List<String> mes = [
      'Bonjour',
      'tu vas bien ?',
      'J\'arrive bientot',
      'Je fini le travaille demain',
      'Ok',
      'Salut',
      'Oui merci',
      'Bonne année',
      'J\aime trop MOS',
      'Comment tu vas ?',
      'Je n\ai pas d\'argent actuellement',
      'Je veux postuler a cette annonce',
      'Je vous promet que je vais vous livrer dans les delais',
      'D\'ici le Dimanche 15 Janvier',
      'Tu sais bientot je compose',
      'J\'ai du travailler tout les congés pour avoir ce resultat',
      'Je vous envoie des message aleatoire',
      'Vous pensez a quoi',
      'Martial ne fete pas souvent ?',
      'Mon mignon je suis en 2020',
      'Bon bref ',
      'Merci pour votre confiance',
      'J\ai terminer le travail, veuillez me noter',
      'Je suis super enthousiaste',
      'Vous me perdez le temp disdonc'
    ];
    while (true) {
      await Future.delayed(Duration(seconds: 5));
      yield NewMessageModel(
          MessageModel(
            id: Random().nextInt(2665).toString(),
            text: mes[Random().nextInt(mes.length)],
            sender: true,
            sentAt: DateTime.now(),
          ),
          Random().nextInt(exampleChatList.length).toString());
    }
  }
}
