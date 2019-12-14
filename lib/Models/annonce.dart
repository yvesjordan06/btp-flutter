class AnnonceModel {
  final String intitule;
  final String description;
  final User annonceur;
  final DateTime createAt;
  final Tache taches;

  AnnonceModel(this.intitule, this.description, this.annonceur, this.createAt, this.taches);
}

class Tache {
  final String intitule;
  final String metier;
  final String description;

  Tache(this.intitule, this.metier, this.description);
}

class User {
  final String nom;
  final String prenom;
  final DateTime dateDeNaissance;
  final String status;


  User(this.nom, this.prenom, this.dateDeNaissance, this.status);}
