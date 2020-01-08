import 'package:btpp/Models/annonce.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';

class MetierPage extends StatelessWidget {
  MetierPage({Key key}) : super(key: key);

  List<MetierModel> metier = authBloc.appMetiers ?? [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mes Metiers'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle),
              tooltip: 'Ajouter un metier',
              onPressed: () {
                Navigator.pushNamed(context, 'metiers/add');
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: metier.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(metier[index].intitule),
            trailing: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
