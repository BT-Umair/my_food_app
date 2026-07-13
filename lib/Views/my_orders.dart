import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/MyOrdersViewModel.dart';
import 'package:my_foodapp/Views/Shimmer/myorders_shimmer.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MyOrdersViewModel>(context);

    return Scaffold(
      appBar: AppBar(
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
                      child: InkWell(
                        onTap: () {
                          vm.changeTab(0);
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

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          vm.changeTab(1);
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
                  ],
                ),

                SizedBox(height: 20),

                Expanded(
                  child: ListView.separated(
                    itemCount: vm.orders.length,

                    separatorBuilder: (_, __) => SizedBox(height: 15),

                    itemBuilder: (context, index) {
                      final order = vm.orders[index];

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
                                      Text(order.title, style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.bold)),

                                      SizedBox(height: 10),

                                      Row(
                                        children: [
                                          Text(order.label, style: TextStyle(fontWeight: AppFontWeights.medium)),
                                          SizedBox(width: 10),
                                          Text(order.time),
                                        ],
                                      ),

                                      SizedBox(height: 5),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Order Summary', style: TextStyle(fontWeight: AppFontWeights.medium)),
                                          SizedBox(width: 10),
                                          Expanded(child: Text(order.summary)),
                                        ],
                                      ),

                                      SizedBox(height: 5),

                                      Row(
                                        children: [
                                          Text('Total Price Paid', style: TextStyle(fontWeight: AppFontWeights.medium)),
                                          SizedBox(width: 10),
                                          Text(order.price),
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
                                    onPressed: () {},

                                    style: OutlinedButton.styleFrom(
                                      fixedSize: Size.fromHeight(45),
                                      side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),

                                    child: Text(
                                      order.button,
                                      style: TextStyle(color: Colors.black, fontWeight: AppFontWeights.bold, fontSize: 17),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                OutlinedButton(
                                  onPressed: () {},

                                  style: OutlinedButton.styleFrom(
                                    fixedSize: Size.fromHeight(45),
                                    side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),

                                  child: Icon(Icons.more_vert),
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
