import 'package:btpp/Models/message-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentContacts extends StatelessWidget {
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
                itemCount: recents.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: AssetImage('images/favicon.png'),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            recents[index].name,
                            style: TextStyle(
                                color: Colors.white,
                                // fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
