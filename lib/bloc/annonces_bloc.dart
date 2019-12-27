import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/AnnoncesRepository.dart';
import './bloc.dart';

class AnnoncesBloc extends Bloc<AnnoncesEvent, AnnoncesState> {
  final AnnoncesRepository repository = AnnoncesRepository();
  List<AnnonceModel> annonces;

  @override
  AnnoncesState get initialState => AnnoncesInitial();

  @override
  Stream<AnnoncesState> mapEventToState(
    AnnoncesEvent event,
  ) async* {
    if (event is FetchAnnonce) {
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
  }
}
