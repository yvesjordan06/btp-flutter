import 'package:btpp/bloc/bloc.dart';
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
  final List<int> selected = [];

  _PostulerPageState({this.annonce});
  List<TacheModel> __alltache = authBloc.taches;

  @override
  Widget build(BuildContext context) {
    List<TacheModel> taches = List<TacheModel>.generate(
        annonce.taches.length,
        (index) =>
            __alltache.firstWhere((t) => t.id == annonce.taches[index].id));
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
            itemCount: taches.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    isThreeLine: true,
                    subtitle: Text(taches[index].description),
                    title: Text(taches[index].intitule),
                    leading: Checkbox(
                      value: selected.contains(taches[index].id),
                      onChanged: (value) {
                        setState(() {
                          if (value)
                            selected.add(taches[index].id);
                          else
                            selected.remove(taches[index].id);
                        });
                      },
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
              onPressed: selected.isEmpty ? null : () {},
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
