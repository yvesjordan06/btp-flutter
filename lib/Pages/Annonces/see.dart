import 'package:btpp/Components/horizontalDivider.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
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
            title: Text(annonce.intitule, overflow: TextOverflow.ellipsis,),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.lightBlue[900],
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: <Widget>[
                    Center(child: Opacity(child: Image.asset('images/favicon.png'), opacity: 0.4,)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          annonce.intitule,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
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
                          'Publié '+timeAgo(annonce.createdAt),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,

            actions: <Widget>[
              PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.edit, color: Colors.grey,),
                                SizedBox(width: 5,),
                                Text('Modifier'),
                              ],
                            ),
                            onTap: (){Navigator.pushNamed(context, 'annonce/edit', arguments: annonce);},
                          ),

                      ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: annonceSummary(annonce)
                      )
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: horizontalDivider(text: 'Details')
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      horizontalDivider(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),

              ]
            ),
          ),
          SliverList(
              delegate:  SliverChildBuilderDelegate((context, index) =>Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: tacheTravailleur(),
              ),
              childCount: 6),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                horizontalDivider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      AdditionalInfo(),
                      SizedBox(height: 20,),
                      horizontalDivider(text: 'L\'annonceur'),
                      AboutClient()
                    ],
                  ),
                )
              ]
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 20,
                    child: Container(color: Colors.grey[200],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnnonceSimilaire(),
                  )
                ]
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    children: <Widget>[
                      Text('Annonce '+index.toString()),
                      SizedBox(width: 5,),
                      Text('Lorem Ipsum ...')
                    ],
                  ),
                ),
              childCount: 4
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: (){Navigator.pushNamed(context, 'annonce/postuler', arguments: annonce);},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child:  Text(
                                'Postuler',
                                style: TextStyle(fontSize: 20, color: Colors.white)
                            )
                          ),

                        ),
                      ),
                    ],
                  ),
                ),

              ]
            ),
          )
        ],
      )
    );
  }
}

Widget annonceSummary(AnnonceModel annonce) => Container(
  child: Column(
    children: <Widget>[
      horizontalDivider(text: 'Résumé'),
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.person_outline, size: 50, color: AppColors.primary,),
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
              Icon(Icons.people_outline, size: 50, color: AppColors.primary,),
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
        ],
      ),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.format_paint, size: 50, color: AppColors.primary,),
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

          Row(
            children: <Widget>[
              Icon(Icons.done_outline, size: 50, color: AppColors.primary,),
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

Widget AdditionalInfo() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       Text(
         'Temp Restant :',
         style: TextStyle(
           fontWeight: FontWeight.bold
         ),
       ),
        Text(
         '8 Mois'
       ),
      ],
    ),
  );


}

Widget AboutClient() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nationalité :',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
                'Cameroun'
            ),
          ],
        ),
        SizedBox(height: 10,),
        Text(
          '10 Annonces publié',
        ),
        SizedBox(height: 5,),
        Text(
          '1 Annonces active',
        ),
        SizedBox(height: 5,),
        Text(
            '4% Taux d\'embauchement'
        ),
        SizedBox(height: 10,),
        Text(
            'Membre depuis octobre 2012',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12
          ),
        ),
      ],
    ),
  );
}
Widget AnnonceSimilaire() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Text(
          'Annonces Similaire',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        horizontalDivider(margin: 0),
        SizedBox(height: 10,),
      ],
    ),
  );
}
