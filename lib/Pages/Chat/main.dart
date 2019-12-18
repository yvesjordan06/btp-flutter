import 'package:btpp/Components/recent-chats.dart';
import 'package:btpp/Components/recent-contacts.dart';
import 'package:btpp/Functions/Colors.dart';
import 'package:btpp/Models/message-model.dart';

import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[RecentContacts()],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              RecentChats(),
            ]),
          )
        ],
      ),
    );
  }
}
