import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CouponViewModel.dart';
import 'package:my_foodapp/ViewModels/HomeViewModel.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/ViewCart/payment_method.dart';
import 'package:my_foodapp/Views/ViewCart/view_coupon.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCart extends StatefulWidget {
  const ViewCart({super.key});

  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final String id = prefs.getString('ADDRESS_ID') ?? "";
      Provider.of<CartViewModel>(context, listen: false).getAllCart(context);
      Provider.of<HomeViewModel>(context, listen: false).getAddressApi(context, id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();
    final vm1 = context.watch<RestaurantDetailViewModel>();
    final vm3 = context.watch<CouponViewModel>();
    final vm4 = context.watch<HomeViewModel>();
    return Scaffold(
      body: SafeArea(
        // bottom: true,
        child: Column(
          children: [
            SizedBox(height: 10),

            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/images/Back (2).png'),
                ),
                SizedBox(width: 20),
                Text(
                  vm.getAllCartResponseModel.data?.restaurant?.name ?? "",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primaryBlack),
                ),
              ],
            ),

            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 38)),
                Icon(Icons.location_on, color: AppColors.darkCharcoal),
                Text(
                  vm4.getAddressResponseModel.data!.addressLine!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
                ),
                Image.asset('assets/images/angle-down.png'),
              ],
            ),

            Divider(color: AppColors.silverBorder, thickness: 4, height: 40),
            if (vm.getAllCartResponseModel.data?.items != null)
              ListView.separated(
                shrinkWrap: true,
                itemCount: vm.getAllCartResponseModel.data!.items!.length,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                itemBuilder: (_, index) {
                  final cart = vm.getAllCartResponseModel.data!.items![index];
                  return Row(
                    children: [
                      Image.asset('assets/images/Dosa.png'),
                      SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cart.name!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                int currentQuantity = cart.quantity ?? 1;

                                if (currentQuantity > 1) {
                                  int newQuantity = currentQuantity - 1;
                                  await vm.updateCart(context, cart.sId, newQuantity);
                                  await vm.getAllCart(context);

                                  setState(() {});
                                } else {
                                  // await vm.removeCart(context, cart.sId);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                            ),

                            SizedBox(width: 10),
                            Text(cart.quantity.toString()),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                vm.incrementQty();

                                await vm1.addToCart(context: context, menuId: cart.menuId ?? "", restaurantId: cart.restaurantId ?? "", quantity: 1);
                                await vm.getAllCart(context);

                                setState(() {});
                              },
                              child: const Text('+', style: TextStyle(fontSize: 20)),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10),
                      Text(
                        "₹${cart.price?.toString()}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryBlack),
                      ),
                    ],
                  );
                },

                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),

            Divider(color: AppColors.silverBorder, thickness: 4, height: 50),

            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Saving Corner',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
                  ),

                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewCoupon()));

                      if (result != null && mounted) {
                        await vm.getAllCart(context);
                      }

                      await vm3.getAllActiveCoupon(context);
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/Group 34075.png'),
                        SizedBox(width: 8),
                        Text(
                          'Apply Coupon',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color.fromRGBO(85, 85, 85, 1)),
                        ),
                        SizedBox(height: 40),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ViewCoupon()));
                          },
                          child: Image.asset('assets/images/angle-down (1).png'),
                        ),
                      ],
                    ),
                  ),

                  if (vm.getAllCartResponseModel.data?.coupon != null)
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 40, right: 40),
                      child: Row(
                        children: [
                          Image.asset('assets/images/Offer.png'),
                          SizedBox(width: 8),
                          Text("${vm.getAllCartResponseModel.data?.coupon?.code} Applied!"),

                          IconButton(
                            onPressed: () async {
                              final couponCode = vm.getAllCartResponseModel.data?.coupon?.code ?? "";
                              await vm.removeCouponFromCart(context, couponCode);
                            },
                            icon: Icon(Icons.close, size: 18),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            Divider(color: AppColors.silverBorder, thickness: 4, height: 50),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _row('Item Total', (vm.getAllCartResponseModel.data?.itemTotal ?? 0).toString()),
                  SizedBox(height: 5),
                  _row('Delivery Fee', (vm.getAllCartResponseModel.data?.deliveryFee ?? 0).toString()),
                  SizedBox(height: 5),
                  _row('Extra Discount', (vm.getAllCartResponseModel.data?.discount ?? 0).toString()),
                  SizedBox(height: 5),
                  _row('GST & Other Charges', (vm.getAllCartResponseModel.data?.gstAndCharges?.toString() ?? "0.0")),

                  SizedBox(height: 10),

                  DottedLine(dashColor: AppColors.silverBorder),

                  SizedBox(height: 10),

                  _row('To Pay', (vm.getAllCartResponseModel.data?.totalAmount ?? 0.0).toString(), isBold: true),
                ],
              ),
            ),
          ],
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
                        "₹${vm.getAllCartResponseModel.data?.totalAmount?.toString() ?? ""}",

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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethod()));
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

  Widget _row(String title, String value, {bool isBold = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
        ),
        Spacer(),
        Text(
          '₹$value',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primaryBlack),
        ),
      ],
    );
  }
}
