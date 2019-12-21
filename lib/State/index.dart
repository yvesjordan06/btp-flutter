import 'package:btpp/State/user.dart';

class AppState {
  static final UserState userState = UserState();

  static Future<void> loadState() {
    return Future.delayed(Duration(seconds: 1));
  }
}
