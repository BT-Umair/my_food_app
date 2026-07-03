import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/Views/ViewCart/view_cart.dart';
import 'package:my_foodapp/Views/home_screen.dart';

class BottomTabs extends StatelessWidget {
  const BottomTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
            borderRadius: BorderRadius.circular(30.0),
            color: AppColors.primaryBlack,
          ),

          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(width: 5),

              Container(
                width: 135,
                height: 42,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromRGBO(89, 168, 23, 1),
                ),

                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_filled, size: 20.0, color: Colors.white),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'Home',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                ),

                padding: EdgeInsets.all(10),
                child: Image.asset('assets/images/Search.png'),
              ),

              SizedBox(width: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                ),

                padding: EdgeInsets.all(10),
                child: Image.asset('assets/images/Notification.png'),
              ),

              SizedBox(width: 5),
            ],
          ),
        ),

        SizedBox(width: 10),

        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart()));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
              color: AppColors.primaryWhite,
            ),

            padding: EdgeInsets.all(15),
            child: Image.asset('assets/images/Bag.png'),
          ),
        ),
      ],
    );
  }
}
