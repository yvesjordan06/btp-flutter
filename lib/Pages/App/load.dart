import 'package:btpp/Pages/App/auth.dart';
import 'package:btpp/Pages/App/main.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc()..add(AppStarted());
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUnauthenticated) return AuthApp();
          if (state is AuthenticationAuthenticated) return MainApp();
          return SplashScreen();
        },
      ),
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
