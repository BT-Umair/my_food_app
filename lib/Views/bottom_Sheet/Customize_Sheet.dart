import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/ViewCart/view_cart.dart';
import 'package:provider/provider.dart';

class CustomizeSheet extends StatefulWidget {
  const CustomizeSheet({super.key});

  @override
  State<CustomizeSheet> createState() => _CustomizeSheetState();
}

class _CustomizeSheetState extends State<CustomizeSheet> {
  int selectedValue = 1;
  int itemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        final menu = vm.getMenuItemsResponseModel.data!.getData!;
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
                                      Text(menu.first.name!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text(menu.first.price!.toString()),
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
                                          Text(menu.first.rating!.toString(), style: TextStyle(fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            ListView.separated(
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) => SizedBox(height: 10),
                              itemBuilder: (context, outerIndex) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Choose Your Filling", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),

                                    ListView.separated(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder: (_, __) => SizedBox(height: 10),
                                      itemBuilder: (context, innerIndex) {
                                        int value = outerIndex * 10 + innerIndex;

                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedValue = value;
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
                                                    value: value,
                                                    groupValue: selectedValue,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        selectedValue = val!;
                                                      });
                                                    },
                                                  ),
                                                  Expanded(child: Text('Classic Masala (Potato)', maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                  Text('+ ₹20'),
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
                                      await vm.addToCart(
                                        context: context,
                                        menuId: menu.first.sId ?? "",
                                        restaurantId: menu.first.restaurantId ?? "",
                                        quantity: itemQuantity,
                                      );

                                      if (context.mounted) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart()));
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
                                      'Add To Cart - ₹${((menu.first.price ?? 0) * itemQuantity)}',
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
