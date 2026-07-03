import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/VerifyOtpResponseModel.dart';
import 'package:my_foodapp/Repository/login_repository.dart';
import 'package:my_foodapp/Services/AuthService.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpViewModel extends ChangeNotifier {
  final LoginRepository repository;

  OtpViewModel(this.repository);

  final AuthService _authService = AuthService();
  final int otpLength = 6;

  String otpMessageError = "";

  List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  String get otp => otpControllers.map((e) => e.text).join();

  bool isLoading = false;

  void onOtpChanged(String value, int index) {
    // Paste case
    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    // Normal typing
    if (value.isNotEmpty && index < otpLength - 1) {
      focusNodes[index + 1].requestFocus();
    } else {
      focusNodes[index].unfocus();
    }

    notifyListeners();
  }

  void onBackspace(int index) {
    if (otpControllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void _handlePaste(String value) {
    for (int i = 0; i < otpLength; i++) {
      otpControllers[i].text = i < value.length ? value[i] : '';
    }
    focusNodes.last.unfocus();
    notifyListeners();
  }

  void clearOtp() {
    for (var c in otpControllers) {
      c.clear();
    }
    focusNodes.first.requestFocus();
    notifyListeners();
  }

  Future<bool> verifyOtp() async {
    if (otp.length != otpLength) {
      otpMessageError = "Please enter the OTP";
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(repository.getPhoneNumber(), otp);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        VerifyOtpResponseModel verifyOtpModel = VerifyOtpResponseModel.fromJson(json);
        print("object: ${verifyOtpModel.data!.token}");
        if (verifyOtpModel.status ?? false) {
          final data = verifyOtpModel.data;
          if (data != null && data.user != null && data.token != null) {
            // String userJson = jsonEncode(data.user!.toJson()); // Safe to use ! here because we checked data.user != null above

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(Const.TOKEN_KEY, data.token!);

            return true;
          } else {
            otpMessageError = "User data missing from response.";
            return false;
          }
        } else {
          otpMessageError = verifyOtpModel.message!;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      otpMessageError = "Something went wrong";
      return false;
    } finally {
      // // Todo: Need to remove from here
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString(Const.TOKEN_KEY, "12334567890");

      isLoading = false;
      notifyListeners();
    }
  }

  void disposeAll() {
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
  }
}
