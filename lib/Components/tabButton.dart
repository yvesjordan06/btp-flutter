import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final Icon icon;
  final String text;
  const TabButton({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 40),
      margin: EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          icon,
          Text(
            text,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
