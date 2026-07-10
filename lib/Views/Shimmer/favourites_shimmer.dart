import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:shimmer/shimmer.dart';

Widget favouriteShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 5, mainAxisExtent: 230),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: 169,
                  height: 220,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryWhite),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.topRight,
                        children: [
                          ClipRRect(borderRadius: BorderRadiusGeometry.circular(10), child: Image.asset('assets/images/SouthIndian.png')),
                          Image.asset('assets/images/like.png'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset('assets/images/Frame 2.png'),
                          Spacer(),
                          Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1)),
                          Text('5.0 (12)'),
                        ],
                      ),
                      Text(
                        'South Indian Thali',
                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.primaryBlack),
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
                            style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8))),
                            child: Text(
                              'ADD',
                              style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(84, 163, 18, 1)),
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
      ],
    ),
  );
}
