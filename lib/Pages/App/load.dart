import 'package:btpp/State/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  initState() {
    super.initState();
    print('init method');
    appUser.loadSavedUser().then((user){
      _loadPage();
    });
  }
  void _loadPage() {

    if (appUser.currentUser != null) {
      Navigator.pushReplacementNamed(context, 'app');
    } else {
      Navigator.pushReplacementNamed(context, 'auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
                'images/favicon.png',
              width: 200,
            ),
            CircularProgressIndicator(),
            Text(
              'BY MOS',
              style: TextStyle(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
                shadows: [Shadow(
                  color: Colors.grey,
                  offset: Offset.zero,
                  blurRadius: 0.8
                )]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
