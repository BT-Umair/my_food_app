import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/GetAddressResponseModel.dart';
import 'package:my_foodapp/Models/GetAllCategoryResponseModel.dart';
import 'package:my_foodapp/Models/RestaurantListResponseModel.dart';
import 'package:my_foodapp/Services/AddressService.dart';
import 'package:my_foodapp/Services/CategoryService.dart';
import 'package:my_foodapp/Services/RestaurantService.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }

  String? firstLetter = "";

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString(Const.NAME);
    prefs.getString(Const.EMAIL);
    if (name!.length > 0) {
      firstLetter = name![0];
    }
  }

  bool isLoading = true;
  final Addressservice _addressservice = Addressservice();
  final Categoryservice _categoryservice = Categoryservice();
  final Restaurantservice _restaurantservice = Restaurantservice();

  GetAddressResponseModel getAddressResponseModel = GetAddressResponseModel();
  GetAllCategoryResponseModel getAllCategoryResponseModel = GetAllCategoryResponseModel();
  RestaurantListResponseModel restaurantListResponseModel = RestaurantListResponseModel();

  Future<bool> getAddressApi(BuildContext context, String? id) async {
    notifyListeners();

    try {
      final response = await _addressservice.getAddress(id!);
      print('$response');
      getAddressResponseModel = GetAddressResponseModel.fromJson(response!);

      if (getAddressResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAddressResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //Get All Category.

  Future<bool> getAllCategory(BuildContext context) async {
    notifyListeners();

    try {
      final response = await _categoryservice.getAllCategory();

      getAllCategoryResponseModel = GetAllCategoryResponseModel.fromJson(response!);
      print('dbgtny $response');

      if (getAllCategoryResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllCategoryResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //   Restaurant List API.

  Future<bool> restaurantList(BuildContext context) async {
    notifyListeners();

    try {
      final response = await _restaurantservice.restaurantList();

      restaurantListResponseModel = RestaurantListResponseModel.fromJson(response!);
      print('$response');

      if (restaurantListResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(restaurantListResponseModel.message!)));
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
