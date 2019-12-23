import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Components/horizontalDivider.dart';
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
                  Material(
                    child: ListTile(
                      title: Text('Anglais'),
                      subtitle: Text('Langues'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: Text('Anglais'),
                      subtitle: Text('Langues'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: Text('Anglais'),
                      subtitle: Text('Langues'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: Text('Anglais'),
                      subtitle: Text('Langues'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: Text('Anglais'),
                      subtitle: Text('Langues'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
