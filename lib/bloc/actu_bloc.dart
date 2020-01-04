import 'dart:async';

import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/ActuRepository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import './bloc.dart';

class ActuBloc extends HydratedBloc<ActuEvent, ActuState> {
  List<ActuModel> actus;
  ActuRepository repo = ActuRepository();

  @override
  ActuState get initialState {
    print('super state is ${super.initialState}');
    return super.initialState ?? InitialActuState();
  }

  @override
  ActuState fromJson(Map<String, dynamic> json) {
    try {
      print('reading acuts');
      actus = List.from(ActuListModel.fromJson(json).list);
      print(actus);
      return ActuFetchedState(actus);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ActuState state) {
    if (state is ActuFetchedState) {
      return ActuListModel(state.list).toJson();
    }
    return null;
  }

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
        yield ActuFetchedFailedState(e);
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
        yield ActuCreatedFailedState(e);
      }
    }
  }
}
