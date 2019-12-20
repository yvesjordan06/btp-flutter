import 'package:flutter/material.dart';

import 'horizontalDivider.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final bool underlined;
  const HeaderText({
    Key key,
    @required this.text,
    this.underlined = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
        ),
        SizedBox(
          height: 5,
        ),
        if (underlined) HorizontalDivider(margin: 0),
      ],
    );
  }
}
