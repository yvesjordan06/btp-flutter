import 'package:btpp/Models/annonce.dart';
import 'package:flutter/material.dart';

class DemandesAnnoncePage extends StatelessWidget {
  static const String routeName = '/demandes';
  final AnnonceModel annonce;

  const DemandesAnnoncePage({Key key, this.annonce}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demandes Postuler'),
      ),
      body: ListView.builder(
        itemCount: 6,
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
                    title: Text('Travailleur'),
                    subtitle: Text('Il ya 2 semaines'),
                    leading: CircleAvatar(
                      child: Image.asset('images/userfallback.png'),
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
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {},
                        title: Text('Tache $index'),
                        leading: Checkbox(
                          onChanged: (bool value) {},
                          value: true,
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text('Enregistrer'),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
