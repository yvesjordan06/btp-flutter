import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Functions/route_generator.dart';

BuildContext appContext;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appContext = context;
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authBloc,
      child: Center(
        child: true
            ? MaterialApp(
                title: 'BTP Partnership',
                initialRoute: 'loading',
                debugShowCheckedModeBanner: false,
                theme: basicTheme(),
                onGenerateRoute: RouteGenerator.generateRoute,
                //home: LoadingPage(),
              )
            : TestGal(),
      ),
    );
  }
}

class TestGal extends StatefulWidget {
  final int maximum;

  TestGal({Key key, this.maximum = 10}) : super(key: key);

  @override
  _TestGalState createState() => _TestGalState();
}

class _TestGalState extends State<TestGal> {
  List<File> images = [];
  List<int> selected = [];

  @override
  void initState() {
    super.initState();
    PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.storage]).then((v) {
      print(v);
    });
    getApplicationDocumentsDirectory().then((d) {
      d = Directory('/sdcard');
      //print(d.path);
      d.list(followLinks: false, recursive: true).listen((f) {
        print(f.path);

        if (!f.path.contains("/.") && f.path.endsWith('.jpg')) {
          images.add(File(f.path));
        }
      }).onDone(() {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('${selected.length} sur ${widget.maximum} selectionées'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check_circle),
              onPressed: () {},
            )
          ],
        ),
        body: new GridView.builder(
            itemCount: images.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4),
            itemBuilder: (BuildContext context, int index) {
              return Material(
                child: InkWell(
                  onTap: () {
                    if (selected.length >= widget.maximum &&
                        !selected.contains(index)) {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Maximum atteint'),
                      ));
                    } else
                      setState(() {
                        if (selected.contains(index))
                          selected.remove(index);
                        else
                          selected.add(index);
                      });
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 60,
                            maxHeight: 20,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // if (selected.contains(index))
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.check),
                          ),
                          duration: Duration(milliseconds: 200),
                          opacity: selected.contains(index) ? 1.0 : 0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
