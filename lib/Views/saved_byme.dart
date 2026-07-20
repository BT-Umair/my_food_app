import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:provider/provider.dart';

class SavedByme extends StatefulWidget {
  const SavedByme({super.key});

  @override
  State<SavedByme> createState() => _SavedBymeState();
}

class _SavedBymeState extends State<SavedByme> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        Provider.of<RestaurantDetailViewModel>(context, listen: false).fetchSavedRestaurants(context);
      }
    });
  }

  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        final save = vm.savedRestaurantResponseModel.data;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryWhite,
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
            title: Text(
              'Saved By Me',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(70, 137, 13, 1), width: 2.0),
                    color: Color.fromRGBO(77, 152, 14, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "U",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryWhite),
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: Padding(
            padding: EdgeInsetsGeometry.all(15),
            child: SafeArea(
              // bottom: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: save?.getData?.length ?? 0,

                      itemBuilder: (context, index) {
                        final item = vm.savedRestaurantResponseModel.data?.getData?[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),

                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentGeometry.bottomCenter,

                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Image.asset('assets/images/Banner.png', fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,

                                      child: Container(
                                        width: 150,
                                        height: 40,

                                        decoration: BoxDecoration(color: Color.fromRGBO(94, 173, 29, 0.8), borderRadius: BorderRadius.circular(30)),
                                      ),
                                    ),

                                    Positioned(top: 15, left: 15, child: Image.asset('assets/images/leaf.png', width: 40, height: 30)),
                                    Positioned(
                                      top: 20,
                                      left: 50,
                                      child: Text(
                                        "Pure Veg Food",
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryWhite),
                                      ),
                                    ),
                                    // Container(
                                    //   width: 200,
                                    //   height: 23,
                                    //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Color.fromRGBO(94, 173, 29, 0.4)),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 5),
                                          Image.asset('assets/images/percent.png', color: Color.fromRGBO(94, 173, 29, 1)),
                                          SizedBox(width: 8),
                                          Text(
                                            "Flat ₹80 OFF above ₹199",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Positioned(top: 0, right: 0, child: Image.asset('assets/images/save.png', width: 50)),
                                  ],
                                ),

                                SizedBox(height: 10),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item?.name ?? "No Name",
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                                        ),
                                      ),

                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.white),

                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                              ),
                                              // Icon(Icons.star, color: Colors.black, size: 20.0),
                                              // Text(
                                              //   '4.0',
                                              //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 255, 255, 1)),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                                          children: [
                                            TextSpan(text: ' Burger -'),
                                            TextSpan(text: ' Chicken -'),
                                            TextSpan(text: ' Riche -'),
                                            TextSpan(text: ' Wings '),
                                          ],
                                        ),
                                      ),
                                      // Image.asset('assets/images/delievery.png'),
                                      // RichText(
                                      //   text: TextSpan(
                                      //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF555555)),
                                      //     children: [TextSpan(text: ' Free')],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Image.asset('assets/images/Rectangle 4268.png'),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/Star 1.png'),
                                      SizedBox(width: 5),
                                      Text(
                                        '4.7',
                                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.primaryBlack),
                                      ),
                                      SizedBox(width: 10),
                                      Image.asset('assets/images/Delivery.png'),
                                      SizedBox(width: 8),
                                      Text(
                                        'Free',
                                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.primaryBlack),
                                      ),
                                      SizedBox(width: 10),
                                      Image.asset('assets/images/Clock.png'),
                                      SizedBox(width: 8),
                                      Text(
                                        '20 min',
                                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.primaryBlack),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
