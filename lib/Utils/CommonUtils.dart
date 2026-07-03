import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/VerifyOtpResponseModel.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonUtils {
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userData = prefs.getString(Const.USER);

    if (userData == null || userData.isEmpty) {
      return null;
    }

    return User.fromJson(jsonDecode(userData));
  }

  static Future<bool> isInternetAvailable(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      bool isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (isConnected) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check your Internet connectivity.")));

        return false;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check your Internet connectivity.")));
      return false;
    }
  }
}
