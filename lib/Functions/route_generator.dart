import 'package:btpp/Pages/Annonces/demandes.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/Auth/login.dart';
import 'package:btpp/Pages/Auth/passwordreset.dart';
import 'package:btpp/Pages/Auth/signup.dart';
import 'package:btpp/Pages/Chat/main.dart';
import 'package:btpp/Pages/Chat/see.dart';
import 'package:btpp/Pages/Metier/add.dart';
import 'package:btpp/Pages/Metier/index.dart';
import 'package:btpp/Pages/Settings/index.dart';
import 'package:btpp/Pages/User/cv.dart';
import 'package:btpp/Pages/User/profile.dart';
import 'package:flutter/material.dart';

import '../Models/annonce.dart';
import '../Pages/Annonces/create.dart';
import '../Pages/Annonces/postule.dart';
import '../Pages/Annonces/see.dart';
import '../Pages/App/auth.dart';
import '../Pages/App/load.dart';
import '../Pages/App/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case 'loading':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      case 'metiers':
        return MaterialPageRoute(builder: (_) => MetierPage());
      case 'profile':
        if (args is UserModel) {
          return MaterialPageRoute(
            builder: (_) => ProfilePage(
              user: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'metiers/add':
        return MaterialPageRoute(builder: (_) => AddMetierPage());
      case 'settings':
        return MaterialPageRoute(builder: (_) => UserSettingPage());
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
        if (args is ChatModel) {
          return MaterialPageRoute(
            builder: (_) => DemandesAnnoncePage(
              chat: args,
            ),
          );
        }

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'cv':
        // Validation of correct data typ
        if (args is UserModel) {
          return MaterialPageRoute(
            builder: (_) => CVPage(
              user: args,
            ),
          );
        }

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case 'images/see':
        if (args is ImageViewerRouteArgument) {
          if (args.isFile)
            return MaterialPageRoute(
              builder: (_) => DismissableImage.file(
                args.image,
                tag: args.tag,
              ),
            );
          if (args.isMemory)
            return MaterialPageRoute(
              builder: (_) => DismissableImage.memory(
                args.image,
                tag: args.tag,
              ),
            );
          if (args.isNetwork)
            return MaterialPageRoute(
              builder: (_) => DismissableImage.network(
                args.image,
                tag: args.tag,
              ),
            );
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

void navigateTo(BuildContext context, String page, {arguments}) {
  switch (page) {
    case 'settings':
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return UserSettingPage();
      }));
      break;
    default:
  }
}
