import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/bottom_Sheet/Customize_Sheet.dart';
import 'package:provider/provider.dart';

class FoodDetailSheet extends StatefulWidget {
  final dynamic itemData;
  const FoodDetailSheet({super.key, required this.itemData});

  @override
  State<FoodDetailSheet> createState() => _FoodDetailSheetState();
}

class _FoodDetailSheetState extends State<FoodDetailSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        final currentItem = widget.itemData;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentItem?.image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network('${currentItem.image}', fit: BoxFit.cover, width: double.infinity),
                        ),

                      SizedBox(height: 12),

                      Image.asset('assets/images/Frame 2.png'),

                      Row(
                        children: [
                          Expanded(
                            child: Text(currentItem?.name ?? "", style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.large)),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => CustomizeSheet(itemData: widget.itemData),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "ADD",
                                style: TextStyle(color: Colors.green, fontWeight: AppFontWeights.large),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.green, size: 22),
                          SizedBox(width: 2),
                          Text(currentItem?.rating?.toString() ?? "0.0"),
                          Spacer(),

                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => CustomizeSheet(itemData: widget.itemData),
                              );
                            },
                            child: Text("Customize", style: TextStyle(color: Colors.black, fontSize: 14)),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),

                      Text(currentItem?.price?.toString() ?? "0", style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.large)),

                      SizedBox(height: 8),

                      Text(
                        currentItem?.about ?? "",
                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
                    ),
                    child: Icon(Icons.close, size: 20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
