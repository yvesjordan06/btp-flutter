import 'package:equatable/equatable.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
}

class InitialChatsState extends ChatsState {
  @override
  List<Object> get props => [];
}
