import 'package:btpp/Models/annonce.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

FlutterLocalNotificationsPlugin flutterNotification =
    FlutterLocalNotificationsPlugin();

NotificationDetails get _ongoing {
  final android = AndroidNotificationDetails(
      'channelId', 'channelName', 'channelDescription',
      ongoing: true, channelShowBadge: true);
  final iOS = IOSNotificationDetails();

  return NotificationDetails(android, iOS);
}

showChatNotification(ChatModel chat) async {
  String groupKey = chat.id;
  String groupChannelId = chat.id;
  String groupChannelName = chat.annonceModel.intitule;
  String groupChannelDescription = chat.annonceModel.description;

  if (chat.unread == 0) return;

  if (chat.unread < 2) {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      groupChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      groupKey: groupKey,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android, null);
    await flutterNotification.show(int.parse(chat.id) + 1000000,
        chat.contact.nom, chat.lastMessage.text, notificationDetails,
        payload: 'chat,${chat.id}');
  } else {
// create the summary notification required for older devices that pre-date Android 7.0 (API level 24)
    List<String> lines = new List<String>.from(
      chat.messages
          .toList()
          .take(chat.unread)
          .map((f) => DateFormat.Hm().format(f.sentAt) + ' ' + f.text),
    );

    InboxStyleInformation inboxStyleInformation = new InboxStyleInformation(
      lines,
      contentTitle: chat.annonceModel.intitule + ', ' + chat.annonceModel.lieu,
      summaryText: chat.contact.nom,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      groupChannelDescription,
      style: AndroidNotificationStyle.Inbox,
      styleInformation: inboxStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true,
    );

    NotificationDetails platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics,
      null,
    );

    await flutterNotification.show(
      int.parse(chat.id) + 1000000,
      chat.annonceModel.intitule,
      '${chat.unread} nouveau messages',
      platformChannelSpecifics,
      payload: 'chat,${chat.id}',
    );
  }
}

Future onSelectNotification(String payload) {
  print('Selected');
  List<String> x = payload.split(',');
  if (payload != null) {
    print('payload= $payload');
    if (x[0] == 'chat') {
      notificationBloc.add(ChatNotificationClicked(x[1]));
    }
  }
}

Future displayOngoingNotification({
  @required String title,
  @required String body,
  int id = 0,
}) =>
    _showNotification(title: title, body: body, id: id, type: _ongoing);

Future _showNotification({
  @required String title,
  @required String body,
  @required NotificationDetails type,
  int id = 0,
}) =>
    flutterNotification.show(id, title, body, type);
