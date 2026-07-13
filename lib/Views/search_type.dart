import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/SearchScreenViewModel.dart';
import 'package:my_foodapp/Views/Shimmer/searchtype_shimmer.dart';
import 'package:provider/provider.dart';

class SearchType extends StatefulWidget {
  const SearchType({super.key});

  @override
  State<SearchType> createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
  bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Searchscreenviewmodel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
            title: Text(
              'Search',
              style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.0),

                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Color.fromRGBO(77, 152, 14, 1), shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "U",
                      style: TextStyle(fontSize: AppFontSize.medium, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: _isLoading
              ? Shimmersearchtype()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 293,
                              height: 50,
                              child: TextField(
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) async {
                                  if (value.trim().isNotEmpty) {
                                    bool success = await vm.getAllMenuItems(context, search: value.trim());

                                    if (success && context.mounted) {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchType()));
                                    }
                                  } else {
                                    await vm.getAllMenuItems(context);
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search_rounded),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Pizza',
                                  suffixIconColor: Color.fromRGBO(84, 163, 18, 1),
                                  prefixIconColor: Color.fromRGBO(84, 163, 18, 1),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(height: 30, width: 1, color: Colors.grey),
                                      SizedBox(width: 10),
                                      Image.asset('assets/images/Voice.png', width: 20, height: 20),
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
                                    Text('VEG', style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.large)),
                                    SizedBox(height: 5),
                                    Image.asset('assets/images/Group 34064.png'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (vm.getAllsubCategoryResponseModel.data?.subcategory != null &&
                          vm.getAllsubCategoryResponseModel.data!.subcategory!.isNotEmpty)
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vm.getAllsubCategoryResponseModel.data!.subcategory!.length,
                            itemBuilder: (context, index) {
                              final subCategory = vm.getAllsubCategoryResponseModel.data!.subcategory![index];
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),

                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),

                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(subCategory.name!, style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 20),
                      if (vm.getAllMenuItemsResponseModel.data?.items != null)
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: vm.getAllMenuItemsResponseModel.data!.items!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final menu = vm.getAllMenuItemsResponseModel.data!.items![index];
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),

                              child: Row(
                                children: [
                                  Image.asset('assets/images/Rectangle 4313.png'),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(menu.name!, style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.bold)),
                                      SizedBox(width: 5),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Color.fromRGBO(84, 163, 18, 1)),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                                              children: [
                                                TextSpan(text: menu.rating!.toString()),
                                                TextSpan(text: ' 20 - 25 Min | '),
                                                TextSpan(text: menu.mealtype),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
