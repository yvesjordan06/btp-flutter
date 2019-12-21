import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      persistentFooterButtons: <Widget>[],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: ThemeData().iconTheme.copyWith(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          MaterialBanner(
            actions: <Widget>[
              Icon(Icons.disc_full),
              Icon(Icons.outlined_flag),
              Icon(Icons.restore_page),
              Icon(Icons.settings_backup_restore),
              Icon(Icons.copyright),
            ],
            content: Text('Content'),
          ),
          Tooltip(
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('This is a title'),
                    content: Center(
                      child: Text('You have been loged Out'),
                    ),
                  );
                }));
              },
              child: Text('What the fuck'),
            ),
            message: 'What the fuck',
          ),
          Tooltip(
            child: MaterialButton(
              onPressed: () async {
                TimeOfDay a = await showDialog(
                  context: context,
                  barrierDismissible: true,
                  child: AlertDialog(
                    title: Text('text'),
                    content: Text('text'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.photo_size_select_large),
                        onPressed: () {},
                      )
                    ],
                  ),
                );
                print(a);
              },
              child: Text('Displays a dialog'),
            ),
            message: 'Dialog',
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.local_activity),
                border: OutlineInputBorder(),
                labelText: 'Nom',
                hintText: 'Votre Nom',
              ),
            ),
          )
        ],
      ),
    );
  }
}
