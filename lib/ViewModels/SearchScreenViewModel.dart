import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/GetAllCategoryResponseModel.dart';
import 'package:my_foodapp/Models/GetAllMenuItemsResponseModel.dart';
import 'package:my_foodapp/Models/GetAllSubCategoryResponseModel.dart';
import 'package:my_foodapp/Models/RestaurantListResponseModel.dart';
import 'package:my_foodapp/Services/CategoryService.dart';
import 'package:my_foodapp/Services/RestaurantService.dart';

class Searchscreenviewmodel extends ChangeNotifier {
  bool isLoading = true;
  final Categoryservice _categoryservice = Categoryservice();
  final Restaurantservice _restaurantservice = Restaurantservice();

  GetAllCategoryResponseModel getAllCategoryResponseModel = GetAllCategoryResponseModel();
  GetAllSubCategoryResponseModel getAllsubCategoryResponseModel = GetAllSubCategoryResponseModel();
  GetAllMenuItemsResponseModel getAllMenuItemsResponseModel = GetAllMenuItemsResponseModel();
  RestaurantListResponseModel restaurantListResponseModel = RestaurantListResponseModel();

  // SearchScreen GetAll Category API.

  Future<bool> getAllCategory(BuildContext context) async {
    notifyListeners();

    try {
      final response = await _categoryservice.getAllCategory();

      getAllCategoryResponseModel = GetAllCategoryResponseModel.fromJson(response!);
      print('search $response');

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

  //  GetAll SubCategory API.

  Future<bool> getAllSubCategory(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _categoryservice.getAllSubCategory();

      getAllsubCategoryResponseModel = GetAllSubCategoryResponseModel.fromJson(response!);
      print('search $response');

      if (getAllsubCategoryResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllsubCategoryResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  Get AllMenu Items API.

  Future<bool> getAllMenuItems(BuildContext context, {String? search}) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _restaurantservice.getAllMenuItems(search: search);

      getAllMenuItemsResponseModel = GetAllMenuItemsResponseModel.fromJson(response!);
      print('$response');

      if (getAllMenuItemsResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllMenuItemsResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // NearBy Restaurant.

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
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
