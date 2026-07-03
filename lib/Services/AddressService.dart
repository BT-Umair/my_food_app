import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_foodapp/Models/AddAddressRequestModel.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  Add Address API.

class Addressservice {
  Future<http.Response> addAddress(AddAddressRequestModel addRequest) async {
    final url = Const.BASE_URL + Const.ADD_ADDRESS;
    print('url $url,$addRequest');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);
    print(token);
    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.post(Uri.parse(url), headers: headerValue, body: jsonEncode(addRequest.toJson()));
    print('response ${response.body}');
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return response;
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  Get All Address API.

  Future<Map<String, dynamic>?> getAllAddress() async {
    final url = Const.BASE_URL + Const.GET_All_ADDRESS;
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("addresses: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("addresses: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  Get Address API.

  Future<Map<String, dynamic>?> getAddress(String id) async {
    final baseUri = Uri.parse(Const.BASE_URL + Const.GET_ADDRESS);
    final url = baseUri.replace(queryParameters: {'id': id});
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headerValue);

    if (response.statusCode == 200) {
      print("addressertgtynssss: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("addressesdccf: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // SetDefault API.

  Future<Map<String, dynamic>?> setDefault(String id) async {
    final baseUri = Uri.parse(Const.BASE_URL + Const.SET_DEFAULT);
    final url = baseUri.replace(queryParameters: {'id': id});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headerValue);

    if (response.statusCode == 200) {
      await prefs.setString('ADDRESS_ID', id);

      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // Update Address API..

  Future<http.Response> updateAddress(EditAddressRequestModel addRequest) async {
    final url = Const.BASE_URL + Const.UPDATE_ADDRESS;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.put(Uri.parse(url), headers: headerValue, body: jsonEncode(addRequest.toJson()));
    print('response $response');
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return response;
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  DeleteAddress API.

  Future<Map<String, dynamic>?> deleteAddress(String id) async {
    final baseUri = Uri.parse(Const.BASE_URL + Const.DELETE_ADDRESS);
    final url = baseUri.replace(queryParameters: {'id': id});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.delete(url, headers: headerValue);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
