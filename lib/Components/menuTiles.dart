import 'package:flutter/material.dart';

class MenuToggle extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool) onToggle;

  const MenuToggle({
    Key key,
    @required this.text,
    @required this.onToggle,
    this.value = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        dense: true,
        onTap: () {
          onToggle(!value);
        },
        contentPadding: EdgeInsets.all(0),
        title: Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Switch(
          onChanged: onToggle,
          value: value,
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String text;
  final String value;
  final VoidCallback onTap;

  const MenuTile({
    Key key,
    @required this.text,
    this.value = '',
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
          dense: true,
          onTap: onTap,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            text,
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                width: 2,
              ),
              if (value.isNotEmpty)
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  // color: Colors.grey,
                )
            ],
          )),
    );
  }
}
