import 'package:btpp/Pages/Annonces/demandes.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/Auth/login.dart';
import 'package:btpp/Pages/Auth/passwordreset.dart';
import 'package:btpp/Pages/Auth/signup.dart';
import 'package:btpp/Pages/Chat/main.dart';
import 'package:btpp/Pages/Chat/see.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../Models/annonce.dart';
import '../Pages/Annonces/create.dart';
import '../Pages/Annonces/postule.dart';
import '../Pages/Annonces/see.dart';
import '../Pages/App/auth.dart';
import '../Pages/App/load.dart';
import '../Pages/App/main.dart';
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
      case 'auth/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'auth/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case 'auth/reset':
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());
      case 'chat':
        return MaterialPageRoute(builder: (_) => ChatListScreen());
      case 'chats/see':
        return MaterialPageRoute(
            builder: (_) => SingleChatPage(
                  chat: args,
                ));
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
      case 'annonce/postuler':
        // Validation of correct data typ
        if (args is AnnonceModel) {
          return MaterialPageRoute(
            builder: (_) => PostulerPage(
              annonce: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'annonce/edit':
        // Validation of correct data typ
        if (args is AnnonceModel) {
          return MaterialPageRoute(
            builder: (_) => CreateAnnonce(
              annonce: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'annonce/demandes':
        // Validation of correct data typ
        if (args is AnnonceModel) {
          return MaterialPageRoute(
            builder: (_) => DemandesAnnoncePage(
              annonce: args,
            ),
          );
        }

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'images/see':
        if (args is Asset) {
          return MaterialPageRoute(
              builder: (_) => AssetImageViewer(
                    dismissable: true,
                    asset: args,
                    onDismiss: (dir) => Navigator.pop(_),
                  ));
        }
        return _errorRoute();
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
