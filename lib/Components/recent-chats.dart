import 'package:btpp/Models/message-model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatelessWidget {
  @override
  const RecentChats({Key key}) : super(key: key);
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
          itemBuilder: (a, index) => Container(
                child: ListTile(
                  onTap: () {
                    {
                      Navigator.pushNamed(context, 'chats/see');
                    }
                  },
                  title: Text(recentsChat[index].sender.name),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Image.asset('images/userfallback.png'),
                  ),
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Annonce intitule'),
                      Text(recentsChat[index].text)
                    ],
                  ),
                ),
              )),
    );
  }
}
