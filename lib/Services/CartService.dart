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
    final url = '${Const.BASE_URL}${Const.ADD_TO_CART}';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Const.TOKEN_KEY);
    // Yeh server ko bata raha hai ki jo data hum bhej rahe hain, wo JSON format mai hai.
    final headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(addRequest.toJson()));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception("API Error: Status ${response.statusCode} - ${response.body}");
    }
  }

  // GetALL Cart API.

  Future<Map<String, dynamic>?> getAllCart() async {
    final url = Const.BASE_URL + Const.GET_ALL_CART;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // Get AllActiveCoupon API.

  Future<Map<String, dynamic>?> getAllActiveCoupon() async {
    final url = Const.BASE_URL + Const.GET_ALL_ACTIVE_COUPON;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // Remove Cart API.

  Future<Map<String, dynamic>?> removeCart(String id) async {
    final url = Uri.parse(Const.BASE_URL + Const.REMOVE_CART);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final bodyValue = jsonEncode({'cart_item_id': id});

    final response = await http.post(url, headers: headerValue, body: bodyValue);

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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  //  RemoveCoupon FromCart API.

  Future<Map<String, dynamic>?> removeCoupon(String code) async {
    final url = Uri.parse(Const.BASE_URL + Const.REMOVE_COUPON_FROM_CART);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final bodyValue = jsonEncode({'code': code});

    final response = await http.post(url, headers: headerValue, body: bodyValue);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // PLACEORDER API.

  Future<PlaceOrderResponseModel> placeOrder(PlaceOrderRequestModel requestModel) async {
    final url = Const.BASE_URL + Const.PLACE_ORDER;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headers = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(requestModel.toJson()));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return PlaceOrderResponseModel.fromJson(jsonMap);
    } else {
      throw Exception("Failed to place order: ${response.statusCode}");
    }
  }

  // GetMyOrder API.

  Future<Map<String, dynamic>?> getMyOrder({String? type, int? page, int? limit}) async {
    final url = Const.BASE_URL + Const.GET_MY_ORDER + "?type=$type&page=$page&limit=$limit";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(url), headers: headerValue);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }

  // TrackOrder API.

  Future<Map<String, dynamic>?> trackOrder(String orderId) async {
    final baseUrl = Const.BASE_URL + Const.TRACK_ORDER;
    final finalUri = Uri.parse(baseUrl).replace(queryParameters: {'id': orderId});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Const.TOKEN_KEY);

    final headerValue = {'Content-Type': 'application/json;charset=UTF-8', 'Authorization': 'Bearer $token'};

    final response = await http.get(finalUri, headers: headerValue);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
