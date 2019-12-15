import 'package:btpp/Components/annonce.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:flutter/material.dart';

class AnnoncesList extends StatelessWidget {
  final List<AnnonceModel> annonceList;
  final bool search;

  const AnnoncesList({Key key, this.annonceList, this.search = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (annonceList == null || annonceList.length == 0) {
      if (this.search) {
        return Center(
          child: Text('Cette Recherche ne correspond a aucun element'),
        );
      } else {
        return Center(
          child: Text('Aucune Annonce'),
        );
      }
    }
    return ListView.builder(
      itemCount: annonceList.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleAnnonce(
          annonce: annonceList[index],
        );
      },
    );
  }
}