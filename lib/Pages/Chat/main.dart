import 'package:btpp/Components/recent-chats.dart';
import 'package:btpp/Components/recent-contacts.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Repository/ChatsRepository.dart';
import 'package:btpp/State/index.dart';
import 'package:btpp/State/user.dart';

import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  UserState userState = AppState.userState;

  UserModel currentUser = AppState.userState.currentUser;

  List<ChatModel> list = exampleChatList;

  @override
  void initState() {
    userState.addListener(() {
      if (mounted)
        setState(() {
          UserModel newstate = AppState.userState.currentUser;
          if (newstate != null) currentUser = AppState.userState.currentUser;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColorsOpacity(1),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                // iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'app');
                },
              )
            ],
            pinned: true,
            expandedHeight: 220,
            title: Text(
              'Conversations',
              style: TextStyle(
                  // fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                // color: AppColor().accentColor(),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[RecentContacts()],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              RecentChats(
                chats: list,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
