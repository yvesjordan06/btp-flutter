import 'package:badges/badges.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/Chat/main.dart';
import 'package:btpp/Pages/Settings/index.dart';
import 'package:btpp/Pages/User/profile.dart';
import 'package:btpp/State/index.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/utils/notifications.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Components/tabButton.dart';
import '../../Pages/Annonces/main.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  int chatCount = 0;

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 4);

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('favicon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (
      id,
      title,
      body,
      payload,
    ) =>
            onSelectNotification(payload));
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterNotification.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: BlocListener<NotificationBloc, NotificationState>(
        bloc: notificationBloc,
        listener: (context, state) {
          print(state);
          if (state is NotificationOpenChat) {
            Navigator.pushNamed(
              context,
              'chats/see',
              arguments: state.chat,
            );
          }
        },
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
              BlocListener<ChatsBloc, ChatsState>(
                bloc: chatsBloc,
                listener: (context, state) {
                  if (state is ChatsFetchingSuccess) {
                    chatCount = state.chats
                        .map((f) => f.unread)
                        .toList()
                        .reduce((v, e) => v + e);
                  }
                },
                child: BlocBuilder<ChatsBloc, ChatsState>(
                  bloc: chatsBloc,
                  builder: (context, state) {
                    return Badge(
                      toAnimate: false,
                      showBadge: chatCount > 0,
                      badgeContent: Text(
                        chatCount.toString(),
                        style: TextStyle(fontSize: 8),
                      ),
                      child: TabButton(
                        text: 'Chat',
                        icon: Icon(Icons.chat_bubble),
                      ),
                    );
                  },
                ),
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
              ProfilePage.currentUser(),
            ]),
          ),
        ),
      ),
    );
  }
}
