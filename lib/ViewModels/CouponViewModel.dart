import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/ApplyCouponCodeResponseModel.dart';
import 'package:my_foodapp/Models/GetAllActiveCouponResponseModel.dart';
import 'package:my_foodapp/Services/CartService.dart';

class CouponViewModel extends ChangeNotifier {
  final Cartservice _cartservice = Cartservice();

  GetAllActiveCouponResponseModel? getAllActiveCouponResponseModel;
  ApplyCouponCodeResponseModel applyCouponCodeResponseModel = ApplyCouponCodeResponseModel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _selectedIndex;
  String _searchQuery = "";

  int? get selectedIndex => _selectedIndex;
  String get searchQuery => _searchQuery;

  void selectCoupon(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  // Get AllActiveCoupon API.

  Future<bool> getAllActiveCoupon(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.getAllActiveCoupon();

      if (response != null) {
        getAllActiveCouponResponseModel = GetAllActiveCouponResponseModel.fromJson(response);

        if (getAllActiveCouponResponseModel?.status ?? false) {
          return true;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllActiveCouponResponseModel?.message ?? "Something went wrong")));
          }
          return false;
        }
      }
      return false;
    } catch (e) {
      print("Get Coupons Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ApplyCoupon Code API.

  Future<bool> applyCouponCode(BuildContext context, String code) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.applyCoupon(code);

      if (response != null) {
        applyCouponCodeResponseModel = ApplyCouponCodeResponseModel.fromJson(response);

        if (applyCouponCodeResponseModel.status == true) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coupon Applied Successfully")));
          }
          return true;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(applyCouponCodeResponseModel.message ?? "Failed to apply coupon")));
          }
          return false;
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Server side validation error")));
        }
        return false;
      }
    } catch (e) {
      print("Apply Coupon Exception: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
