import 'dart:convert';

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
      print("resId: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("wetter: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
