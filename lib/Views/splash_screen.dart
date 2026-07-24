import 'package:flutter/material.dart';
import 'package:my_foodapp/ViewModels/SplashScreenViewModel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.5;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _scale = 1.2;
      });
    });
    Future.microtask(() => Provider.of<SplashScreenViewModel>(context, listen: false).checkLogin(context));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashScreenViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(94, 173, 29, 1),
          body: Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 10),
              opacity: 1,
              child: AnimatedScale(
                scale: _scale,
                duration: Duration(seconds: 10),
                curve: Curves.elasticOut,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/Pattern.png'),
                    Image.asset('assets/images/splash.png', filterQuality: FilterQuality.high, fit: BoxFit.contain),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
