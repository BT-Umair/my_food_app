import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/AddToCartRequestModel.dart';
import 'package:my_foodapp/Models/AddToCartResponseModel.dart' hide Addons;
import 'package:my_foodapp/Models/GetAllMenuItemsResponseModel.dart';
import 'package:my_foodapp/Models/GetMenuItemsResponseModel.dart';
import 'package:my_foodapp/Models/MyWishListResponseModel.dart';
import 'package:my_foodapp/Models/SavedRestaurantResponseModel.dart';
import 'package:my_foodapp/Models/ToggleWishListResponseModel.dart';
import 'package:my_foodapp/Services/CartService.dart';
import 'package:my_foodapp/Services/RestaurantService.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  bool isLoading = true;

  final Restaurantservice _restaurantservice = Restaurantservice();
  final Cartservice _cartservice = Cartservice();

  GetAllMenuItemsResponseModel getAllMenuItemsResponseModel = GetAllMenuItemsResponseModel();
  GetMenuItemsResponseModel getMenuItemsResponseModel = GetMenuItemsResponseModel();
  AddToCartResponseModel addToCartResponseModel = AddToCartResponseModel();
  ToggleWishListResponseModel toggleWishListResponseModel = ToggleWishListResponseModel();
  MyWishListResponseModel myWishListResponseModel = MyWishListResponseModel();
  SavedRestaurantResponseModel savedRestaurantResponseModel = SavedRestaurantResponseModel();

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
    } catch (e, stacktrace) {
      debugPrint("Error loading menu: $e");
      debugPrint("Stacktrace: $stacktrace");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add To Cart API.

  Future<bool> addToCart({
    required BuildContext context,
    required String menuId,
    required String restaurantId,
    required int quantity,
    List<Addons>? addons,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final addToCartRequestModel = AddToCartRequestModel(menuId: menuId, restaurantId: restaurantId, quantity: quantity, addons: addons);

      final response = await _cartservice.addtoCart(addToCartRequestModel);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        final responseModel = AddToCartResponseModel.fromJson(jsonMap);

        if (context.mounted) {
          final bool isSuccess = responseModel.status ?? false;
          final String feedbackMessage = responseModel.message ?? (isSuccess ? "Item added to cart Successfully!" : "Failed to add item.");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(feedbackMessage)));

          return isSuccess;
        }
        return false;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Server error: ${response.statusCode}")));
        }
        return false;
      }
    } catch (e) {
      print("Error inside ViewModel addToCart: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occurred. Please try again.")));
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ToggleWishList API.

  Future<bool> toggleWishlist(BuildContext context, String menuId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _restaurantservice.toggleWishlist(menuId);
      print('$response');
      toggleWishListResponseModel = ToggleWishListResponseModel.fromJson(response!);

      if (toggleWishListResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(toggleWishListResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // My WishList API.

  Future<bool> myWishlist(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _restaurantservice.myWishlist();

      if (response != null) {
        myWishListResponseModel = MyWishListResponseModel.fromJson(response);
        print('Parsed Model Response: $response');

        if (myWishListResponseModel.status ?? false) {
          return true;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(myWishListResponseModel.message ?? "Something went wrong")));
          }
          return false;
        }
      }
      return false;
    } catch (e) {
      print("Exception in myWishlist Provider: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  Restaurant Saved API.

  Future<bool> fetchSavedRestaurants(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _restaurantservice.savedRestaurant();

      if (response != null) {
        savedRestaurantResponseModel = SavedRestaurantResponseModel.fromJson(response);
        print('Parsed Model Response: $response');

        if (savedRestaurantResponseModel.status ?? false) {
          return true;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(savedRestaurantResponseModel.message ?? "Something went wrong")));
          }
          return false;
        }
      }
      return false;
    } catch (e) {
      print("Exception in Provider: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load saved restaurants: $e")));
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
