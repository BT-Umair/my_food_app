import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_foodapp/Models/UpdateProfileRequestModel.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Send OTP API.

  Future<http.Response> sendOtp(String phoneNumber) async {
    final url = Const.BASE_URL + Const.SEND_OTP;
    print('url $url, $phoneNumber');
    final response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: jsonEncode({"phoneNumber": phoneNumber}));
    print('response $response');
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return response;
    } else {
      print('response ${response.statusCode}');
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //   Verify OTP API.

  Future<http.Response> verifyOtp(phoneNumber, otp) async {
    final url = Const.BASE_URL + Const.VERIFY_OTP;

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phoneNumber": phoneNumber, "otp": otp}),
    );
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return response;
    } else {
      print('response ${response.statusCode}');
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //   GetProfile API.

  Future<http.Response> getProfile() async {
    final url = Const.BASE_URL + Const.GET_PROFILE;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //   UpdateProfile API.

  Future<http.Response> updateProfile(UpdateProfileRequestModel updateProfileRequestModel) async {
    final url = Const.BASE_URL + Const.UPDATE_PROFILE;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.put(
      Uri.parse(url),
      headers: headerValue,
      body: jsonEncode(
        updateProfileRequestModel.toJson(),
      ), // When we pass the model to the api, we need to convert that model into json string  with the help of jsonEncode function.
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
