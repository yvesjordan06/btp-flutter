import 'package:btpp/Pages/App/load.dart';
import 'package:btpp/bloc/bloc.dart';

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
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      child: Center(
        child: MaterialApp(
          //initialRoute: 'loading',
          debugShowCheckedModeBanner: false,
          theme: basicTheme(),
          onGenerateRoute: RouteGenerator.generateRoute,
          home: LoadingPage(),
        ),
      ),
    );
  }
}
