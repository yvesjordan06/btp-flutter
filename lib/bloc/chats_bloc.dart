import 'dart:async';
import 'dart:convert';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/ChatsRepository.dart';
import 'package:btpp/utils/notifications.dart';
import 'package:dart_mercure/dart_mercure.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'bloc.dart';

class ChatsBloc extends HydratedBloc<ChatsEvent, ChatsState> {
  final ChatsRepository repo = ChatsRepository();
  final AuthenticationBloc authenticationBloc = authBloc;
  StreamSubscription<Event> listener;
  List<ChatModel> list = [];

  ChatsBloc() {
    String hubUrl = "https://btp-partnership-merure.herokuapp.com/hub";
    String topic = "new-message";

    Mercure mercure = Mercure(
        token:
            'G1meHgz9daQp0mDoJ2xQanOWUajA1lERCDPAmBP2amnhaRcmiPnOm9vKBJ7gdjQFfY0=',
        hub_url: hubUrl);
    print('Mercure');

    listener = mercure.subscribeTopic(
        topic: topic,
        onData: (Event event) {
          print('Mercure event');
          print(event.data);
          Map<String, dynamic> data = json.decode(event.data);
          try {
            NewMessageModel a = NewMessageModel.fromJson(data);
            print(a.chatID);
            print(a.message.text);
            if (a.message.sender) {
              ChatModel chat =
                  list.firstWhere((ch) => ch.id == int.parse(a.chatID));
              chat.messages.add(a.message);
              chat.unread++;
              //print('unread ${chat.unread}');
              list = List.from(list);

              this.add(ChatsMessageRecieving(a));
              showChatNotification(chat);
            }
          } catch (e) {
            print('Mercure error $e');
          }
        },
        onError: (e) {
          print('Mercure listerner erro $e');
          listener.pause();
        });

    authBloc.listen((event) {
      if (event is AuthenticationUnauthenticated) {
        list = [];
        //listener.pause();
      } else if (event is AuthenticationAuthenticated) {
        //if (listener.isPaused) listener.resume();
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

    if (event is ChatsAddNew) {
      list = [event.chat, ...list];
      yield ChatsFetchingSuccess(list);
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
        list = list..firstWhere((c) => c.id == event.chatID).messages.add(a);

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
