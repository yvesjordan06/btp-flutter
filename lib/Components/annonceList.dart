import '../Components/annonce.dart';
import '../Models/annonce.dart';
import 'package:flutter/material.dart';

class AnnoncesList extends StatelessWidget {
  final List<AnnonceModel> annonceList;
  final bool search;

  const AnnoncesList({Key key, this.annonceList, this.search = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      // shrinkWrap: true,
      itemCount: annonceList.length,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        print('Annonce $index : ' + annonceList[index].hashCode.toString());
        return SingleAnnonce(
          annonce: annonceList[index],
        );
      },
    );
  }
}
