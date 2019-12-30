import 'package:btpp/Functions/route_generator.dart';
import 'package:btpp/Pages/App/auth.dart';
import 'package:btpp/Pages/App/main.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authBloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationUninitialized) return SplashScreen();
        if (state is AuthenticationUnauthenticated) {
          print('Unauthenticated');
          return AuthApp();
        }
        return MainApp();
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
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
                  shadows: [
                    Shadow(
                        color: Colors.grey,
                        offset: Offset.zero,
                        blurRadius: 0.8)
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
