import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class ChatNotificationClicked extends NotificationEvent {
  final String chatID;

  ChatNotificationClicked(this.chatID);

  @override
  List<Object> get props => null;
}

class SingleAnnonceNotificationClicked extends NotificationEvent {
  final AnnonceModel annonce;

  SingleAnnonceNotificationClicked(this.annonce);

  @override
  List<Object> get props => null;
}

class AnnonceNotificationClicked extends NotificationEvent {
  @override
  List<Object> get props => null;
}
