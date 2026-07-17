import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/AddToCartRequestModel.dart';
import 'package:my_foodapp/Models/GetMenuItemsResponseModel.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/ViewCart/view_cart.dart';
import 'package:provider/provider.dart';

class CustomizeSheet extends StatefulWidget {
  final GetData itemData;
  const CustomizeSheet({super.key, required this.itemData});

  @override
  State<CustomizeSheet> createState() => _CustomizeSheetState();
}

class _CustomizeSheetState extends State<CustomizeSheet> {
  Map<int, int> selectedValues = {};
  int itemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        final menu = vm.getMenuItemsResponseModel.data!.getData!;
        final customizationsList = widget.itemData.customizations ?? [];
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/Dosa.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.itemData.name ?? "Dish Name", style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.bold)),
                                      Text("₹${widget.itemData.price ?? 0}"),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset('assets/images/Frame 2.png'),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Color.fromRGBO(84, 163, 18, 1)),
                                          Text(
                                            widget.itemData.rating?.toString() ?? "0.0",
                                            style: TextStyle(fontSize: 14, color: AppColors.darkCharcoal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            ListView.separated(
                              itemCount: customizationsList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) => SizedBox(height: 10),
                              itemBuilder: (context, outerIndex) {
                                final group = customizationsList[outerIndex];
                                final options = group.options ?? [];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(group.groupName ?? "Select Option", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),

                                    ListView.separated(
                                      itemCount: options.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder: (_, __) => SizedBox(height: 10),
                                      itemBuilder: (context, innerIndex) {
                                        final optionItem = options[innerIndex];
                                        int radioValue = innerIndex;

                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedValues[outerIndex] = radioValue;
                                            });
                                          },
                                          child: DottedBorder(
                                            color: const Color.fromRGBO(197, 197, 197, 1),
                                            strokeWidth: 1,
                                            dashPattern: const [4, 4],
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(10),
                                            child: Container(
                                              height: 44,
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

                                              child: Row(
                                                children: [
                                                  Radio<int>(
                                                    value: radioValue,
                                                    groupValue: selectedValues[outerIndex] ?? -1,
                                                    activeColor: Colors.green,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        selectedValues[outerIndex] = val!;
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text(optionItem.name ?? "Custom Option", maxLines: 1, overflow: TextOverflow.ellipsis),
                                                  ),
                                                  Text('+ ₹${optionItem.price ?? 0}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (itemQuantity > 1) {
                                  setState(() {
                                    itemQuantity--;
                                  });
                                }
                              },
                              child: _qtyButton('-'),
                            ),
                            const SizedBox(width: 10),

                            Text(itemQuantity.toString().padLeft(2, '0'), style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 10),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemQuantity++;
                                });
                              },
                              child: _qtyButton('+'),
                            ),

                            const SizedBox(width: 10),
                            const Spacer(),

                            ElevatedButton(
                              onPressed: vm.isLoading
                                  ? null
                                  : () async {
                                      List<Addons> selectedAddonsList = [];
                                      selectedValues.forEach((outerIdx, innerIdx) {
                                        final group = customizationsList[outerIdx];
                                        final option = group.options![innerIdx];

                                        selectedAddonsList.add(Addons(addonGroupId: group.sId, optionId: option.sId, quantity: 1));
                                      });

                                      bool success = await vm.addToCart(
                                        context: context,
                                        menuId: widget.itemData.sId ?? "",
                                        restaurantId: widget.itemData.restaurantId ?? "",
                                        quantity: itemQuantity,
                                        addons: selectedAddonsList,
                                      );

                                      if (success && context.mounted) {
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewCart()));
                                      }
                                    },

                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(207, 50),
                                backgroundColor: const Color.fromRGBO(84, 163, 18, 1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),

                              child: vm.isLoading
                                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : Text(
                                      'Add To Cart - ₹${((widget.itemData.price ?? 0) * itemQuantity)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

  Widget _qtyButton(String text) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(221, 221, 221, 1)),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 22))),
    );
  }
}
