import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class AnnoncesState extends Equatable {
  const AnnoncesState();
}

class AnnoncesInitial extends AnnoncesState {
  @override
  List<Object> get props => [];
}

class AnnoncesFetching extends AnnoncesState {
  @override
  List<Object> get props => [];
}

class AnnoncesCleared extends AnnoncesState {
  @override
  List<Object> get props => [];
}

class AnnoncesFetched extends AnnoncesState {
  final List<AnnonceModel> annonce;

  AnnoncesFetched(this.annonce);

  @override
  List<Object> get props => [annonce.hashCode];
}

class AnnoncesError extends AnnoncesState {
  final String error;

  AnnoncesError(this.error);

  @override
  List<Object> get props => [];
}

class AnnonceTaskSuccess extends AnnoncesFetched {
  AnnonceTaskSuccess(List<AnnonceModel> annonce) : super(annonce);

  @override
  List<Object> get props => [];
}

class AnnonceTaskFailed extends AnnoncesState {
  final String error;

  AnnonceTaskFailed(this.error);

  @override
  List<Object> get props => [];
}

class AnnonceTaskDoing extends AnnoncesState {
  @override
  List<Object> get props => [];
}

class AnnonceDeleteRequest extends AnnoncesState {
  @override
  List<Object> get props => [];
}

class AnnonceDeleted extends AnnoncesFetched {
  AnnonceDeleted(List<AnnonceModel> annonce) : super(annonce);

  @override
  List<Object> get props => [];
}
