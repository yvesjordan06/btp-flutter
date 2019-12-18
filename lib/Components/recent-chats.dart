import 'package:badges/badges.dart';
import 'package:btpp/Models/message-model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatefulWidget {
  @override
  const RecentChats({Key key}) : super(key: key);

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset.infinite, blurRadius: 3),
          BoxShadow(
              color: Colors.grey, offset: Offset.infinite, spreadRadius: 4)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recentsChat.length,
          itemBuilder: (a, index) => ListTile(
                onTap: () {
                  {
                    Navigator.pushNamed(context, 'chats/see');
                  }
                },
                title: Text(recentsChat[index].sender.name),
                leading: Container(
                  constraints: BoxConstraints.expand(width: 50),
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset('images/userfallback.png'),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: Badge(
                        badgeColor: Colors.red,
                      ),
                    ),
                  ]),
                ),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Annonce intitule',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(recentsChat[index].text)
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '11: 42',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Badge(
                      badgeContent: Text('2'),
                      badgeColor: ThemeData().primaryColor,
                      showBadge: false,
                    ),
                    Icon(
                      Icons.done,
                      size: 11,
                      color: Colors.grey,
                    )
                  ],
                ),
              )),
    );
  }
}
