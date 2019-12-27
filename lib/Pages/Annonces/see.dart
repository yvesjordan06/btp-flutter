import 'package:btpp/Components/annonce.dart';
import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Components/horizontalDivider.dart';
import 'package:btpp/Repository/AnnoncesRepository.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Functions/Utility.dart';
import '../../Models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SeeAnnonce extends StatelessWidget {
  const SeeAnnonce({Key key, this.annonce}) : super(key: key);

  final AnnonceModel annonce;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnnoncesBloc, AnnoncesState>(
      bloc: annoncesBloc,
      listener: (context, state) {
        if (state is AnnonceDeleteRequest || state is AnnonceTaskSuccess)
          Navigator.pop(context);
      },
      child: Scaffold(
          body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text(
            annonce.intitule,
            overflow: TextOverflow.ellipsis,
          ),
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: <Widget>[
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
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        annonce.lieu,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Publié ' + timeAgo(annonce.createdAt),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
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
                      child: ListTile(
                        title: Text('Modifier'),
                        leading: Icon(Icons.mode_edit),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'annonce/edit',
                              arguments: annonce);
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        title: Text('Demandes'),
                        leading: Icon(Icons.people),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'annonce/demandes',
                              arguments: annonce);
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        title: Text('Gerer'),
                        leading: Icon(Icons.settings),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'annonce/demandes',
                              arguments: annonce);
                        },
                      ),
                    ),
                    PopupMenuItem(
                      enabled: false,
                      child: HorizontalDivider(
                        margin: 0,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        title: Text('Partager'),
                        leading: Icon(Icons.share),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'annonce/demandes',
                              arguments: annonce);
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        title: Text('Supprimer'),
                        leading: Icon(Icons.delete_forever),
                        onTap: () {
                          Navigator.pop(context);
                          annoncesBloc.add(DeleteAnnonce(annonce));
                        },
                      ),
                    ),
                  ];
                }),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              color: AppColor.primaryColor,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: annonceSummary(context, annonce),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    HeaderText(
                      text: 'Details',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(annonce.description),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    HeaderText(
                      text: 'Taches',
                    ),
                    ...List<Widget>.generate(
                      4,
                      (index) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        child: tacheTravailleur(),
                      ),
                    ),
                    HeaderText(
                      text: 'Plus d\info',
                    ),
                    AdditionalInfo(),
                    SizedBox(
                      height: 20,
                    ),
                    HeaderText(
                      text: 'L\'annonceur',
                    ),
                    AboutClient(),
                    AnnonceSimilaire,
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Postuler'),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'annonce/postuler',
                              arguments: annonce);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ])),
    );
  }
}

Widget annonceSummary(context, AnnonceModel annonce) => Container(
      child: Theme(
        data: ThemeData().copyWith(
            iconTheme:
                ThemeData().iconTheme.copyWith(color: AppColor.primaryColor)),
        child: Column(
          children: <Widget>[
            HeaderText(
              text: 'Résume',
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('0'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Travailleurs',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'annonce/demandes',
                        arguments: annonce);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.people_outline,
                        size: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('0'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Demandes',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.format_paint,
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('10'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Taches',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.done_outline,
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('0'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Terminées',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget tacheTravailleur() {
  return ListTile(
    onTap: () {},
    title: Text('Carrelage'),
    leading: CircleAvatar(
      child: Text(
        'C',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey[300],
      radius: 30,
    ),
    subtitle: Text(('Pas encore attribuer')),
  );
}

Widget AdditionalInfo() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Temp Restant :',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('8 Mois'),
      ],
    ),
  );
}

Widget AboutClient() {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nationalité :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Cameroun'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '10 Annonces publié',
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '1 Annonces active',
        ),
        SizedBox(
          height: 10,
        ),
        Text('4% Taux d\'embauchement'),
        SizedBox(
          height: 10,
        ),
        Text(
          'Membre depuis octobre 2012',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    ),
  );
}

Widget get AnnonceSimilaire {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: <Widget>[
        HeaderText(
          text: 'Annonce Similaire',
        ),
        SizedBox(
          height: 20,
        ),
        ...List<Widget>.generate(
            0,
            (index) => SingleAnnonce(
                  annonce: annonces[index],
                ))
      ],
    ),
  );
}
