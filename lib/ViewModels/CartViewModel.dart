import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/ApplyCouponCodeResponseModel.dart';
import 'package:my_foodapp/Models/GetAllCartResponseModel.dart' hide Coupon;
import 'package:my_foodapp/Models/PlaceOrderRequestModel.dart';
import 'package:my_foodapp/Models/PlaceOrderResponseModel.dart' hide DeliveryAddress;
import 'package:my_foodapp/Services/CartService.dart';
import 'package:my_foodapp/Utils/themes.dart';

class CartViewModel extends ChangeNotifier {
  bool isLoading = false;
  final Cartservice _cartservice = Cartservice();

  GetAllCartResponseModel getAllCartResponseModel = GetAllCartResponseModel();
  PlaceOrderResponseModel placeOrderResponseModel = PlaceOrderResponseModel();

  Coupon? _selectedCoupon;

  Coupon? get selectedCoupon => _selectedCoupon;

  // int itemTotal = 820;
  // int deliveryFee = 20;
  // int discount = 80;
  // int gst = 30;

  // int get totalPayable => itemTotal + deliveryFee + gst - discount;

  void applyCoupon(Coupon coupon) {
    _selectedCoupon = coupon;
    notifyListeners();
  }

  void removeCoupon() {
    _selectedCoupon = null;
    notifyListeners();
  }

  int quantity = 1;

  void incrementQty() {
    quantity++;
    notifyListeners();
  }

  void decrementQty() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  //  Get AllCart API.

  Future<bool> getAllCart(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.getAllCart();

      getAllCartResponseModel = GetAllCartResponseModel.fromJson(response!);
      print('$response');

      if (getAllCartResponseModel.status!) {
        print('$response');
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllCartResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Remove Cart API.

  Future<bool> removeCart(BuildContext context, String? id) async {
    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Cart ID")));
      return false;
    }
    isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.removeCart(id);
      print('$response');
      getAllCartResponseModel = GetAllCartResponseModel.fromJson(response!);

      if (getAllCartResponseModel.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Removed Cart Successfully")));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllCartResponseModel.message!)));
        return false;
      }
    } catch (e) {
      print("Error inside ViewModel removeCart: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  Update CartItem API.

  Future<bool> updateCart(BuildContext context, String? id, int? quantity) async {
    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Cart ID")));
      return false;
    }
    var isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.updateCart(id, quantity!);
      print('$response');
      getAllCartResponseModel = GetAllCartResponseModel.fromJson(response!);

      if (getAllCartResponseModel.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(" Cart Updated Successfully")));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllCartResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  RemoveCoupon FromCart API.

  Future<bool> removeCouponFromCart(BuildContext context, String code) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.removeCoupon(code);
      print('Remove Coupon Response: $response');
      getAllCartResponseModel = GetAllCartResponseModel.fromJson(response!);

      if (getAllCartResponseModel.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coupon Removed Successfully")));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAllCartResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  PLACEORDER API.

  Future<bool> submitOrder({
    required BuildContext context,
    required String paymentmethod,
    required String deliveryAddress,
    required String addressId,
    double? latitude,
    double? longitude,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      DeliveryAddress addressObject = DeliveryAddress(address: deliveryAddress, lat: latitude, lng: longitude);
      PlaceOrderRequestModel placeOrderRequestModel = PlaceOrderRequestModel(
        paymentMethod: paymentmethod,
        deliveryAddress: addressObject,
        addressId: addressId,
      );

      final responseModel = await _cartservice.placeOrder(placeOrderRequestModel);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseModel.message ?? "Order placed successfully!"),
            backgroundColor: responseModel.status == true ? AppColors.primaryGreen : Colors.red,
          ),
        );
      }

      return responseModel.status ?? false;
    } catch (e) {
      print("Error inside ViewModel placeOrder: $e");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red));
      }

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
