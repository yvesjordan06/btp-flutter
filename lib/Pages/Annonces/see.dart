import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Functions/Colors.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          annonce.intitule,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        annonce.lieu,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Publié '+timeAgo(annonce.createAt),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                            child: annonceSummary(annonce)
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Details',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.5),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(annonce.description),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]
            ),
          ),
          SliverList(
              delegate:  SliverChildBuilderDelegate((context, index) =>Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: tacheTravailleur(),
              )),

          )
        ],
      )
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.person_outline, size: 50, color: AppColors.accent,),
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
              Icon(Icons.format_paint, size: 50, color: AppColors.accent,),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.people_outline, size: 50, color: AppColors.accent,),
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
              Icon(Icons.done_outline, size: 50, color: AppColors.accent,),
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
