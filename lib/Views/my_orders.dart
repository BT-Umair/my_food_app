import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/MyOrdersViewModel.dart';
import 'package:my_foodapp/Views/Shimmer/myorders_shimmer.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});
  @override
  State<MyOrders> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MyOrdersViewModel>(context);
    final ordersList = vm.getMyOrderResponseModel?.data?.orders;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),

        title: Text('My Orders', style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.bold)),

        centerTitle: true,
      ),

      body: FutureBuilder<void>(
        future: vm.loaddata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return myordersshimmer();
          }

          return Padding(
            padding: EdgeInsets.all(20),

            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: InkWell(
                          onTap: () async {
                            context.read<MyOrdersViewModel>().getMyOrder(context, type: 'current', page: 1, limit: 20);
                            vm.changeTab(0, context);
                          },

                          child: Container(
                            padding: EdgeInsets.all(15),

                            color: vm.selectedTab == 0 ? Colors.green : Colors.white,

                            child: Text(
                              'Current',
                              textAlign: TextAlign.center,

                              style: TextStyle(fontWeight: AppFontWeights.large, color: vm.selectedTab == 0 ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: InkWell(
                          onTap: () {
                            context.read<MyOrdersViewModel>().getMyOrder(context, type: 'previous', page: 1, limit: 20);
                            vm.changeTab(1, context);
                          },

                          child: Container(
                            padding: EdgeInsets.all(15),

                            color: vm.selectedTab == 1 ? Colors.green : Colors.white,

                            child: Text(
                              'Previous',
                              textAlign: TextAlign.center,

                              style: TextStyle(fontWeight: AppFontWeights.large, color: vm.selectedTab == 1 ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Expanded(
                  child: ListView.separated(
                    itemCount: ordersList?.length ?? 0,

                    separatorBuilder: (_, __) => SizedBox(height: 15),

                    itemBuilder: (context, index) {
                      final order = ordersList![index];

                      return Container(
                        padding: EdgeInsets.all(10),

                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: AssetImage('assets/images/Paneer.png'), fit: BoxFit.cover),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(order.restaurant?.name ?? "Food Item", style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.bold)),
                                      SizedBox(height: 10),

                                      Row(
                                        children: [
                                          Text(
                                            vm.selectedTab == 0 ? "Est. delivery: " : "Ordered On: ",
                                            style: TextStyle(fontWeight: AppFontWeights.medium),
                                          ),
                                          SizedBox(width: 10),
                                          // Convert the int? safely to a String without casting using .toString()
                                          Text(vm.selectedTab == 0 ? "${order.estimatedTime ?? 30} mins" : (order.createdAt?.split('T').first ?? "")),
                                        ],
                                      ),

                                      SizedBox(height: 5),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Status', style: TextStyle(fontWeight: AppFontWeights.medium)),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              order.orderStatus ?? 'Processing',
                                              style: TextStyle(color: order.orderStatus == 'CANCELLED' ? Colors.red : Colors.green),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 5),

                                      Row(
                                        children: [
                                          Text('Total Price Paid', style: TextStyle(fontWeight: AppFontWeights.medium)),
                                          SizedBox(width: 10),
                                          Text('₹${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}'),
                                        ],
                                      ),

                                      SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(orderId: order.sId)));
                                    },

                                    style: OutlinedButton.styleFrom(
                                      fixedSize: Size.fromHeight(45),
                                      side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),

                                    child: Text(
                                      vm.selectedTab == 0 ? "Track Order" : "Reorder",
                                      style: TextStyle(color: Colors.black, fontWeight: AppFontWeights.bold, fontSize: 17),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                // OutlinedButton(
                                //   onPressed: () {},

                                //   style: OutlinedButton.styleFrom(
                                //     fixedSize: Size.fromHeight(45),
                                //     side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                //   ),
                                PopupMenuButton<String>(
                                  // Styles the wrapper layout to match your original OutlinedButton look
                                  style: IconButton.styleFrom(
                                    fixedSize: const Size(45, 45), // Made it a square to fit the icon nicely
                                    side: const BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),

                                  child: Icon(Icons.more_vert, color: AppColors.primaryBlack),

                                  onSelected: (String value) {
                                    switch (value) {
                                      case 'order':
                                        break;
                                      case 'share':
                                        break;
                                      case 'delete':
                                        break;
                                    }
                                  },

                                  // Builds the three menu options inside the popup list
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem<String>(
                                      value: 'share',
                                      child: Row(children: [Icon(Icons.ios_share_outlined, size: 20), SizedBox(width: 10), Text('Share restaurant')]),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'order',
                                      child: Row(children: [Icon(Icons.description_rounded, size: 20), SizedBox(width: 10), Text('Order details')]),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Row(children: [Icon(Icons.delete, size: 20), SizedBox(width: 10), Text('Delete this order')]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
