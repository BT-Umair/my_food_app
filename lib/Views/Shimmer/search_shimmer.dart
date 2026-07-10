import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/Views/restaurant_detail.dart';
import 'package:my_foodapp/Views/search_type.dart';
import 'package:shimmer/shimmer.dart';

Widget Shimmersearch() {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 5,
    separatorBuilder: (context, index) => SizedBox(height: 10),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 293,
                    height: 50,
                    child: TextField(
                      onSubmitted: (value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchType()));
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: '',
                        suffixIconColor: Color.fromRGBO(84, 163, 18, 1),
                        prefixIconColor: Color.fromRGBO(84, 163, 18, 1),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 30, width: 1, color: Colors.grey),
                            SizedBox(width: 10),
                            // Image.asset('assets/images/Voice.png', width: 20, height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.silverBorder, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 3),
                          Text('', style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.bold)),
                          SizedBox(height: 5),
                          // Image.asset('assets/images/Group 34064.png'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primaryWhite,
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Burger', style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  '',
                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                ),
                SizedBox(width: 20),
                Spacer(),
                Text(
                  '',
                  style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                ),
                SizedBox(width: 5),
                Image.asset('assets/images/Vector 1.png'),
              ],
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          width: 61,
                          height: 61,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.white),
                          child: Image.asset('assets/images/thali.png', width: 40, height: 40),
                        ),

                        SizedBox(
                          width: 40,
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(height: 5),

            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                ),
                Spacer(),
                Text(
                  '',
                  style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                ),
                SizedBox(width: 5),
                Image.asset('assets/images/Vector 1.png'),
              ],
            ),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),

                    child: Container(
                      width: 160,
                      height: 250,

                      padding: EdgeInsets.all(8),

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
                                child: Image.asset('assets/images/Burger.png', fit: BoxFit.cover),
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
                              Text('5.0 (12)', style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.regular)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Crispy Burger',
                                style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.bold, color: Color.fromRGBO(0, 0, 0, 1)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '₹99',
                                style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                              ),
                              Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),

                                child: Text(
                                  "ADD",
                                  style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.bold, color: Color.fromRGBO(84, 163, 18, 1)),
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
            ),
            Divider(height: 10),
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Near Restaurants',
                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                ),
                Spacer(),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                ),
                SizedBox(width: 5),

                Image.asset('assets/images/Vector 1.png'),
              ],
            ),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),

                    child: Container(
                      width: 160,
                      height: 250,

                      padding: EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0x12000000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetail()));
                              },

                              child: Image.asset('assets/images/NearRest2.png', fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.start, children: [Image.asset('assets/images/Frame 2.png')]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Punjabi Food Junction',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryBlack),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1)),
                                  Text(
                                    '5.0 (12)',
                                    style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
