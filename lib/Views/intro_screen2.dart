import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/Views/intro_screen3.dart';
import 'package:my_foodapp/Views/login.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  Positioned.fill(top: 0, left: 0, right: 0, child: Image.asset('assets/images/Group 1000004344.png', width: 220)),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('assets/images/top.png', fit: BoxFit.cover),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    Text(
                      'Quick delivery at your \n home address',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Fast and reliable delivery to your \n doorstep. Enjoy your favorite meals \n anytime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.regular, color: Color(0xFF555555)),
                    ),
                    Align(alignment: Alignment.centerLeft, child: Image.asset('assets/images/bottom.png')),

                    Spacer(),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text("Skip", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),

                        Spacer(),

                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => IntroScreen3()));
                          },
                          child: Image.asset('assets/images/next.png', height: 50),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
