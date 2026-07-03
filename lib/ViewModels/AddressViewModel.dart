import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/GetAddressResponseModel.dart';
import 'package:my_foodapp/Models/GetAllAddressListResponseModel.dart';
import 'package:my_foodapp/Services/AddressService.dart';
import 'package:my_foodapp/Views/home_screen.dart';

class Addressviewmodel extends ChangeNotifier {
  Addressservice _addressservice = Addressservice();

  GetAllAddressListResponseModel getAddressListResponseModel = GetAllAddressListResponseModel();
  GetAddressResponseModel getAddressResponseModel = GetAddressResponseModel();

  Future<bool> callAddressApi(BuildContext context) async {
    var isLoading = true;
    notifyListeners();

    try {
      final response = await _addressservice.getAllAddress();

      getAddressListResponseModel = GetAllAddressListResponseModel.fromJson(response!);

      if (getAddressListResponseModel.status!) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAddressListResponseModel.message!)));
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // SetDefault Address API.

  Future<bool> setDefaultApi(BuildContext context, String? id) async {
    var isLoading = true;
    notifyListeners();

    try {
      final response = await _addressservice.setDefault(id!);
      print('$response');
      getAddressResponseModel = GetAddressResponseModel.fromJson(response!);

      if (getAddressResponseModel.status!) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAddressListResponseModel.message!)));
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
