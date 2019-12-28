import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  @override
  ChatsState get initialState => InitialChatsState();

  @override
  Stream<ChatsState> mapEventToState(
    ChatsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
