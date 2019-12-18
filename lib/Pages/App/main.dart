import 'package:btpp/Pages/Chat/main.dart';

import '../../Components/tabButton.dart';
import '../../Functions/Colors.dart';
import '../../Pages/Annonces/main.dart';
import '../../Pages/Auth/login.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          indicatorColor: AppColors.primaryDark,
          unselectedLabelColor: Colors.grey[700],
          labelColor: AppColors.primary,
          tabs: [
            TabButton(
              text: 'Annonce',
              icon: Icon(Icons.home),
            ),
            TabButton(
              text: 'Actu',
              icon: Icon(Icons.public),
            ),
            TabButton(
              text: 'Chat',
              icon: Icon(Icons.chat_bubble),
            ),
            TabButton(
              text: 'Compte',
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
        body: TabBarView(children: [
          AnnoncePage(),
          LoginPage(),
          ChatListScreen(),
          Text('Page 3'),
        ]),
      ),
    );
  }
}
