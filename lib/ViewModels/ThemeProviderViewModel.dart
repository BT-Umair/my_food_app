import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default theme light rahega
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Jab switch toggle hoga, yeh function call hoga
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Yeh line poori app ko refresh kar degi
  }
}
