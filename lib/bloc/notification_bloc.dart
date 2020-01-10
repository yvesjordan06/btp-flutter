import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  @override
  NotificationState get initialState => InitialNotificationState();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    print('Notification event $event');
    if (event is ChatNotificationClicked) {
      try {
        yield NotificationOpenChat(
            chatsBloc.list.firstWhere((f) => f.id.toString() == event.chatID));
      } catch (e) {}
    }
  }
}
