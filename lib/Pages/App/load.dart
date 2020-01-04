import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Pages/App/auth.dart';
import 'package:btpp/Pages/App/main.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authBloc,
      builder: (BuildContext context, AuthenticationState state) {
        print('load 21 $state');
        if (state is AuthenticationUninitialized) return SplashScreen();
        if (state is AuthenticationUnauthenticated) {
          // print('Unauthenticated');
          return AuthApp();
        }
        return MainApp();
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "BTP Partnership",
        description: "Bienvenu dans un monde au le travaille est facile",
        pathImage: "images/favicon.png",
          colorBegin: AppColor.accentColor,
          colorEnd: AppColor.primaryColor
      ),
    );
    slides.add(
      new Slide(
        title: "TRAVAILLER",
        description: "Trouvez du travaille et gagner de l'argent facilement",
        centerWidget: Icon(Icons.account_balance_wallet, size: 128, color: AppColor.primaryColor,),
        //pathImage: "images/photo_pencil.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "LANCEZ VOUS",
        description:
        "Commençont en beauté",
        centerWidget: Icon(Icons.directions_run, size: 128, color: AppColor.accentColor,),
        //backgroundColor: Color(0xff9932CC),
        colorBegin: AppColor.primaryColor,
        colorEnd: AppColor.accentColor
      ),
    );
  }

  void onDonePress() {
    // Do what you want
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: () {authBloc.add(AppStarted());},
      colorActiveDot: AppColor.accentColor,
      colorDot: AppColor.primaryColorsOpacity(0.5),
      nameNextBtn: 'Suivant',
      namePrevBtn: 'Precedent',
      nameDoneBtn: 'Go!',
      nameSkipBtn: 'Passer',
      shouldHideStatusBar: true,
    );
  }
}
