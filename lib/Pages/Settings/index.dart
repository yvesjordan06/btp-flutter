import 'dart:io';

import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Components/menuTiles.dart';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/State/index.dart';
import 'package:btpp/State/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  UserState userState = AppState.userState;
  UserModel currentUser = AppState.userState.currentUser;

  @override
  void initState() {
    userState.addListener(() {
      if (mounted)
        setState(() {
          UserModel newstate = AppState.userState.currentUser;
          if (newstate != null) currentUser = AppState.userState.currentUser;
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                      image: currentUser.localPicture == null
                          ? NetworkImage(currentUser.pictureLink)
                          : FileImage(currentUser.localPicture))),
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
                  user: currentUser,
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
                          value: currentUser.nom,
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Prénom',
                          value: currentUser.prenom,
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Télephone',
                          value: currentUser.prenom,
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Email',
                          value: 'Aucun',
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Anniversaire',
                          value: DateFormat('EEE').toString(),
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Pays',
                          value: currentUser.pays,
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Ville',
                          value: currentUser.ville,
                          onTap: () {},
                        ),
                        MenuTile(
                          text: 'Quartier',
                          value: currentUser.quartier,
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
                          value: currentUser.userType,
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
                          onTap: () {
                            AppState.userState.logout();
                          },
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
  final UserModel user;
  final Widget child;

  const SettingDecorationPage(
      {Key key, @required this.user, @required this.child})
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
                    backgroundImage: user.localPicture == null
                        ? NetworkImage(user.pictureLink)
                        : FileImage(user.localPicture),
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
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.photo_camera),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            imageFromCamera().then((img) {
                                              AppState.userState
                                                  .changePicture(img);
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.photo_library),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            imageFromGallery().then((img) {
                                              AppState.userState
                                                  .changePicture(img);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  });
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
                      (user.nom + ' ' + user.prenom).toUpperCase(),
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
                          (user.pays + ' ' + user.ville).toUpperCase(),
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
