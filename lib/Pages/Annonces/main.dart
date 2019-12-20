import '../../Components/annonceList.dart';

import '../../Models/annonce.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

class AnnoncePage extends StatefulWidget {
  @override
  _AnnoncePageState createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";

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
              prefixIcon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Recherche...',
              hintStyle: TextStyle(color: Colors.white)),
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
        title: AnimatedSwitcher(
          child: _appBar,
          transitionBuilder: (child, animation) => SlideTransition(
            child: child,
            position: Tween<Offset>(begin: Offset(2, 0), end: Offset.zero)
                .animate(animation),
          ),
          duration: Duration(milliseconds: 200),
        ),
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
            } else if (scroll.direction == ScrollDirection.forward) {
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
          onPressed: () {
            Navigator.pushNamed(context, 'annonce/create');
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
