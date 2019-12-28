import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/ActuRepository.dart';
import './bloc.dart';

class ActuBloc extends Bloc<ActuEvent, ActuState> {
  List<ActuModel> actus;
  ActuRepository repo = ActuRepository();
  @override
  ActuState get initialState => InitialActuState();

  @override
  Stream<ActuState> mapEventToState(
    ActuEvent event,
  ) async* {
    if (event is ActuFetch) {
      yield ActuFetchingState();
      try {
        actus = await repo.fetchAll();
        yield ActuFetchedState(actus);
      } catch (e) {
        yield ActuFetchedFailedState('Error');
      }
    }

    if (event is ActuAdd) {
      print(event.actu.assetPictures);
      yield ActuCreatingState();
      try {
        ActuModel res = await repo.create(event.actu);
        actus = [res, ...actus];
        yield ActuCreatedState(actus);
      } catch (e) {
        yield ActuCreatedFailedState('Error');
      }
    }
  }
}
