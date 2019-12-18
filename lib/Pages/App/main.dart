import 'package:btpp/Pages/Chat/main.dart';
import 'package:btpp/Pages/Settings/index.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

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
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Appuyez de nouveau pour quitter'),
          ),
          child: TabBarView(children: [
            AnnoncePage(),
            LoginPage(),
            ChatListScreen(),
            UserSettingPage(),
          ]),
        ),
      ),
    );
  }
}
