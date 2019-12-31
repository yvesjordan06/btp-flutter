import 'dart:async';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/AnnoncesRepository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './bloc.dart';

class AnnoncesBloc extends HydratedBloc<AnnoncesEvent, AnnoncesState> {
  final AnnoncesRepository repository = AnnoncesRepository();

  AnnoncesBloc() {
    // authBloc.listen(onData);
  }

  List<AnnonceModel> annonces;

  @override
  AnnoncesState get initialState {
    return super.initialState ?? AnnoncesInitial();
  }

  @override
  AnnoncesState fromJson(Map<String, dynamic> json) {
    try {
      annonces = List.from(AnnonceListModel.fromJson(json).list);
      print('init $annonces');
      if (annonces == null)
        return AnnoncesInitial();
      else
        annonces..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return null;
      // return null;
    } catch (_) {
      print('eeroor aoccoa');
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(AnnoncesState state) {
    if (state is AnnoncesFetched) {
      print('someting happenning');
      return AnnonceListModel(state.annonce).toJson();
    }
    return null;
  }

  @override
  Stream<AnnoncesState> mapEventToState(
    AnnoncesEvent event,
  ) async* {
    if (event is FetchAnnonce) {
      if (annonces != null) yield AnnoncesFetched(annonces);
      yield AnnoncesFetching();
      try {
        annonces = await repository.fetchAll();
        yield AnnoncesFetched(
            annonces..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
      } catch (error) {
        yield AnnoncesError(error);
      }
    }
    if (event is BlocCreateAnnonce) {
      yield AnnonceTaskDoing();
      try {
        print(annonces.length);
        AnnonceModel newAnnonce = await repository.create(event.annonce);
        print(annonces.length);
        annonces.add(newAnnonce);
        print(annonces.length);
        yield AnnonceTaskSuccess(
            annonces..sort((a, b) => b.createdAt.compareTo(a.createdAt)));

        print(annonces.length);
      } catch (error) {
        yield AnnonceTaskFailed(error);
      }
    }
    if (event is UpdateAnnonce) {
      yield AnnonceTaskDoing();
      try {
        AnnonceModel update = await repository.update(event.annonce);
        int index = annonces.indexWhere((ann) => ann.id == update.id);
        annonces[index] = update;
        yield AnnonceTaskSuccess(annonces);
      } catch (error) {
        yield AnnonceTaskFailed(error);
      }
    }
    if (event is DeleteAnnonce) {
      yield AnnonceDeleteRequest();
      try {
        await repository.delete(event.annonce);
        yield AnnonceDeleted(annonces..remove(event.annonce));
      } catch (error) {
        yield AnnonceTaskFailed(error);
      }
    }
    if (event is PostuleAnnonce) {
      yield AnnonceTaskDoing();
      try {
        yield AnnonceTaskSuccess(annonces);
      } catch (error) {
        yield AnnonceTaskFailed(error);
      }
    }
    if (event is AttribuerAnnonce) {
      yield AnnonceTaskDoing();
      try {
        yield AnnonceTaskSuccess(annonces);
      } catch (error) {
        yield AnnonceTaskFailed(error);
      }
    }

    if (event is FilterAnnonce) {
      yield AnnonceTaskDoing();
      print('I need to filter');

      try {
        var result = annonces
            .where((ann) =>
                (ann.intitule
                    .toLowerCase()
                    .startsWith(event.text.toLowerCase().trim())) ||
                (ann.description
                    .toLowerCase()
                    .contains(event.text.toLowerCase().trim())))
            .toList();
        yield AnnoncesFetched(
            result..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
      } catch (error) {
        print(error);
        yield AnnonceTaskFailed(error);
      }
    }

    if (event is ClearAnnonce) {
      annonces = null;
      yield AnnoncesFetched(null);
    }
  }

  void onData(AuthenticationState state) {
    if (state is AuthenticationUnauthenticated) {
      print('annonce clearing');
      add(ClearAnnonce());
    }
  }
}
