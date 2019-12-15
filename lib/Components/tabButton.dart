import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final Icon icon;
  final Text text;
  const TabButton({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          icon,
          text
        ],
      ),
    );
  }
}