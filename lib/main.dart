import 'package:btpp/Pages/App/load.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:btpp/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'Functions/route_generator.dart';

BuildContext appContext;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appContext = context;
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authBloc /*..add(AppStarted())*/,
      child: Center(
        child: MaterialApp(
          title: 'BTP Partnership',
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
