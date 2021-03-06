import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Components/annonceList.dart';
import '../../Models/annonce.dart';

class AnnoncePage extends StatefulWidget {
  @override
  _AnnoncePageState createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<AnnonceModel> filteredAnnonces = List();
  List<AnnonceModel> annonces = List();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBar = Text('Annonces');
  bool isEnabled = true;
  AnnoncesBloc bloc = annoncesBloc;

  initState() {
    super.initState();
    bloc.add(FetchAnnonce());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    void _searchPressed() {
      setState(() {
        if (this._searchIcon.icon == Icons.search) {
          this._searchIcon = Icon(Icons.close);
          this._appBar = TextField(
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              bloc.add(FilterAnnonce(value));
            },
            autofocus: true,
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
        }
      });
    }

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
        child: BlocListener<AnnoncesBloc, AnnoncesState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is AnnoncesFetched) annonces = state.annonce;
            if (state is AnnonceTaskDoing || state is AnnonceDeleteRequest) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Container(
                  height: 20,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.contain,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Veuillez Patienter'),
                    ],
                  ),
                ),
              ));
            } else {
              Scaffold.of(context).removeCurrentSnackBar();
            }
          },
          child: BlocBuilder<AnnoncesBloc, AnnoncesState>(
              bloc: bloc,
              builder: (context, state) {
                print(state);
                return Stack(
                  children: <Widget>[
                    RefreshIndicator(
                      onRefresh: () {
                        annoncesBloc.add(FetchAnnonce());
                        return Future.value(true);
                      },
                      child: AnnoncesList(
                        annonceList: annonces,
                      ),
                    ),
                    if (annonces.isNotEmpty && state is AnnoncesFetching)
                      Align(
                        child: Container(
                            margin: EdgeInsets.only(top: 40),
                            child: RefreshProgressIndicator()),
                        alignment: Alignment.topCenter,
                      ),
                    if (annonces.isEmpty && state is AnnoncesFetching)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              }),
        ),
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
      floatingActionButton:
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authBloc,
        builder: (context, state) {
          if (authBloc.currentUser.userType == UserType.annonceur)
            return AnimatedOpacity(
              opacity: isEnabled ? 1.0 : 0,
              duration: Duration(milliseconds: 1000),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'annonce/create');
                },
                tooltip: 'Ajouter une annonce',
                child: new Icon(Icons.add),
              ),
            );
          else
            return SizedBox();
        },
      ),
    );
  }
}
