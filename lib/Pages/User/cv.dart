import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/State/index.dart';
import 'package:flutter/material.dart';

class CVPage extends StatefulWidget {
  final UserModel user;
  CVPage({Key key, @required this.user}) : super(key: key);

  @override
  _CVPageState createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('CV'),
        elevation: 0,
        actions: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: UserImage(
              user: AppState.userState.currentUser,
              radius: 20,
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  HeaderText(
                    text: 'A Propos',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Lorem Ipsum test test test test test test Lorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test testLorem Ipsum test test test test test test',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  HeaderText(
                    text: 'Competences',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CompetenceTile(
                    type: 'Langues',
                    value: 'Français',
                  ),
                  CompetenceTile(
                    type: 'Secretariat',
                    value: 'Word',
                  ),
                  CompetenceTile(
                    type: 'Eglise',
                    value: 'Pasteur',
                  ),
                  Material(
                      child: ListTile(
                    title: Text('Ajouter'),
                    leading: Icon(Icons.add_circle_outline),
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height /
                                                2),
                                    child: Scaffold(
                                      appBar: AppBar(
                                        title: Text('Nouvelle Competence'),
                                      ),
                                      body: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              TextField(
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Type de competences',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    labelText: 'Type'),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Competences',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    labelText: 'Competence'),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              RaisedButton.icon(
                                                icon: Icon(Icons.done),
                                                label: Text('Ajouter'),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    },
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  HeaderText(text: 'Cursus')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompetenceTile extends StatelessWidget {
  final String type;
  final String value;
  const CompetenceTile({
    Key key,
    @required this.type,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(value),
        subtitle: Text(type),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {},
        ),
      ),
    );
  }
}
