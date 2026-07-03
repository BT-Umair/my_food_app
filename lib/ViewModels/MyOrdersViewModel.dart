import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/OrderResponseModel.dart';

class MyOrdersViewModel extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  Future<void> loaddata() async {
    await Future.delayed(Duration(seconds: 1), () {});
  }

  final List<OrderResponseModel> previousOrders = [
    OrderResponseModel(title: "Order Delivered", time: "26 March", summary: "Cheese Pizza", price: "₹799", button: "Reorder", label: "Delivered On"),

    OrderResponseModel(
      title: "Order Delivered",
      time: "27 March",
      summary: "Grilled Sandwich",
      price: "₹499",
      button: "Reorder",
      label: "Delivered On",
    ),

    OrderResponseModel(
      title: "Order Delivered",
      time: "28 March",
      summary: "Al Nihar Smash Chicken Burger",
      price: "₹485",
      button: "Reorder",
      label: "Delivered On",
    ),
    OrderResponseModel(
      title: 'Order Delivered',
      time: '29 March',
      summary: 'White Sauce Pasta',
      price: '₹450',
      button: 'Reorder',
      label: 'Delivered On',
    ),
  ];

  final List<OrderResponseModel> currentOrders = [
    OrderResponseModel(
      title: "Out for delivery",
      time: "30 mins",
      summary: "Pepperoni Cheese Pizza",
      price: "₹799",
      button: "Track Order",
      label: "Est. delivery",
    ),
  ];

  List<OrderResponseModel> get orders => _selectedTab == 0 ? currentOrders : previousOrders;

  void changeTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}
