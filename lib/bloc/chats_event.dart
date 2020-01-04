import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();
}

class ChatsFetch extends ChatsEvent {
  @override
  List<Object> get props => null;
}

class ChatsMessageRecieving extends ChatsEvent {
  final NewMessageModel newMessage;

  ChatsMessageRecieving(this.newMessage);

  @override
  List<Object> get props => null;
}

class ChatsMessageSend extends ChatsEvent {
  final MessageModel message;
  final String chatID;

  ChatsMessageSend({this.message, this.chatID});

  @override
  List<Object> get props => null;
}

class ChatsMessageRead extends ChatsEvent {
  final String chatID;

  ChatsMessageRead({this.chatID});

  @override
  List<Object> get props => null;
}
