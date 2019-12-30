import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class InitialNotificationState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationOpenChat extends NotificationState {
  final ChatModel chat;

  NotificationOpenChat(this.chat);
  @override
  List<Object> get props => [chat.hashCode];
}

class NotificationOpenAnnonces extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationOpenSingleAnnonce extends NotificationState {
  final AnnonceModel annonce;

  NotificationOpenSingleAnnonce(this.annonce);
  @override
  List<Object> get props => [];
}
