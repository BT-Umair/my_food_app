import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/SearchScreenViewModel.dart';
import 'package:my_foodapp/Views/Shimmer/search_shimmer.dart';
import 'package:my_foodapp/Views/restaurant_detail.dart';
import 'package:my_foodapp/Views/search_type.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        Provider.of<Searchscreenviewmodel>(context, listen: false).getAllCategory(context);
        Provider.of<Searchscreenviewmodel>(context, listen: false).getAllSubCategory(context);
        Provider.of<Searchscreenviewmodel>(context, listen: false).getAllMenuItems(context);
        Provider.of<Searchscreenviewmodel>(context, listen: false).restaurantList(context);
      }
    });

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
        final category = vm.getAllCategoryResponseModel.data;
        return Scaffold(
          backgroundColor: AppColors.primaryWhite,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
            title: Text(
              'Search',
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

          body: _isLoading
              ? Shimmersearch()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(20),
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
                                  hintText: 'Search for ‘Pizza’',
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
                                    Text('VEG', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
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
                                        border: Border.all(color: Color.fromRGBO(38, 16, 16, 1), width: 1.0),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),

                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
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
                      Row(
                        children: [
                          Text(
                            'What’s on your mind',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                          ),
                          SizedBox(width: 20),
                          Spacer(),
                          Text(
                            'See All',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.darkCharcoal),
                          ),
                          SizedBox(width: 5),
                          Image.asset('assets/images/Vector 1.png'),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (vm.getAllCategoryResponseModel.data?.categories != null && vm.getAllCategoryResponseModel.data!.categories!.isNotEmpty)
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: category!.count!,
                            itemBuilder: (context, index) {
                              final Category = category.categories![index];
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 61,
                                      height: 61,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.white),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          '${Const.CATEGORYIMAGE_URL}${Category.categoryImage}',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      child: Text(
                                        Category.name!,
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                        maxLines: 1,
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
                            'Popular Fast Food',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchType()));
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.darkCharcoal),
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset('assets/images/Vector 1.png'),
                        ],
                      ),
                      if (vm.getAllMenuItemsResponseModel.data?.items != null)
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vm.getAllMenuItemsResponseModel.data!.items!.length,
                            itemBuilder: (context, index) {
                              final menu = vm.getAllMenuItemsResponseModel.data!.items![index];

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
                                            child: Image.network('${Const.MENUIMAGE_URL}${menu.image}', fit: BoxFit.cover),
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
                                          Text(menu.rating!.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            menu.name!,
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${menu.price}',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
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
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromRGBO(84, 163, 18, 1)),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                          ),
                          Spacer(),
                          Text(
                            'See All',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.darkCharcoal),
                          ),
                          SizedBox(width: 5),

                          Image.asset('assets/images/Vector 1.png'),
                        ],
                      ),
                      if (vm.restaurantListResponseModel.data?.restaurants != null && vm.restaurantListResponseModel.data!.restaurants!.isNotEmpty)
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vm.restaurantListResponseModel.data!.restaurants!.length,
                            itemBuilder: (context, index) {
                              final restaurant = vm.restaurantListResponseModel.data!.restaurants![index];
                              final imageFilename = (restaurant.image != null && restaurant.image!.isNotEmpty) ? restaurant.image![0] : '';
                              return Padding(
                                padding: EdgeInsets.all(10),

                                child: Container(
                                  width: 200,
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RestaurantDetail(
                                                  restaurantId: restaurant.sId,
                                                  restadd: restaurant.address,
                                                  restname: restaurant.name,
                                                  restrat: restaurant.rating.toString(),
                                                ),
                                              ),
                                            );
                                          },

                                          child: Image.network('${Const.IMAGE_URL}$imageFilename'),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [Image.asset('assets/images/Frame 2.png')]),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurant.name!,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryBlack),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1)),
                                              Text(
                                                restaurant.rating!.toString(),
                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.darkCharcoal),
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
                ),
        );
      },
    );
  }
}
