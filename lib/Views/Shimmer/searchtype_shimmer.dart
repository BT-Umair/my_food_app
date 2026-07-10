import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:shimmer/shimmer.dart';

Widget Shimmersearchtype() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(8)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 120, height: 15, color: AppColors.primaryWhite),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(color: AppColors.primaryWhite, shape: BoxShape.circle),
                        ),
                        SizedBox(width: 5),
                        Container(width: 180, height: 12, color: AppColors.primaryWhite),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}