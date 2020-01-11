import 'package:json_annotation/json_annotation.dart';

part 'cv.model.g.dart';

@JsonSerializable()
class CVModel {
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  final String biographie;
  final List<CursusModel> cursuses;
  final List<ComptenceModel> competences;

  CVModel(
      {this.id,
      this.createdAt,
      this.biographie,
      this.cursuses,
      this.competences});

  factory CVModel.fromJson(Map<String, dynamic> json) =>
      _$CVModelFromJson(json);

  Map<String, dynamic> toJson() => _$CVModelToJson(this);
}

@JsonSerializable()
class CursusModel {
  final int id;
  @JsonKey(name: "date_debut")
  final DateTime dateDebut;
  @JsonKey(name: "date_fin")
  final DateTime dateFin;
  final String intitule;
  final String appreciation;
  @JsonKey(name: "type_cursus")
  final String typeCursus;

  CursusModel(
      {this.id,
      this.dateDebut,
      this.dateFin,
      this.intitule,
      this.appreciation,
      this.typeCursus});

  factory CursusModel.fromJson(Map<String, dynamic> json) =>
      _$CursusModelFromJson(json);

  Map<String, dynamic> toJson() => _$CursusModelToJson(this);
}

@JsonSerializable()
class ComptenceModel {
  final int id;
  final String intitule;
  final List<String> value;
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  ComptenceModel({this.id, this.intitule, this.value, this.createdAt});

  factory ComptenceModel.fromJson(Map<String, dynamic> json) =>
      _$ComptenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComptenceModelToJson(this);
}
