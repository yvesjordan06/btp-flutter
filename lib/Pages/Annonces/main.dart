import 'package:btpp/Components/annonceList.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AnnoncePage extends StatefulWidget {
  @override
  _AnnoncePageState createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<AnnonceModel> annonces = [
    AnnonceModel('Maison de Osakas', 'Je veux une maison dans osaka au japon',
        DateTime(2006), 'Japon, Tokyo'),
    AnnonceModel(
        'Imeuble Rouge a very long title to this annonce is made by me to test the following behaviors',
        'If i pass the more than 3  again it is not sufficient for all those lineslines it becomes an overflow and i dont know what will happen I do speak some english and chinese but i really prefere to be an engineer because here it is not easy to get work',
        DateTime(2014),
        'USA, New York'),
    AnnonceModel(
        'Macabo Bar', 'J\'ai rien a dire', DateTime(2018), 'Bamenda, my17'),
    AnnonceModel(
        'Gratte cielle',
        'Je ne sais pas ce que je veux mais je suis tres fort avec les gens quand je commence a travailler',
        DateTime(2020),
        'Japon, Tokyo'),
    AnnonceModel(
        'Masonnerie',
        'Je suis un maçon tres veillant et je cherche un emploie',
        DateTime(2019),
        'Yaounde, Tokyo'),
  ]; // Annonces de l'api
  List<AnnonceModel> filteredAnnonces = List();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBar = Text('Annonces');

  Widget _showAnnonces() {
    if (_searchText.isNotEmpty) {
      List<AnnonceModel> tempList = List();
      for (int i = 0; i < annonces.length; i++) {
        if (annonces[i]
            .intitule
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(annonces[i]);
        }
      }
      filteredAnnonces = tempList;
      return AnnoncesList(
        annonceList: filteredAnnonces,
        search: true,
      );
    }
    return AnnoncesList(
      annonceList: filteredAnnonces,
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBar = TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Recherche...'),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBar = Text('Annonces');
        filteredAnnonces = annonces;
        _filter.clear();
      }
    });
  }

  _AnnoncePageState() {
    filteredAnnonces = annonces;
    _filter.addListener(() {
      print('triggered');
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredAnnonces = annonces;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBar,
          actions: <Widget>[
            IconButton(icon: _searchIcon, onPressed: _searchPressed)
          ],
        ),
        body: _showAnnonces(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(icon: Icon(Icons.add), onPressed: null),
            ),
            onPressed: null));
  }
}
