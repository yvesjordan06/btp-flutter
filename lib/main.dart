import 'package:btpp/bloc/counter_bloc.dart';
import 'package:btpp/bloc/counter_event.dart';
import 'package:btpp/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Functions/route_generator.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: basicTheme(),
      initialRoute: 'loading',
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: App1(),
    );
  }
}

class App1 extends StatefulWidget {
  App1({Key key}) : super(key: key);

  @override
  _App1State createState() => _App1State();
}

class _App1State extends State<App1> {
  final CounterBloc counter = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.account_box),
        onPressed: () {
          counter.add(CounterIncrement());
        },
      ),
      body: Container(
        child: BlocBuilder<CounterBloc, int>(
          bloc: counter,
          builder: (BuildContext context, int state) {
            return Column(
              children: <Widget>[
                Text('something $state'),
                FlatButton.icon(
                  icon: Icon(Icons.ac_unit),
                  label: Text('Increase'),
                  onPressed: () {
                    counter.add(CounterIncrement());
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
