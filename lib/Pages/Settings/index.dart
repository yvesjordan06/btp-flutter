import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Components/menuTiles.dart';
import 'package:flutter/material.dart';

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Stack(
          //fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg'))),
            ),
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.7),
            ),
            Positioned.fill(
              top: 300,
              child: Container(
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80),
              //width: double.infinity,
              child: SingleChildScrollView(
                child: SettingDecorationPage(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderText(
                          text: 'Parametre Profiles',
                        ),
                        MenuTile(
                          text: 'Nom',
                          value: 'Hiro',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Prénom',
                          value: 'Hamada',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Télephone',
                          value: '694842185',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Email',
                          value: 'Aucun',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Anniversaire',
                          value: '12 Juillet 1998',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Pays',
                          value: 'Cameroun',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Ville',
                          value: 'Yaoundé',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Quartier',
                          value: 'Nkomkana',
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HeaderText(
                          text: 'Compte',
                        ),
                        MenuToggle(
                          text: 'Desactiver',
                          value: true,
                          onToggle: (value) {},
                        ),
                        MenuTile(
                          text: 'Type',
                          value: 'Annonceur',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Abonnement',
                          value: 'Gratuit',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Mot de passe',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Se deconnecter',
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HeaderText(
                          text: 'Support',
                        ),
                        MenuTile(
                          text: 'Nous appeler',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Feedback',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: AppBar(
                elevation: 0,
                title: Text('Parametres'),
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class SettingDecorationPage extends StatelessWidget {
  final Widget child;
  const SettingDecorationPage({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 150),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              )),
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: child,
          ),
        ),
        Positioned(
          top: 110,
          left: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 10,
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.all(2),
                            onPressed: () {
                              print('ok');
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hiro Hamada'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 10,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Hiro, INDIA'.toUpperCase(),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
