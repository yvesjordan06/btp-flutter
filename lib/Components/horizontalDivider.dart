import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget horizontalDivider({text, double margin = 5}) {
  return HorizontalDivider(
    text: text,
    margin: margin,
  );
}

class HorizontalDivider extends StatelessWidget {
  final String text;
  final double margin;

  const HorizontalDivider({
    Key key,
    this.text,
    this.margin = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
            margin: text == null
                ? EdgeInsets.only(left: margin)
                : EdgeInsets.symmetric(horizontal: margin),
          ),
        ),
        text == null
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.5),
                ),
              ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
            margin: text == null
                ? EdgeInsets.only(right: margin)
                : EdgeInsets.symmetric(horizontal: margin),
          ),
        ),
      ],
    );
  }
}
