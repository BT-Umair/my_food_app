import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/AddToCartRequestModel.dart';
import 'package:my_foodapp/Models/AddToCartResponseModel.dart';
import 'package:my_foodapp/Models/GetAllMenuItemsResponseModel.dart';
import 'package:my_foodapp/Models/GetMenuItemsResponseModel.dart';
import 'package:my_foodapp/Services/CartService.dart';
import 'package:my_foodapp/Services/RestaurantService.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  bool isLoading = true;
  final Restaurantservice _restaurantservice = Restaurantservice();
  final Cartservice _cartservice = Cartservice();

  GetAllMenuItemsResponseModel getAllMenuItemsResponseModel = GetAllMenuItemsResponseModel();
  GetMenuItemsResponseModel getMenuItemsResponseModel = GetMenuItemsResponseModel();
  AddToCartResponseModel addToCartResponseModel = AddToCartResponseModel();

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    notifyListeners();
  }

  int? selectedValue;

  void setSelectedValue(int value) {
    selectedValue = value;
    notifyListeners();
  }

  // Get AllMenu Items API.

  Future<bool> getAllMenuItems(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _restaurantservice.getAllMenuItems();

      getAllMenuItemsResponseModel = GetAllMenuItemsResponseModel.fromJson(response!);
      print('$response');

      if (getAllMenuItemsResponseModel.status!) {
        print('$response');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllMenuItemsResponseModel.message!)));
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
      return true;
    }
  }

  //  Get MenuItems by Id API.

  Future<bool> getMenuItems(BuildContext context, String? restaurantId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _restaurantservice.getMenuItems(restaurantId!);
      print('$response');
      getMenuItemsResponseModel = GetMenuItemsResponseModel.fromJson(response!);

      if (getMenuItemsResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getMenuItemsResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add To Cart API.

  Future<void> addToCart({required BuildContext context, required String menuId, required String restaurantId, required int quantity}) async {
    isLoading = true;
    notifyListeners();

    try {
      AddToCartRequestModel addToCartRequestModel = AddToCartRequestModel(menuId: menuId, restaurantId: restaurantId, quantity: quantity);

      final response = await _cartservice.addtoCart(addToCartRequestModel);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print("${response.body}");
        AddToCartResponseModel responseModel = AddToCartResponseModel.fromJson(json);

        if (responseModel.status == true && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseModel.message ?? "Item added to cart Successfully!")));
        }
      }
    } catch (e) {
      print("Error inside ViewModel addToCart: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
