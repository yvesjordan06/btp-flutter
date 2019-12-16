import 'package:btpp/Components/annonceList.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class AnnoncePage extends StatefulWidget {
  @override
  _AnnoncePageState createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<AnnonceModel> annonces = [
    AnnonceModel(intitule:'Maison de Osakas', description:'Je veux une maison dans osaka au japon',
        createdAt:DateTime(2006), lieu:'Japon, Tokyo'),
    AnnonceModel(
        intitule:'Imeuble Rouge a very long title to this annonce is made by me to test the following behaviors',
        description:'If i pass the more than 3  again it is not sufficient for all those lineslines it becomes an overflow and i dont know what will happen I do speak some english and chinese but i really prefere to be an engineer because here it is not easy to get work',
        createdAt:DateTime(2014),
        lieu:'USA, New York'),
    AnnonceModel(
        intitule:'Macabo Bar', description:'J\'ai rien a dire', createdAt:DateTime(2018), lieu:'Bamenda, my17'),
    AnnonceModel(
        intitule:'Gratte cielle',
        description:'Je ne sais pas ce que je veux mais je suis tres fort avec les gens quand je commence a travailler',
        createdAt:DateTime(2020),
        lieu:'Japon, Tokyo'),
    AnnonceModel(
        intitule:'Masonnerie',
        description:'Je suis un maçon tres veillant et je cherche un emploie',
        createdAt:DateTime(2019),
        lieu:'Yaounde, Tokyo'),
    AnnonceModel(
        intitule:'Masonnerie',
        description:'Je suis un maçon tres veillant et je cherche un emploie',
        createdAt:DateTime(2019),
        lieu:'Yaounde, Tokyo'),
    AnnonceModel(
        intitule:'Masonnerie',
        description:'Je suis un maçon tres veillant et je cherche un emploie',
        createdAt:DateTime(2019),
        lieu:'Yaounde, Tokyo'),
  ]; // Annonces de l'api
  List<AnnonceModel> filteredAnnonces = List();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBar = Text('Annonces');
  bool isEnabled = true;
  ScrollController _scroll;

  initState() {
    super.initState();

  }


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
        body: NotificationListener<ScrollNotification>(
            child: _showAnnonces(),
          onNotification: (scroll) {
              if (scroll is UserScrollNotification) {
                if (scroll.direction == ScrollDirection.reverse) {
                  setState(() {
                    isEnabled = false;
                  });
                }else if (scroll.direction == ScrollDirection.forward){
                  setState(() {
                    isEnabled = true;
                  });
                }
              }
              return true;
          },
        ),
        floatingActionButton: AnimatedOpacity(
          opacity: isEnabled ? 1.0 : 0,
          duration: Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () {Navigator.pushNamed(context, 'annonce/create');},
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ),
        ));
  }
}
