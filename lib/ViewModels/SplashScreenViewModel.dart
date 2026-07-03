import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:my_foodapp/Views/home_screen.dart';
import 'package:my_foodapp/Views/intro_screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel extends ChangeNotifier {
  Future<void> checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tokenValue = prefs.getString(Const.TOKEN_KEY);

    if (tokenValue == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => IntroScreen1()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }
}
