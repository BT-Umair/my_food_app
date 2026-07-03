import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/Views/ViewCart/order_place.dart';
import 'package:my_foodapp/Views/bottom_Sheet/add_card_sheet.dart';
import 'package:my_foodapp/Views/bottom_Sheet/add_upi_sheet.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int? _selectedValue;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Payment Method',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 9),
            child: Text(
              "Apply",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SafeArea(
          bottom: true,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('UPI'),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Add UPI payment method',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => AddUpiSheet(),
                        );
                      },

                      child: Text(
                        'ADD',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'SAVED CARDS',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'ADD NEW CARDS',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => AddCardSheet(),
                        );
                      },

                      child: Text(
                        'ADD',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/MasterCard.png'),
                                Text("**** **** **** 0000", style: TextStyle(fontSize: 18, letterSpacing: 2.0, fontWeight: FontWeight.bold)),
                                Spacer(),
                                // Radio<int>(
                                //   value: 1,
                                //   groupValue: _selectedValue,
                                //   onChanged: (int? value) {
                                //     setState(() {
                                //       _selectedValue = value;
                                //     });
                                //   },
                                // ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  'WALLETS',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Mobikwik',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),
                    Spacer(),
                    Text(
                      'LINK ACCOUNT',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
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
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),
                    Spacer(),
                    Text(
                      'LINK ACCOUNT',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(height: 10),

                Row(
                  children: [
                    Text(
                      'Amazon payment options',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                    ),
                    Spacer(),
                    Text(
                      'LINK ACCOUNT',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                SizedBox(height: 20),
                Text(
                  'Cash On Delivery',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedValue = 1;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Pay after deliver your order',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                      ),
                      Spacer(),
                      Radio<int>(
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, thickness: 1, color: AppColors.lightgrey),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vm.getAllCartResponseModel.data?.totalAmount?.toString() ?? '0.0',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.primaryBlack),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'View Detailed Bill',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.primaryGreen),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_selectedValue == null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Please select a payment method first'), backgroundColor: Colors.orange));
                      return;
                    }

                    String paymentMethodString = (_selectedValue == 1) ? 'cod' : 'online';
                    print("paymentmethod $paymentMethodString");

                    bool isSuccess = await Provider.of<CartViewModel>(context, listen: false).placeOrder(
                      context: context,
                      paymentmethod: paymentMethodString,
                      deliveryAddress: 'Sector 62 Noida',
                      latitude: 28.627,
                      longitude: 77.3649,
                    );

                    if (isSuccess && context.mounted) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPlace()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(207, 50),
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Proceed To Pay',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryWhite),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
