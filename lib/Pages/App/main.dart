import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/Chat/main.dart';
import 'package:btpp/Pages/Settings/index.dart';
import 'package:btpp/State/index.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import '../../Components/tabButton.dart';
import '../../Pages/Annonces/main.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    AppState.userState.addListener(_userVerification);
    super.initState();
  }

  void _userVerification() {
    UserModel user = AppState.userState.currentUser;
    if (user == null) Navigator.pushReplacementNamed(context, 'auth');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: TabBar(
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
            // ImageViewer(),
            ActuPage(),
            ChatListScreen(),
            UserSettingPage(),
          ]),
        ),
      ),
    );
  }
}
