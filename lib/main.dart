import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_foodapp/Repository/login_repository.dart';
import 'package:my_foodapp/ViewModels/AddAddressViewModel.dart';
import 'package:my_foodapp/ViewModels/AddressViewModel.dart';
import 'package:my_foodapp/ViewModels/CancelOrderViewModel.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/ViewModels/CouponViewModel.dart';
import 'package:my_foodapp/ViewModels/HomeViewModel.dart';
import 'package:my_foodapp/ViewModels/LoginViewModel.dart';
import 'package:my_foodapp/ViewModels/MyAccountViewModel.dart';
import 'package:my_foodapp/ViewModels/MyOrdersViewModel.dart';
import 'package:my_foodapp/ViewModels/OtpViewModel.dart';
import 'package:my_foodapp/ViewModels/ProfileViewModel.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/ViewModels/SearchScreenViewModel.dart';
import 'package:my_foodapp/ViewModels/SplashScreenViewModel.dart';
import 'package:my_foodapp/ViewModels/ThemeProviderViewModel.dart';
import 'package:my_foodapp/Views/splash_screen.dart';
import 'package:my_foodapp/firebase_options.dart';
import 'package:my_foodapp/notification_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Kyunki Firebase ko shuru hone mein thoda samay lagta hai (await use hota hai),
  // Flutter ko pehle batana padta hai ki backend tools taiyar karne se pehle Flutter ke
  // saare internal widgets engine ko load kar do.
  await Firebase.initializeApp(
    // Yeh main line hai jo aapke Flutter app ka hath Firebase backend se jodti hai.
    options: DefaultFirebaseOptions.currentPlatform,
    // Yeh is code ka sabse bada dimaag hai. Agar aap app ko Android par chalayenge, toh yeh Android ki settings load karega. Agar iOS par chalayenge, toh iOS ki settings load karega. Aapko alag-alag code likhne ki zaroorat nahi padti.
  );
  // Notification settings active karein
  NotificationHandler handler = NotificationHandler();
  await handler.initializeSettings();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => CouponViewModel()),
        ChangeNotifierProvider(create: (_) => AddAddressViewModel()),
        ChangeNotifierProvider(create: (_) => Addressviewmodel()),
        ChangeNotifierProvider(create: (_) => MyOrdersViewModel()),
        ChangeNotifierProvider(create: (_) => CancelOrderViewModel()),
        ChangeNotifierProvider(create: (_) => MyAccountViewModel()),
        ChangeNotifierProvider(create: (_) => RestaurantDetailViewModel()),
        ChangeNotifierProvider(create: (_) => Searchscreenviewmodel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        Provider(create: (_) => LoginRepository()),
        ChangeNotifierProvider(create: (context) => LoginViewModel(context.read<LoginRepository>())),
        ChangeNotifierProvider(create: (context) => OtpViewModel(context.read<LoginRepository>())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ThemeProvider ko listen (watch) karein
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF121212)),
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: AppColors.primaryWhite),
      home: SplashScreen(),
    );
  }
}
