import 'package:btpp/Components/tabButton.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Pages/Annonces/main.dart';
import 'package:btpp/Pages/Auth/login.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            indicatorColor:AppColors.primaryDark,
            unselectedLabelColor: Colors.grey[700],
            labelColor: AppColors.primary,
            tabs: [
              TabButton(text: Text('Annonce'), icon: Icon(Icons.home),),
              TabButton(text: Text('Actu'), icon: Icon(Icons.public),),
              TabButton(text: Text('Chat'), icon: Icon(Icons.chat_bubble),),
              TabButton(text: Text('Compte'), icon: Icon(Icons.person_outline),),
            ],
          ),
          body: TabBarView(children: [
            AnnoncePage(),
            LoginPage(),
            Text('Page 3'),
            Text('Page 3'),
          ]),
        ),
    );
  }
}
