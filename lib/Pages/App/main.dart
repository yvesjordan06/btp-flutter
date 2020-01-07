import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/Chat/main.dart';
import 'package:btpp/Pages/User/profile.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Components/tabButton.dart';
import '../../Pages/Annonces/main.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  int chatCount = 0;

  TabController tabController;

  @override
  void initState() {
    // authBloc.add(AppStarted());
    tabController = TabController(vsync: this, length: 4)
      ..addListener(() {
        setState(() {
          _selectedIndex = tabController.index;
        });

        print('index is ' + tabController.index.toString());
      });

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

  int _selectedIndex = 0;
  bool quit = false;

  void quitCounter() async {
    setState(() {
      quit = true;
    });

    print('counter started');
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      quit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      bloc: notificationBloc,
      listener: (context, state) {
        //print(state);
        if (state is NotificationOpenChat) {
          Navigator.pushNamed(
            context,
            'chats/see',
            arguments: state.chat,
          );
        }
      },
      child: Scaffold(
        bottomSheet: quit
            ? Container(
                color: Colors.grey[850],
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Appuyez de nouveau pour quitter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : null,
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
              ),
            ],
          ),

          // padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //controller: tabController,
            children: List.generate(items.length, (index) {
              var bloc;

              switch (index) {
                case 0:
                  bloc = annoncesBloc;

                  break;
                case 1:
                  bloc = actuBloc;

                  break;
                case 2:
                  bloc = chatsBloc;

                  break;
                default:
                  bloc = null;
              }
              return bloc != null
                  ? StreamBuilder(
                stream: bloc.asBroadcastStream(),
                builder: (context, state) {
                  //print('main 113 $state.');
                  if ((index == 0 && state.data is AnnoncesError) ||
                      (index == 1 &&
                          state.data is ActuFetchedFailedState) ||
                      (index == 2 && state.data is ChatsFetchingFailed))
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        tabController.animateTo(index,
                            duration: Duration(milliseconds: 300));
                        if (index == 0) annoncesBloc.add(FetchAnnonce());
                        if (index == 1) actuBloc.add(ActuFetch());
                        if (index == 2) chatsBloc.add(ChatsFetch());
                      },
                      child: ItemWidget(
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor:
                        Theme.of(context).bottomAppBarColor,
                        iconSize: 24,
                        isSelected: _selectedIndex == index,
                        item: items[index],
                        itemCornerRadius: 50,
                        error: true,
                      ),
                    );
                  else
                    return InkWell(
                      onTap: () {
                        tabController.animateTo(index,
                            duration: Duration(milliseconds: 277));
                      },
                      child: ItemWidget(
                        animationDuration: Duration(milliseconds: 277),
                        backgroundColor:
                        Theme.of(context).bottomAppBarColor,
                        iconSize: 24,
                        isSelected: _selectedIndex == index,
                        item: items[index],
                        itemCornerRadius: 50,
                        badgeContent:
                        (index == 2 && chatsBloc.list != null)
                            ? chatsBloc.list
                            .where((t) => t.unread > 0)
                            .length
                            .toString()
                            : '',
                      ),
                    );
                },
              )
                  : InkWell(
                onTap: () {
                  tabController.animateTo(index,
                      duration: Duration(milliseconds: 300));
                },
                child: ItemWidget(
                  animationDuration: Duration(milliseconds: 277),
                  backgroundColor: Theme
                      .of(context)
                      .bottomAppBarColor,
                  iconSize: 24,
                  isSelected: _selectedIndex == index,
                  item: items[index],
                  itemCornerRadius: 50,
                ),
              );
            }),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (tabController.index != 0) {
              tabController.animateTo(0);
              return Future.value(false);
            } else {
              if (!quit) {
                quitCounter();
                return Future.value(false);
              }

              return Future.value(true);
            }
          },
          child: DefaultTabController(
            length: 4,
            child: TabBarView(controller: tabController, children: [
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

var items = [
  BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text('Annonce'),
      activeColor: AppColor.primaryColor,
      inactiveColor: AppColor.basic),
  BottomNavyBarItem(
      icon: Icon(Icons.public),
      title: Text('Actu'),
      activeColor: AppColor.primaryColor,
      inactiveColor: AppColor.basic
      //activeColor: Colors.purpleAccent
      ),
  BottomNavyBarItem(
      icon: Icon(Icons.message),
      title: Text('Messages'),
      activeColor: AppColor.primaryColor,
      inactiveColor: AppColor.basic
      // activeColor: Colors.pink
      ),
  BottomNavyBarItem(
      icon: Icon(Icons.person),
      title: Text('Compte'),
      activeColor: AppColor.primaryColor,
      inactiveColor: AppColor.basic
      //activeColor: Colors.blue
      ),
];
