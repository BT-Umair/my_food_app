import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  File? image;
  ThemeMode themeMode = ThemeMode.light;

  String? emailAddress = "";
  String? name = "";
  String? firstLetter = "";

  final ImagePicker picker = ImagePicker();

  Future<void> showOptions(BuildContext context, ProfileViewModel vm) async {
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

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void changeTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Const.NAME);
    emailAddress = prefs.getString(Const.EMAIL);
    print(name);
    print(emailAddress);
    if (name!.length > 0) {
      firstLetter = name![0];
    }
  }
}
