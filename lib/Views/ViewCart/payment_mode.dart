import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';

class PaymentMode extends StatefulWidget {
  const PaymentMode({super.key});

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        title: Text("Payment Mode", style: TextStyle(fontWeight: AppFontWeights.medium)),
        centerTitle: true,

        leading: IconButton(
          icon: Image.asset('assets/images/Back (2).png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "UPI",
              style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Add UPI payment method", style: TextStyle(fontWeight: AppFontWeights.medium)),
                Spacer(),
                Text(
                  "ADD",
                  style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: AppColors.primaryGreen),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("SAVED CARDS"),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Add New Cards", style: TextStyle(fontWeight: AppFontWeights.medium)),
                Spacer(),
                Text(
                  "ADD",
                  style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: AppColors.primaryGreen),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'WALLETS',
              style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Mobikwik',
                  style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                ),
                Spacer(),
                Text(
                  'LINK ACCOUNT',
                  style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.bold, color: AppColors.primaryGreen),
                ),
                SizedBox(height: 20),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10),
            Row(
              children: [
                Text(
                  'PhonePe',
                  style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                ),
                Spacer(),
                Text(
                  'LINK ACCOUNT',
                  style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.bold, color: AppColors.primaryGreen),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10),

            Row(
              children: [
                Text(
                  'Amazon payment options',
                  style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                ),
                Spacer(),
                Text(
                  'LINK ACCOUNT',
                  style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.bold, color: AppColors.primaryGreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
