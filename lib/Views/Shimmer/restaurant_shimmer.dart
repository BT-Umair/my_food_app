import 'package:flutter/material.dart';
import 'package:my_foodapp/Views/bottom_Sheet/food_detail_sheet.dart';
import 'package:shimmer/shimmer.dart';

Widget Shimmerrestaurant() {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 5,
    separatorBuilder: (context, index) => SizedBox(height: 10),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
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

                  SizedBox(
                    child: Container(
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
                              Text(
                                'Punjabi Food Junction',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
                              ),
                              Spacer(),
                              Image.asset('assets/images/Pure veg.png'),
                            ],
                          ),

                          Row(children: [Image.asset('assets/images/loc.png'), Text('G-84, Sector-63 Noida')]),
                          SizedBox(height: 10),
                          Divider(height: 5),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Image.asset('assets/images/Star 1.png'),
                              SizedBox(width: 5),
                              Text(
                                '4.7',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(24, 28, 46, 1)),
                              ),
                              SizedBox(width: 12),
                              Image.asset('assets/images/Delivery.png'),
                              SizedBox(width: 5),
                              Text(
                                'Free',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(24, 28, 46, 1)),
                              ),
                              SizedBox(width: 12),
                              Image.asset('assets/images/Clock.png'),
                              SizedBox(width: 5),
                              Text(
                                '20 min',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(24, 28, 46, 1)),
                              ),
                              SizedBox(width: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsetsGeometry.all(15),
                child: Row(
                  children: [
                    // Image.asset('assets/images/percent.png', color: Color.fromRGBO(94, 173, 29, 1)),
                    SizedBox(width: 5),
                    Text(
                      '',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Spacer(),
                    Text(''),
                    // Image.asset('assets/images/angle-down.png'),
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
                  '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 230,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
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
                                borderRadius: BorderRadiusGeometry.circular(15),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) => FoodDetailSheet(itemData: null),
                                    );
                                  },
                                  child: Image.asset('assets/images/SouthIndian.png', fit: BoxFit.cover),
                                ),
                              ),

                              Align(alignment: Alignment.centerRight, child: Image.asset('assets/images/like (1).png', width: 40)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/Frame 2.png'),
                              Spacer(),
                              Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1)),
                              Text('5.0 (12)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'South Indian Thali',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '₹99',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(85, 85, 85, 1)),
                              ),
                              Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),

                                child: Text(
                                  "ADD",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(84, 163, 18, 1)),
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
      );
    },
  );
}
