import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
}

class InitialChatsState extends ChatsState {
  @override
  List<Object> get props => [];
}

class ChatsFetchingState extends ChatsState {
  @override
  List<Object> get props => [];
}

class ChatsFetchingSuccess extends ChatsState {
  final List<ChatModel> chats;

  ChatsFetchingSuccess(this.chats);

  @override
  List<Object> get props => [chats, chats.hashCode];
}

class ChatsFetchingFailed extends ChatsState {
  final String error;

  ChatsFetchingFailed(this.error);

  @override
  List<Object> get props => [error];
}

class ChatsSendingState extends ChatsState {
  @override
  List<Object> get props => [];
}

class ChatsSendingSuccess extends ChatsState {
  final List<ChatModel> chats;

  ChatsSendingSuccess(this.chats);

  @override
  List<Object> get props => [chats];
}

class ChatsSendingFailed extends ChatsState {
  final String error;

  ChatsSendingFailed(this.error);

  @override
  List<Object> get props => [error];
}

class ChatsMessageRecieved extends ChatsState {
  final NewMessageModel newMessage;

  ChatsMessageRecieved(this.newMessage);

  @override
  List<Object> get props => [newMessage];
}
