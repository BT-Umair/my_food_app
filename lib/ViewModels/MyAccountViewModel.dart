import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_foodapp/Models/GetProfileResponseModel.dart';
import 'package:my_foodapp/Models/UpdateProfileRequestModel.dart';
import 'package:my_foodapp/Services/AuthService.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountViewModel extends ChangeNotifier {
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  AuthService _authService = AuthService();

  String? selectedGender;

  final List<String> genderOptions = ["Male", "Female"];

  String? errorUserName;
  String? errorPhone;
  String? errorEmail;
  String? errorGender;

  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? image;

  Future<void> showOptions(BuildContext context, MyAccountViewModel vm) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.pop(context);
              vm.getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.pop(context);
              vm.getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  bool validate() {
    if (userNameController.text.isEmpty) {
      errorUserName = "Please enter user name.";
    } else {
      errorUserName = null;
    }

    if (phoneController.text.isEmpty) {
      errorPhone = "Please enter your mobile number.";
    } else if (phoneController.text.length < 10) {
      errorPhone = "Please enter 10 digit mobile number.";
    } else {
      errorPhone = null;
    }

    if (emailController.text.isEmpty) {
      errorEmail = "Please enter email.";
    } else if (!emailController.text.contains("@")) {
      errorEmail = "Please Enter Valid Email";
    } else {
      errorEmail = null;
    }

    if (selectedGender == null) {
      errorGender = "Please select gender.";
    } else {
      errorGender = null;
    }

    notifyListeners();

    return errorEmail == null && errorGender == null && errorPhone == null && errorUserName == null;
  }

  void setGender(String? value) {
    selectedGender = value;
    errorGender = null;
    notifyListeners();
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    image = File(pickedFile.path);
    notifyListeners();
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    image = File(pickedFile.path);
    notifyListeners();
  }

  Future<void> showImageOptions(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.pop(context);
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.pop(context);
              getImageFromCamera();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
      ),
    );
  }

  // Update Profile API.

  Future<void> saveProfile(BuildContext context) async {
    if (!validate()) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      UpdateProfileRequestModel updateProfileRequestModel = UpdateProfileRequestModel();
      updateProfileRequestModel.email = emailController.text;
      updateProfileRequestModel.phoneNumber = phoneController.text;
      updateProfileRequestModel.name = userNameController.text;
      updateProfileRequestModel.gender = selectedGender;
      updateProfileRequestModel.countryCode = "+91";

      var response = await _authService.updateProfile(updateProfileRequestModel);

      if (response.statusCode == 200) {
        // When we get the response from the api, we need to convert the json string into the object with the help of jsonDecode function.
        var jsonString = jsonDecode(response.body);

        GetProfileResponseModel getProfileResponseModel = GetProfileResponseModel.fromJson(jsonString);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getProfileResponseModel.message!)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile not updated. Please try again.")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Get Profile API.

  Future<void> getProfile(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await _authService.getProfile();

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);

        GetProfileResponseModel getProfileResponseModel = GetProfileResponseModel.fromJson(jsonString);
        print(getProfileResponseModel.data?.phoneNumber);
        print(getProfileResponseModel.data?.email);
        print(getProfileResponseModel.data?.name);
        if (getProfileResponseModel.status == true) {
          userNameController.text = getProfileResponseModel.data?.name ?? "";
          emailController.text = getProfileResponseModel.data?.email ?? "";
          phoneController.text = getProfileResponseModel.data?.phoneNumber ?? "";

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(Const.NAME, getProfileResponseModel.data!.name!);
          prefs.setString(Const.EMAIL, getProfileResponseModel.data!.email!);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile not retrived")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
