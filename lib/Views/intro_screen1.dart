import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/Views/intro_screen2.dart';
import 'package:my_foodapp/Views/login.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned(top: 60, right: 0, child: Image.asset('assets/images/top.png')),

                  Positioned(top: 20, left: 0, right: 0, child: Center(child: Image.asset('assets/images/steps.png'))),

                  Positioned.fill(top: 80, left: 0, right: 0, child: Image.asset('assets/images/Middle image.png', height: 220)),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset('assets/images/bottom.png', fit: BoxFit.cover),
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
                      'Search for favorite \n food near you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Search for your favorite food near you \n and get it delivered fresh, fast, and \n hassle-free.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.regular, color: Color(0xFF555555)),
                    ),

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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => IntroScreen2()));
                          },
                          child: Image.asset('assets/images/next.png', height: 50),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
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
