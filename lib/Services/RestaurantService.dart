import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Restaurantservice {
  //  RESTAURANT LIST API.

  Future<Map<String, dynamic>?> restaurantList() async {
    final url = Const.BASE_URL + Const.RESTAURANT_LIST;
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("Error: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // GetAll MenuItems API.

  Future<Map<String, dynamic>?> getAllMenuItems({String? search}) async {
    var url = Const.BASE_URL + Const.GET_ALL_MENU_ITEMS;
    print(url);

    if (search != null && search.trim().isNotEmpty) {
      url += '?search=${Uri.encodeComponent(search.trim())}';
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("dffdgdfg: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("dgdgdgdgh: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  GetMenuItems ByRestaurantID API.

  Future<Map<String, dynamic>?> getMenuItems(String restaurantId) async {
    final baseUri = Uri.parse(Const.BASE_URL + Const.GET_MENU_ITEMS);
    final url = baseUri.replace(queryParameters: {'restaurantId': restaurantId});
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headerValue);

    if (response.statusCode == 200) {
      debugPrint("resId: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("wetter: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  ToggleWishList API.

  Future<Map<String, dynamic>?> toggleWishlist(String menuId) async {
    final url = Uri.parse(Const.BASE_URL + Const.TOGGLE_WISH_LIST);
    print("Request URL: $url");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.post(url, headers: headerValue, body: jsonEncode({'menuId': menuId}));

    if (response.statusCode == 200) {
      print("resId: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("wetter status: ${response.statusCode}");
      print("Error details: ${response.body}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  MyWishList API.

  Future<Map<String, dynamic>?> myWishlist() async {
    final url = Const.BASE_URL + Const.MY_WISH_LIST;
    print("Wishlist URL: $url");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("Wishlist Success: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("Wishlist Error Status: ${response.statusCode}");
      print("Wishlist Error Body: ${response.body}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // SaveRestaurant API.

  Future<Map<String, dynamic>?> toggleSaveRestaurant(String restaurantId) async {
    final url = Uri.parse(Const.BASE_URL + Const.TOGGLE_SAVE_RESTAURANT);
    print("Request URL: $url");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final parsedId = int.tryParse(restaurantId) ?? restaurantId;

    final Map<String, dynamic> bodyPayload = {'restaurantId': parsedId};

    final response = await http.post(url, headers: headerValue, body: jsonEncode(bodyPayload));

    if (response.statusCode == 200) {
      print("resId: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("Error details: ${response.body}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  Restaurant Saved API.

  Future<Map<String, dynamic>?> savedRestaurant() async {
    final url = Const.BASE_URL + Const.MY_SAVED_RESTAURANT;
    print("URL: $url");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("Error Status: ${response.statusCode}");
      print("Error Body: ${response.body}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
