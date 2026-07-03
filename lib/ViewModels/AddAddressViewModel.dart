import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/AddAddressRequestModel.dart';
import 'package:my_foodapp/Models/AddAddressResponseModel.dart';
import 'package:my_foodapp/Models/GetAddressResponseModel.dart';
import 'package:my_foodapp/Services/AddressService.dart';
import 'package:my_foodapp/Utils/CommonUtils.dart';
import 'package:my_foodapp/ViewModels/AddressViewModel.dart';
import 'package:provider/provider.dart';

class AddAddressViewModel extends ChangeNotifier {
  Addressservice _addressservice = Addressservice();
  GetAddressResponseModel getAddressResponseModel = GetAddressResponseModel();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  String? nameError;
  String? phoneError;
  String? addressError;
  String? landmarkError;
  String? cityError;
  String? stateError;
  String? pinCodeError;

  bool isLoading = false;

  bool validate() {
    if (nameController.text.isEmpty) {
      nameError = "Please Enter Delivery Name";
    } else {
      nameError = null;
    }

    if (phoneController.text.isEmpty) {
      phoneError = "Please Enter Your Mobile Number";
    } else if (phoneController.text.length < 10) {
      phoneError = "Please Enter 10 Digit Number.";
    } else {
      phoneError = null;
    }

    if (addressController.text.isEmpty) {
      addressError = "Please Enter Address";
    } else {
      addressError = null;
    }

    if (landmarkController.text.isEmpty) {
      landmarkError = "Please Enter Landmark";
    } else {
      landmarkError = null;
    }

    if (cityController.text.isEmpty) {
      cityError = "Please Enter City";
    } else {
      cityError = null;
    }

    if (stateController.text.isEmpty) {
      stateError = "Please Enter State";
    } else {
      stateError = null;
    }

    if (pinCodeController.text.isEmpty) {
      pinCodeError = "Please Enter 6 Digit PinCode";
    } else {
      pinCodeError = null;
    }

    notifyListeners();

    return nameError == null &&
        phoneError == null &&
        addressError == null &&
        landmarkError == null &&
        cityError == null &&
        stateError == null &&
        pinCodeError == null;
  }

  void save(BuildContext context) async {
    bool isConnected = await CommonUtils.isInternetAvailable(context);

    if (!isConnected) {
      return;
    }

    if (validate()) {
      callAddAddressApi(context);
    }
  }

  // ADD ADDRESS API.

  Future<void> callAddAddressApi(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      AddAddressRequestModel addAddressRequestModel = AddAddressRequestModel(
        fullName: nameController.text,
        phone: phoneController.text,
        addressLine: addressController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: pinCodeController.text,
        landmark: landmarkController.text,
        addressType: "Home",
      );

      final response = await _addressservice.addAddress(addAddressRequestModel);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        AddAddressResponseModel responseModel = AddAddressResponseModel.fromJson(json);

        if (responseModel.status!) {
          clearControllers();
          Provider.of<Addressviewmodel>(context, listen: false).callAddressApi(context);

          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address Saved")));
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //UPDATE ADDRESS API.

  void edit(BuildContext context, String? id) {
    if (validate()) {
      updateAddress(context, id);
    }
  }

  Future<void> updateAddress(BuildContext context, String? id) async {
    try {
      isLoading = true;
      notifyListeners();

      EditAddressRequestModel editAddressRequestModel = EditAddressRequestModel(
        id: id,
        fullName: nameController.text,
        phone: phoneController.text,
        addressLine: addressController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: pinCodeController.text,
        landmark: landmarkController.text,
        addressType: "Home",
      );

      var response = await _addressservice.updateAddress(editAddressRequestModel);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);

        GetAddressResponseModel getAddressResponseModel = GetAddressResponseModel.fromJson(jsonString);

        if (getAddressResponseModel.status == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAddressResponseModel.message!)));
          Provider.of<Addressviewmodel>(context, listen: false).callAddressApi(context);
          Navigator.pop(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Address Not update")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //GET ADDRESS API..

  Future<bool> getAddressApi(BuildContext context, String? id) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _addressservice.getAddress(id!);
      print('$response');
      getAddressResponseModel = GetAddressResponseModel.fromJson(response!);

      if (getAddressResponseModel.status == true) {
        nameController.text = getAddressResponseModel.data?.fullName ?? "";
        phoneController.text = getAddressResponseModel.data?.phone ?? "";
        addressController.text = getAddressResponseModel.data?.addressLine ?? "";
        landmarkController.text = getAddressResponseModel.data?.landmark ?? "";
        cityController.text = getAddressResponseModel.data?.city ?? "";
        stateController.text = getAddressResponseModel.data?.state ?? "";
        pinCodeController.text = getAddressResponseModel.data?.pincode ?? "";
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

  //  DELETE ADDRESS API..

  Future<bool> deleteAddressapi(BuildContext context, String? id) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _addressservice.deleteAddress(id!);
      print('$response');
      getAddressResponseModel = GetAddressResponseModel.fromJson(response!);

      if (getAddressResponseModel.status == true) {
        Provider.of<Addressviewmodel>(context, listen: false).callAddressApi(context);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Address deleted successfully")));
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

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    landmarkController.clear();
    cityController.clear();
    stateController.clear();
    pinCodeController.clear();
    nameError = null;
    phoneError = null;
    addressError = null;
    landmarkError = null;
    cityError = null;
    stateError = null;
    pinCodeError = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();

    super.dispose();
  }
}
