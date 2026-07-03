import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_foodapp/Models/AddToCartRequestModel.dart';
import 'package:my_foodapp/Models/PlaceOrderRequestModel.dart';
import 'package:my_foodapp/Models/PlaceOrderResponseModel.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cartservice {
  // Add To Cart API.

  Future<http.Response> addtoCart(AddToCartRequestModel addRequest) async {
    final url = Const.BASE_URL + Const.ADD_TO_CART;
    print('url $url,$addRequest');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.post(Uri.parse(url), headers: headerValue, body: jsonEncode(addRequest.toJson()));
    print("$response");

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // GetALL Cart API.

  Future<Map<String, dynamic>?> getAllCart() async {
    final url = Const.BASE_URL + Const.GET_ALL_CART;
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

  // Get AllActiveCoupon API.

  Future<Map<String, dynamic>?> getAllActiveCoupon() async {
    final url = Const.BASE_URL + Const.GET_ALL_ACTIVE_COUPON;
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

  // Remove Cart API.

  Future<Map<String, dynamic>?> removeCart(String id) async {
    final url = Uri.parse(Const.BASE_URL + Const.REMOVE_CART);

    print("API URL: $url");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);
    print("API Token: $token");

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final bodyValue = jsonEncode({'cart_item_id': id});
    print("API Body sent: $bodyValue");

    final response = await http.delete(url, headers: headerValue, body: bodyValue);

    print("API Status Code: ${response.statusCode}");
    print("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  Update CartItem API.

  Future<Map<String, dynamic>?> updateCart(String id, int quantity) async {
    final url = Uri.parse(Const.BASE_URL + Const.UPDATE_CART);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final bodyValue = jsonEncode({'cart_item_id': id, 'quantity': quantity});

    final response = await http.put(url, headers: headerValue, body: bodyValue);

    print("API Update Status Code: ${response.statusCode}");
    print("API Update Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // ApplyCoupon Code API.

  Future<Map<String, dynamic>?> applyCoupon(String code) async {
    final url = Uri.parse(Const.BASE_URL + Const.APPLY_COUPON_CODE);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final bodyValue = jsonEncode({'code': code});

    final response = await http.post(url, headers: headerValue, body: bodyValue);

    print("API Update Status Code: ${response.statusCode}");
    print("API Update Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  RemoveCoupon FromCart API.

  Future<Map<String, dynamic>?> removeCoupon(String code) async {
    final url = Uri.parse(Const.BASE_URL + Const.REMOVE_COUPON_FROM_CART);

    print("API URL: $url");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);
    print("API Token: $token");

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final bodyValue = jsonEncode({'code': code});
    print("API Remove Body sent: $bodyValue");

    final response = await http.post(url, headers: headerValue, body: bodyValue);

    print("API Status Code: ${response.statusCode}");
    print("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // PLACEORDER API.

  Future<PlaceOrderResponseModel> placeOrder(PlaceOrderRequestModel requestModel) async {
    final url = Const.BASE_URL + Const.PLACE_ORDER;
    print('Request URL: $url, Data: ${jsonEncode(requestModel.toJson())}');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headers = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(requestModel.toJson()));

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return PlaceOrderResponseModel.fromJson(jsonMap);
    } else {
      throw Exception("Failed to place order: ${response.statusCode}");
    }
  }

  // GetMyOrder API.

  Future<Map<String, dynamic>?> getMyOrder() async {
    final url = Const.BASE_URL + Const.GET_MY_ORDER;
    print(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      print("order: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("order: ${response.statusCode}");
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
