import 'dart:ui';

class AppColors {
  static final Color primaryGreen = Color.fromRGBO(84, 163, 18, 1.0);
  static final Color primaryWhite = Color.fromRGBO(255, 255, 255, 1.0);
  static final Color primaryBlack = Color.fromRGBO(0, 0, 0, 1);
  static final Color darkCharcoal = Color.fromRGBO(85, 85, 85, 1.0);
  static final Color lightgrey = Color.fromRGBO(240, 240, 240, 255);
  static final Color silverBorder = Color.fromRGBO(221, 221, 221, 1.0);
}

class AppFontWeights {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
}

class AppFontSize {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

class AppImages {
  static const String _basePath = "assets/images/";
  static const String avatars = "${_basePath}app_Avatars.png";
  static const String home = "${_basePath}app_Home.png";
}
