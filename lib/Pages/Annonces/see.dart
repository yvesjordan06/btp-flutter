import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SeeAnnonce extends StatelessWidget {
  final AnnonceModel annonce;
  const SeeAnnonce({Key key, this.annonce}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          annonce.intitule,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text('See')),
                PopupMenuItem(child: Text('Add')),
                PopupMenuItem(child: Text('Manage')),
                PopupMenuItem(child: Text('Delete')),
              ];
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Text(
         'Hiro'
        ),
      ),
    );
  }
}

Widget annonceSummary(AnnonceModel annonce) => Container(
  child: Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 5),
            ),
          ),
          Text('Résumé'),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 5),
            ),
          ),
        ],
      ),
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.person, size: 60,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('0'),
                  SizedBox(height: 5,),
                  Text('Travailleurs', style: TextStyle(color: Colors.grey),),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.build, size: 60,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('10'),
                  SizedBox(height: 5,),
                  Text('Taches', style: TextStyle(color: Colors.grey),),
                ],
              )
            ],
          ),
        ],
      ),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.people_outline, size: 60,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('0'),
                  SizedBox(height: 5,),
                  Text('Demandes', style: TextStyle(color: Colors.grey),),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.done_outline, size: 60,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('0'),
                  SizedBox(height: 5,),
                  Text('Terminées', style: TextStyle(color: Colors.grey),),
                ],
              )
            ],
          ),
        ],
      ),
    ],
  ),
);

Widget tacheTravailleur() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 30,),
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tache', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('Pas encore attribuer', style: TextStyle(fontSize: 12, color: Colors.grey),)
          ],
        )
      ],
    ),
  );
}