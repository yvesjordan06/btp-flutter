import 'package:btpp/Functions/Utility.dart';
import 'package:flutter/cupertino.dart';

class AppColors {
  // static final Color primary = Color.fromRGBO(56, 128, 255, 1);
  static final Color primary = AppColor().primaryColor();
  static final Color primaryDark = Color.fromRGBO(0, 57, 203, 1);
  // static final Color accent = Color.fromRGBO(239, 108, 0, 1);
  static final Color accent = AppColor().accentColor();
}
