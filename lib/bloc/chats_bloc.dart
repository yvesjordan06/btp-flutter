import 'dart:async';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/ChatsRepository.dart';
import 'package:btpp/utils/notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'bloc.dart';

class ChatsBloc extends HydratedBloc<ChatsEvent, ChatsState> {
  final ChatsRepository repo = ChatsRepository();
  final AuthenticationBloc authenticationBloc = authBloc;
  List<ChatModel> list = [];

  ChatsBloc() {
    repo.recieve().listen((newMessage) {
      try {
        authBloc.listen((event) {
          if (event is AuthenticationUnauthenticated) list = [];
        });
        ChatModel chat = list.firstWhere((ch) => ch.id == newMessage.chatID);
        chat.messages.insert(0, newMessage.message);
        chat.unread++;
        //print('unread ${chat.unread}');
        list = List.from(list);

        this.add(ChatsMessageRecieving(newMessage));
        showChatNotification(chat);
      } catch (e) {
       // print('not in chat');
      }
    });
  }

  @override
  ChatsState get initialState => super.initialState ?? InitialChatsState();

  @override
  Stream<ChatsState> mapEventToState(
    ChatsEvent event,
  ) async* {
    if (event is ChatsFetch) {
      yield ChatsFetchingState();
      try {
        list = await repo.fetchAll();

        list.sort(
            (m, m1) => m1.lastMessage.sentAt.compareTo(m.lastMessage.sentAt));
        yield ChatsFetchingSuccess(list);
      } catch (e) {
        yield ChatsFetchingFailed('Impossible de joindre le serveur');
      }
    }

    if (event is ChatsMessageRecieving) {
      yield ChatsMessageRecieved(event.newMessage);
      list.sort(
          (m, m1) => m1.lastMessage.sentAt.compareTo(m.lastMessage.sentAt));
      yield ChatsFetchingSuccess(list);
    }

    if (event is ChatsMessageSend) {
      yield ChatsSendingState();
      try {
        MessageModel a =
            await repo.send(message: event.message, chatID: event.chatID);
        list = list
          ..firstWhere((c) => c.id == event.chatID).messages.insert(0, a);

        list.sort(
            (m, m1) => m1.lastMessage.sentAt.compareTo(m.lastMessage.sentAt));
        yield ChatsFetchingSuccess(list);
      } catch (e) {
        yield ChatsFetchingFailed('Impossible de joindre le serveur');
      }
    }

    if (event is ChatsMessageRead) {
      ChatModel chat = list.firstWhere((ch) => ch.id == event.chatID);

      chat.unread = 0;
      list = List.from(list);
      yield ChatsFetchingSuccess(list);
    }
  }

  @override
  ChatsState fromJson(Map<String, dynamic> json) {
    try {
      list = ChatListModel.fromJson(json).list;
      return ChatsFetchingSuccess(list);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ChatsState state) {
    if (state is ChatsFetchingSuccess)
      return ChatListModel(state.chats).toJson();
    return null;
  }
}
