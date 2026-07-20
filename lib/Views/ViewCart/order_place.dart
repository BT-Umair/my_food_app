import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/Views/HomePage.dart';
import 'package:provider/provider.dart';

class OrderPlace extends StatefulWidget {
  const OrderPlace({super.key});

  @override
  State<OrderPlace> createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SafeArea(
          bottom: true,
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Image.asset('assets/images/Check filled.png'),
                Text(
                  'Yay! Your order\nhas been placed.',
                  style: TextStyle(fontSize: 32, fontWeight: AppFontWeights.bold, color: Color.fromRGBO(54, 58, 51, 1)),
                ),
                Text(
                  'Your order would be delivered in the\n30 mins atmost',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(96, 101, 92, 1)),
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, color: Color.fromRGBO(96, 99, 94, 1)),
                    SizedBox(width: 5),
                    Text(
                      'Estimated time',
                      style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(96, 101, 92, 1)),
                    ),
                    Spacer(),
                    Text(
                      '30mins',
                      style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Color.fromRGBO(96, 99, 94, 1)),
                    SizedBox(width: 5),
                    Text('Deliver to'),
                    Spacer(),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset('assets/images/Credit Card.png'),
                    SizedBox(width: 5),
                    Text('Amount Paid'),
                    Spacer(),
                    Text(
                      vm.getAllCartResponseModel.data?.totalAmount?.toString() ?? '0.0',
                      style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                    ),
                  ],
                ),
                Spacer(),
                Center(
                  child: SizedBox(
                    width: 290,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),

                      child: Text(
                        "Track Order",
                        style: TextStyle(fontWeight: AppFontWeights.bold, fontSize: AppFontSize.medium, color: AppColors.primaryWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
