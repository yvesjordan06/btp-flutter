import 'package:badges/badges.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentContacts extends StatelessWidget {
  final List<ChatModel> list;

  RecentContacts(this.list);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Contact Récent',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'chats/see',
                            arguments: list[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Badge(
                              badgeContent: Text(list[index].unread.toString()),
                              badgeColor: Theme.of(context).accentColor,
                              showBadge: list[index].unread > 0,
                              child: UserImage(
                                user: list[index].contact,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              list[index].contact.nom,
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
