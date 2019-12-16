import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Annonces/create.dart';
import 'package:btpp/Pages/Annonces/see.dart';
import 'package:btpp/Pages/App/auth.dart';
import 'package:btpp/Pages/App/load.dart';
import 'package:btpp/Pages/App/main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case 'loading':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      case 'app':
        return MaterialPageRoute(builder: (_) => MainApp());
      case 'auth':
      return MaterialPageRoute(builder: (_) => AuthApp());
      case 'annonce/see':
      // Validation of correct data typ
        if (args is AnnonceModel) {
          return MaterialPageRoute(
            builder: (_) => SeeAnnonce(
              annonce: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'annonce/create':
        return MaterialPageRoute(builder: (_) => CreateAnnonce());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
