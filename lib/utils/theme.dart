import 'package:btpp/Functions/Utility.dart';
import 'package:flutter/material.dart';

ThemeData basicTheme() {
  final ThemeData app = ThemeData.light();

  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(color: Colors.black, fontSize: 22),
      button: base.button.copyWith(color: AppColor.background),
    );
  }

  ButtonThemeData _basicButtonTheme(ButtonThemeData base) {
    return base.copyWith(
        buttonColor: AppColor.primaryColor, textTheme: ButtonTextTheme.primary);
  }

  IconThemeData _basicIconTheme(IconThemeData base) {
    return base.copyWith(color: AppColor.basic);
  }

  FloatingActionButtonThemeData _basicFabTheme(
      FloatingActionButtonThemeData base) {
    return base.copyWith(
      backgroundColor: AppColor.accentColor,
    );
  }

  return app.copyWith(
    textTheme: _basicTextTheme(app.textTheme),
    primaryColor: AppColor.primaryColor,
    accentColor: AppColor.accentColor,
    buttonTheme: _basicButtonTheme(app.buttonTheme),
    iconTheme: _basicIconTheme(app.iconTheme),
    floatingActionButtonTheme: _basicFabTheme(app.floatingActionButtonTheme),
    tabBarTheme: app.tabBarTheme.copyWith(
      labelColor: AppColor.primaryColor,
      unselectedLabelColor: AppColor.basic,
    ),
  );
}
