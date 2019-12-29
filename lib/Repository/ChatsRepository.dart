import 'dart:math';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/UserRepository.dart';

import 'AnnoncesRepository.dart';

List<ChatModel> exampleChatList = List<ChatModel>.generate(
  10,
  (index1) => ChatModel(
    id: "id $index1",
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
