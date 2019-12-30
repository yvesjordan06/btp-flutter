import 'dart:math';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';
import 'package:meta/meta.dart';

import 'AnnoncesRepository.dart';

List<ChatModel> exampleChatList = List<ChatModel>.generate(
  10,
  (index1) => ChatModel(
    id: index1.toString(),
    contact: exampleUser[Random().nextInt(5)],
    annonceModel: annonces[Random().nextInt(5)],
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
      'Ok'
    ];
    while (true) {
      await Future.delayed(Duration(seconds: 5));
      yield NewMessageModel(
          MessageModel(
            id: Random().nextInt(2665).toString(),
            text: mes[Random().nextInt(5)],
            sender: true,
            sentAt: DateTime.now(),
          ),
          Random().nextInt(10).toString());
    }
  }
}
