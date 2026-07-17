import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/Shimmer/restaurant_shimmer.dart';
import 'package:my_foodapp/Views/bottom_Sheet/Customize_Sheet.dart';
import 'package:my_foodapp/Views/bottom_sheet/bottom_tabs.dart';
import 'package:my_foodapp/Views/bottom_sheet/food_detail_sheet.dart';
import 'package:provider/provider.dart';

class RestaurantDetail extends StatefulWidget {
  final String? restaurantId;
  final String? restname;
  final String? restadd;
  final String? restrat;
  const RestaurantDetail({super.key, this.restaurantId, this.restname, this.restadd, this.restrat});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  bool isLiked = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantDetailViewModel>(context, listen: false).getMenuItems(context, widget.restaurantId);

      context.read<RestaurantDetailViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        if (vm.isLoading) {
          return Scaffold(body: Shimmerrestaurant());
        }

        return Scaffold(
          body: SafeArea(
            bottom: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset('assets/images/restaurant.png', width: double.infinity, fit: BoxFit.cover),
                      Positioned(
                        top: 20,
                        left: 10,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white, size: 32),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: .5), spreadRadius: 2, blurRadius: 7, offset: Offset(0, 3))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.restname ?? "",
                                    style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                                  ),
                                ),
                                Image.asset('assets/images/Pure veg.png'),
                              ],
                            ),
                            Row(children: [Image.asset('assets/images/loc.png'), SizedBox(width: 5), Text(widget.restadd!)]),
                            SizedBox(height: 10),
                            Divider(height: 5),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Image.asset('assets/images/Star 1.png'),
                                SizedBox(width: 5),
                                Text(
                                  widget.restrat ?? "0.0",
                                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(24, 28, 46, 1)),
                                ),
                                SizedBox(width: 12),
                                Image.asset('assets/images/Delivery.png'),
                                SizedBox(width: 5),
                                Text(
                                  'Free',
                                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(24, 28, 46, 1)),
                                ),
                                SizedBox(width: 12),
                                Image.asset('assets/images/Clock.png'),
                                SizedBox(width: 5),
                                Text(
                                  "20 min",
                                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(24, 28, 46, 1)),
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Row(
                      children: [
                        Image.asset('assets/images/percent.png', color: Color.fromRGBO(94, 173, 29, 1)),
                        SizedBox(width: 5),
                        Text(
                          'Flat ₹80 OFF above ₹199',
                          style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                        ),
                        Spacer(),
                        Text('5 Offers'),
                        Image.asset('assets/images/angle-down.png'),
                      ],
                    ),
                  ),
                  Divider(height: 5),
                  SizedBox(height: 10),

                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            alignment: AlignmentGeometry.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Near & Fast', style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Recommended for you',
                      style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                    ),
                  ),

                  if (vm.getMenuItemsResponseModel.data?.getData != null)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: vm.getMenuItemsResponseModel.data!.getData!.length,
                      itemBuilder: (context, index) {
                        final menu = vm.getMenuItemsResponseModel.data!.getData![index];

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 160,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0x12000000)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (_) => FoodDetailSheet(itemData: menu),
                                          );
                                        },
                                        child: Image.network('${menu.image}', fit: BoxFit.cover),
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isLiked = !isLiked;
                                          });
                                          bool success = await context.read<RestaurantDetailViewModel>().toggleWishlist(context, menu.sId ?? "");
                                          if (!success) {
                                            setState(() {
                                              isLiked = !isLiked;
                                            });
                                          }
                                        },

                                        child: Image.asset(
                                          'assets/images/like (1).png',
                                          width: 40,
                                          color: isLiked ? Colors.red : null,
                                          colorBlendMode: isLiked ? BlendMode.srcIn : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/Frame 2.png'),
                                    Spacer(),
                                    Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1)),
                                    Text(menu.rating!.toString(), style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.regular)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      menu.name!,
                                      style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      menu.price!.toString(),
                                      style: TextStyle(
                                        fontSize: AppFontSize.medium,
                                        fontWeight: AppFontWeights.regular,
                                        color: AppColors.darkCharcoal,
                                      ),
                                    ),
                                    Spacer(),
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (_) => CustomizeSheet(itemData: menu),
                                          );
                                        },
                                        child: Text(
                                          "ADD",
                                          style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.primaryGreen),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: BottomTabs(),
        );
      },
    );
  }
}
