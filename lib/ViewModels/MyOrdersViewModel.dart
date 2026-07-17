import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/GetMyOrderResponseModel.dart';
import 'package:my_foodapp/Models/TrackOrderResponseModel.dart';
import 'package:my_foodapp/Services/CartService.dart';

class MyOrdersViewModel extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  Cartservice _cartservice = Cartservice();
  GetMyOrderResponseModel getMyOrderResponseModel = GetMyOrderResponseModel();
  TrackOrderResponseModel trackOrderResponseModel = TrackOrderResponseModel();
  Future<void> loaddata() async {
    await Future.delayed(Duration(seconds: 1), () {});
  }

  // GetMyOrder API.

  Future<bool> getMyOrder(BuildContext context, {String? type, int? page, int? limit}) async {
    var isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.getMyOrder(type: type, page: page, limit: limit);

      getMyOrderResponseModel = GetMyOrderResponseModel.fromJson(response!);
      print('$response');

      if (getMyOrderResponseModel.status!) {
        print('$response');
        return true;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getMyOrderResponseModel.message!)));
        }
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
  // TrackOrder API.

  Future<bool> trackOrder(BuildContext context, String orderId) async {
    var isLoading = true;
    notifyListeners();

    try {
      final response = await _cartservice.trackOrder(orderId);

      trackOrderResponseModel = TrackOrderResponseModel.fromJson(response!);
      print('$response');

      if (trackOrderResponseModel.status!) {
        return true;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(trackOrderResponseModel.message!)));
        }
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

  // final List<OrderResponseModel> previousOrders = [
  //   OrderResponseModel(title: "Order Delivered", time: "26 March", summary: "Cheese Pizza", price: "₹799", button: "Reorder", label: "Delivered On"),

  //   OrderResponseModel(
  //     title: "Order Delivered",
  //     time: "27 March",
  //     summary: "Grilled Sandwich",
  //     price: "₹499",
  //     button: "Reorder",
  //     label: "Delivered On",
  //   ),

  //   OrderResponseModel(
  //     title: "Order Delivered",
  //     time: "28 March",
  //     summary: "Al Nihar Smash Chicken Burger",
  //     price: "₹485",
  //     button: "Reorder",
  //     label: "Delivered On",
  //   ),
  //   OrderResponseModel(
  //     title: 'Order Delivered',
  //     time: '29 March',
  //     summary: 'White Sauce Pasta',
  //     price: '₹450',
  //     button: 'Reorder',
  //     label: 'Delivered On',
  //   ),
  // ];

  // final List<OrderResponseModel> currentOrders = [
  //   OrderResponseModel(
  //     title: "Out for delivery",
  //     time: "30 mins",
  //     summary: "Pepperoni Cheese Pizza",
  //     price: "₹799",
  //     button: "Track Order",
  //     label: "Est. delivery",
  //   ),
  // ];

  // List<OrderResponseModel> get orders => _selectedTab == 0 ? currentOrders : previousOrders;

  void changeTab(int index, BuildContext context) {
    _selectedTab = index;
    notifyListeners();
  }
}
