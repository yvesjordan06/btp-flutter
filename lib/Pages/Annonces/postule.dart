import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool requesting = false;

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
      body: BlocListener<AnnoncesBloc, AnnoncesState>(
        bloc: annoncesBloc,
        listener: (context, state) {
          if (state is AnnonceTaskDoing)
            setState(() {
              requesting = true;
            });
          else
            setState(() {
              requesting = false;
            });
          if (state is AnnoncePostuleSuccess)
            Navigator.popAndPushNamed(context, 'chats/see',
                arguments: state.chat);
        },
        child: ListView(
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
                onPressed: selected.isEmpty || requesting
                    ? null
                    : () {
                        annoncesBloc.add(PostuleAnnonce(annonce, selected));
                      },
                child: Center(
                  child: !requesting
                      ? Text('Postuler')
                      : CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
