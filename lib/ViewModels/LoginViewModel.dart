import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/SendOtpResponseModel.dart';
import 'package:my_foodapp/Repository/login_repository.dart';
import 'package:my_foodapp/Services/AuthService.dart';
import 'package:my_foodapp/Services/auth_method.dart';
import 'package:my_foodapp/Utils/CommonUtils.dart';
import 'package:my_foodapp/Views/home_screen.dart';
import 'package:my_foodapp/Views/otp_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final LoginRepository repository;

  LoginViewModel(this.repository);

  String phone = "";
  String? phoneError;

  bool isLoading = false;
  Future<void> signInwithGoogle(BuildContext context) async {
    try {
      final UserCredential = await GoogleSignInService.signInWithGoogle();

      if (UserCredential != null) {
        print('user signed in : ${UserCredential.user?.displayName}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print("login failed");
      }
    } catch (e) {
      SnackBar(content: Text("Google Login Failed"));

      print('sign in error $e');
    }
  }

  void setPhone(String value) {
    phone = value;
  }

  bool validate() {
    if (phone.isEmpty) {
      phoneError = "Please enter mobile number";
    } else if (phone.length < 10) {
      phoneError = "Please enter valid number";
    } else {
      phoneError = null;
    }

    notifyListeners();
    return phoneError == null;
  }

  Future<bool> login(BuildContext context) async {
    bool isConnected = await CommonUtils.isInternetAvailable(context);

    if (!isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check your Internet connectivity.")));
      return false;
    }
    if (!validate()) return false;

    isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.sendOtp(phone);
      print('response7dfytu ${response.body}');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        SendOtpResponseModel sendOtpModel = SendOtpResponseModel.fromJson(json);

        if (sendOtpModel.status!) {
          repository.setPhoneNumber(phone);
          Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen()));

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${sendOtpModel.message}. ${sendOtpModel.data!.otp!}")));
          return true;
        } else {
          phoneError = sendOtpModel.message!;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      phoneError = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
      return true;
    }
  }
}
