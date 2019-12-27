import 'package:btpp/Models/annonce.dart';
import 'package:equatable/equatable.dart';

abstract class AnnoncesEvent extends Equatable {
  const AnnoncesEvent();
}

class FetchAnnonce extends AnnoncesEvent {
  const FetchAnnonce();

  @override
  List<Object> get props => null;
}

class PostuleAnnonce extends AnnoncesEvent {
  final dynamic payload;
  const PostuleAnnonce(this.payload);

  @override
  List<Object> get props => [payload];
}

class UpdateAnnonce extends AnnoncesEvent {
  final AnnonceModel annonce;
  const UpdateAnnonce(this.annonce);

  @override
  List<Object> get props => [annonce];
}

class DeleteAnnonce extends AnnoncesEvent {
  final AnnonceModel annonce;
  const DeleteAnnonce(this.annonce);

  @override
  List<Object> get props => [annonce];
}

class BlocCreateAnnonce extends AnnoncesEvent {
  final AnnonceModel annonce;
  const BlocCreateAnnonce(this.annonce);

  @override
  List<Object> get props => [annonce];
}

class FilterAnnonce extends AnnoncesEvent {
  final String text;
  const FilterAnnonce(this.text);

  @override
  List<Object> get props => [text];
}

class AttribuerAnnonce extends AnnoncesEvent {
  final AnnonceModel annonce;
  final UserModel travailleur;
  final List<int> taches;
  const AttribuerAnnonce(this.annonce, this.travailleur, this.taches);

  @override
  List<Object> get props => [annonce, travailleur, taches];
}
