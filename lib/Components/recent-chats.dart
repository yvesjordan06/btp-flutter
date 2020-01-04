import 'package:badges/badges.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentChats extends StatefulWidget {
  final List<ChatModel> chats;

  @override
  const RecentChats({Key key, @required this.chats})
      : assert(chats != null),
        super(key: key);

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
        color: AppColor.background,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.chats.length,
          itemBuilder: (a, index) => Material(
                child: ListTile(
                  onTap: () {
                    {
                      Navigator.pushNamed(context, 'chats/see',
                          arguments: widget.chats[index]);
                    }
                  },
                  title: Hero(
                    child: Text(
                      widget.chats[index].contact.nom,
                      style: Theme.of(context).textTheme.title,
                    ),
                    tag: 'nom' + widget.chats[index].hashCode.toString(),
                  ),
                  leading: Container(
                    constraints: BoxConstraints.expand(width: 50),
                    child: Stack(children: [
                      Hero(
                        child: UserImage(
                          user: widget.chats[index].contact,
                        ),
                        tag: 'image' + widget.chats[index].hashCode.toString(),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: Badge(
                          badgeColor: widget.chats[index].lastMessage.sentAt
                                  .isBefore(
                                      DateTime.now().add(Duration(minutes: 5)))
                              ? Colors.green[400]
                              : Colors.red[300],
                        ),
                      ),
                    ]),
                  ),
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.chats[index].annonceModel.intitule,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.chats[index].lastMessage.text,
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        DateFormat.Hm()
                            .format(widget.chats[index].lastMessage.sentAt),
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      if (widget.chats[index].unread > 0)
                        Badge(
                          badgeContent:
                              Text(widget.chats[index].unread.toString()),
                          badgeColor: ThemeData().primaryColor,
                          showBadge: true,
                        ),
                      if (!widget.chats[index].lastMessage.sender)
                        Icon(
                          Icons.done,
                          size: 11,
                          color: Colors.grey,
                        )
                    ],
                  ),
                ),
              )),
    );
  }
}
