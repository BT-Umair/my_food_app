import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/bottom_Sheet/Customize_Sheet.dart';
import 'package:provider/provider.dart';

class FoodDetailSheet extends StatefulWidget {
  const FoodDetailSheet({super.key});

  @override
  State<FoodDetailSheet> createState() => _FoodDetailSheetState();
}

class _FoodDetailSheetState extends State<FoodDetailSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        final menuList = vm.getMenuItemsResponseModel?.data?.getData;
        final firstItem = menuList?.first;
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
                      ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network('${Const.MENUIMAGE_URL}${firstItem?.image!}')),

                      SizedBox(height: 12),

                      Image.asset('assets/images/Frame 2.png'),

                      Row(
                        children: [
                          Expanded(
                            child: Text(firstItem!.name!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => CustomizeSheet(),
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
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.green, size: 22),
                          SizedBox(width: 2),
                          Text(firstItem.rating?.toString() ?? ""),
                          Spacer(),

                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => CustomizeSheet(),
                              );
                            },
                            child: Text("Customize", style: TextStyle(color: Colors.black, fontSize: 14)),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),

                      Text(firstItem.price!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

                      SizedBox(height: 8),

                      Text(
                        firstItem.about!,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(85, 85, 85, 1)),
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
