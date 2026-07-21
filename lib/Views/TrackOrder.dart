import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/ViewModels/HomeViewModel.dart';
import 'package:my_foodapp/ViewModels/MyAccountViewModel.dart';
import 'package:my_foodapp/ViewModels/MyOrdersViewModel.dart';
import 'package:my_foodapp/Views/cancel_order.dart';
import 'package:my_foodapp/Views/chat_screen.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  final String orderId;
  const TrackOrder({super.key, required this.orderId});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyOrdersViewModel>().trackOrder(context, widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();
    final vm1 = context.watch<MyAccountViewModel>();
    final vm2 = context.watch<HomeViewModel>();
    final vm3 = context.watch<MyOrdersViewModel>();
    final orderData = vm3.trackOrderResponseModel.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        actions: [Icon(Icons.more_vert_outlined)],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 20, fontWeight: AppFontWeights.bold),
            children: [
              TextSpan(
                text: 'Track Order:',
                style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
              ),

              TextSpan(
                text: '#120340',
                style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/Avtar.png'),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        vm1.userNameController.text,
                        style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                      ),
                      Text('Delivery guy'),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SimpleChatScreen(currentUserId: "USER_123", receiverName: "Amit Kumar (Rider)", orderId: "ORD98765"),
                        ),
                      );
                    },
                    child: Image.asset('assets/images/Action Icon.png'),
                  ),
                  SizedBox(width: 5),
                  Image.asset('assets/images/Action Icon (1).png'),
                ],
              ),

              SizedBox(height: 10),
              Divider(height: 10),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.watch_later_outlined),
                  SizedBox(width: 5),
                  Text('Estimated Time'),
                  Spacer(),
                  Text(
                    '${orderData?.estimatedTime ?? ""} mins',

                    style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(20),
                width: 352,
                height: 214,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Image.asset('assets/images/greenlocation.png'), SizedBox(width: 10), Text('Order Prepared')],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [Image.asset('assets/images/greenlocation.png'), SizedBox(width: 10), Text('Your Order is on the way')]),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset('assets/images/greenlocation.png'),
                            SizedBox(width: 10),
                            Text(
                              orderData?.orderStatus ?? "",
                              style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.large, color: Color.fromRGBO(54, 58, 51, 1)),
                            ),
                          ],
                        ),
                        Center(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CancelOrder()));
                            },
                            style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))),
                            child: Text(
                              'Rate the Food!',
                              style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.bold, color: Color.fromRGBO(54, 58, 51, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/images/location2.png'),
                  SizedBox(width: 3),
                  Text('Deliver To', style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular)),
                  Spacer(),
                  Text(vm2.getAddressResponseModel.data!.addressLine!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Image.asset('assets/images/Credit Card.png'),
                  SizedBox(width: 3),
                  Text('Amount Paid'),
                  Spacer(),
                  Text(
                    vm.getAllCartResponseModel.data?.totalAmount?.toString() ?? '0.0',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('Food to be delivered'),
              SizedBox(height: 20),
              Row(
                children: [
                  Image.asset('assets/images/burger2.png'),
                  SizedBox(width: 10),
                  Image.asset('assets/images/Frame.png'),
                  SizedBox(width: 10),
                  Image.asset('assets/images/coke.png'),
                  SizedBox(width: 10),
                  Image.asset('assets/images/pizza1.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
