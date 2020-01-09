import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/bloc/annonces_bloc.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandesAnnoncePage extends StatefulWidget {
  static const String routeName = '/demandes';
  final ChatModel chat;

  DemandesAnnoncePage({Key key, this.chat}) : super(key: key);

  @override
  _DemandesAnnoncePageState createState() => _DemandesAnnoncePageState();
}

class _DemandesAnnoncePageState extends State<DemandesAnnoncePage> {
  List<int> selected = [];
  bool requesting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demandes Postuler'),
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

          if (state is AnnonceTaskFailed)
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          if (state is AnnonceTaskSuccess) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Reussi'),
            ));
            setState(() {
              requesting = true;
            });
          }
        },
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          // color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      title: Text(widget.chat.contact.name),
                      //subtitle: Text('Il ya 2 semaines'),
                      leading: CircleAvatar(
                        child: UserImage(
                          user: widget.chat.contact,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'A postuler sur les taches :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      itemCount: widget.chat.taches.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {},
                          title: Text(widget.chat.taches[index].intitule),
                          leading: Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                if (value)
                                  selected.add(widget.chat.taches[index].id);
                                else
                                  selected.remove(widget.chat.taches[index].id);
                              });
                            },
                            value:
                                selected.contains(widget.chat.taches[index].id),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text(requesting
                            ? 'Veuillez Patienter ...'
                            : 'Attribuer'),
                        onPressed: requesting || selected.isEmpty
                            ? null
                            : () {
                                annoncesBloc.add(AttribuerAnnonce(
                                    widget.chat.annonceModel,
                                    widget.chat.contact,
                                    selected));
                              },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
