import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../Models/annonce.dart';

class PostulerPage extends StatefulWidget {
  const PostulerPage({Key key, this.annonce}) : super(key: key);

  final AnnonceModel annonce;

  @override
  _PostulerPageState createState() => _PostulerPageState(annonce: annonce);
}

class _PostulerPageState extends State<PostulerPage> {
  final AnnonceModel annonce;

  _PostulerPageState({this.annonce});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          annonce.intitule,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selectionnez vos taches',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 7,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    isThreeLine: true,
                    subtitle: Text('Metier $index'),
                    title: Text('Hiro'),
                    leading: Checkbox(
                      value: true,
                      onChanged: null,
                    ),
                  ),
                  // horizontalDivider(margin: 0)
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {},
              child: Center(
                child: Text('Postuler'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
