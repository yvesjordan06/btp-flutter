import 'dart:convert';
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
    id: index1,
    annonceur: exampleUser[Random().nextInt(exampleUser.length)],
    annonceModel: annonces[Random().nextInt(annonces.length)],
    messages: List<MessageModel>.generate(
        8,
        (index) => MessageModel(
            id: index.toString(),
            text: 'message $index',
            //sender: index.isEven,
            sentAt: DateTime.now())),
  ),
);

class ChatsRepository {
  Future<List<ChatModel>> fetchAll() async {
    Response a;
    try {
      a = await chatApi
          .getChatsForAnnonceur(int.parse(authBloc.currentUser.id))
          .timeout(Duration(seconds: 30));
    } catch (e) {
      print('chat repo 33 $e');
    }

    if (!a.isSuccessful)
      throw 'Impossible d\'effectuer la demande actuellement';

    try {
      List<ChatModel> b = List.generate(
          a.body.length, (index) => ChatModel.fromJson(a.body[index]));
      return b;
    } catch (e) {
      print(' Chat repo $e');
      throw e;
    }

    await Future.delayed(Duration(seconds: 4));
    return List<ChatModel>.from(exampleChatList);
  }

  Future<MessageModel> send(
      {@required MessageModel message, @required int chatID}) async {
    assert(message != null && chatID != null);
    bool isImage = message.localImage != null;
    Response a;
    Map<String, dynamic> body = {
      "type": isImage ? "image" : "text",
      "id_annonceur": int.tryParse(message.annonceur?.id ?? 'a'),
      "id_travailleur": int.tryParse(message.travailleur?.id ?? 'a'),
      if (!isImage) "text": message.text,
      if (isImage)
        'id_annonce': int.parse(chatsBloc.list
            .firstWhere((test) => test.id == chatID)
            .annonceModel
            ?.id ??
            'a')
    };
    print(body);
    try {
      a = await chatApi.sendMessage(chatID, body);
      if (!a.isSuccessful) throw 'Error';
      Map<String, dynamic> decode = json.decode(a.body);
      message.id = decode['insert_id'].toString();
      if (isImage) {
        Response b = await chatApi.sendImage(
            int.parse(message.id), message.localImage.path);
        if (!b.isSuccessful) throw 'Image';
      }

      return message;
    } catch (e) {
      print("chat Repo 65 $e");
      throw 'Impossible d\'envoyer le message en ce moment';
    }
    /*  await Future.delayed(Duration(seconds: 2));
    ChatModel chat = exampleChatList.firstWhere((ch) => ch.id == chatID);
    message.id = Random().nextInt(2500).toString();
    chat.messages.add(message);
    return message; */
  }

/* Stream<NewMessageModel> recieve() async* {
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

    // Token generate with "mercure" JWT_KEY

    String hubUrl = "https://btp-partnership-merure.herokuapp.com/hub";
    String topic = "new-message";

    Mercure mercure = Mercure(
        token:
            'G1meHgz9daQp0mDoJ2xQanOWUajA1lERCDPAmBP2amnhaRcmiPnOm9vKBJ7gdjQFfY0=',
        hub_url: hubUrl);
    print('Mercure');
    mercure.subscribeTopic(
        topic: topic,
        onData: (Event event) {
          print('Mercure event');
          print(event.data);
          Map<String, dynamic> data = json.decode(event.data);
          try {
            NewMessageModel a = NewMessageModel.fromJson(data);
            print(a.chatID);
            
          } catch (e) {
            print('Mercure error $e');
          }
        });
    /* while (true) {
      await Future.delayed(Duration(seconds: 5));
      /* yield NewMessageModel(
          MessageModel(
            id: Random().nextInt(2665).toString(),
            text: mes[Random().nextInt(mes.length)],
            //sender: true,
            sentAt: DateTime.now(),
          ),
          Random().nextInt(exampleChatList.length).toString()); */
    } */
  }
 */
}
