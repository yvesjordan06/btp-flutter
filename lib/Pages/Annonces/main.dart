import 'package:btpp/Components/annonce.dart';
import 'package:flutter/material.dart';

class AnnoncePage extends StatefulWidget {

  @override
  _AnnoncePageState createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void _changeState() {
        print('I was clicked');
        setState(() {

        });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonces'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: _changeState)
        ],
      ),
      body: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 35,
            itemBuilder: (BuildContext context, int index) {
              return SingleAnnonce();
            }
        ),
    ),
    );
  }
}
