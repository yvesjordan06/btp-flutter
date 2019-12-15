import 'package:btpp/Components/tabButton.dart';
import 'package:btpp/Pages/Annonces/main.dart';
import 'package:btpp/Pages/Auth/login.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.red,
            tabs: [
              TabButton(text: Text('Annonce'), icon: Icon(Icons.home),),
              TabButton(text: Text('Actu'), icon: Icon(Icons.apps),),
              TabButton(text: Text('Chat'), icon: Icon(Icons.chat_bubble),),
            ],
          ),
          body: TabBarView(children: [
            AnnoncePage(),
            LoginPage(),
            Text('Page 3'),
          ]),
        ),
    );
  }
}