import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categoryservice {
  //  GETALL CATEGORY API.

  Future<Map<String, dynamic>?> getAllCategory() async {
    final url = Const.BASE_URL + Const.GET_ALL_CATEGORY;
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("catogary: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("dgdgdgdgh: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // GetAll SubCategory API.

  Future<Map<String, dynamic>?> getAllSubCategory() async {
    final url = Const.BASE_URL + Const.GET_ALL_SUBCATEGORY;
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("getallsubcategory: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("dgdgdgdgh: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
