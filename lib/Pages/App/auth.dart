import 'package:btpp/Components/tabButton.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Pages/Annonces/main.dart';
import 'package:btpp/Pages/Auth/login.dart';
import 'package:flutter/material.dart';

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            indicatorColor:AppColors.primaryDark,
            unselectedLabelColor: Colors.grey[700],
            labelColor: AppColors.primary,
            tabs: [
              TabButton(text: 'Connexion', icon: Icon(Icons.person),),
              TabButton(text: 'Inscription', icon: Icon(Icons.add_circle_outline),),
            ],
          ),
          body: TabBarView(children: [
            LoginPage(),
            AnnoncePage(),
          ]),
        ),
    );
  }
}
