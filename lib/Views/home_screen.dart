import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/ViewModels/HomeViewModel.dart';
import 'package:my_foodapp/ViewModels/MyAccountViewModel.dart';
import 'package:my_foodapp/ViewModels/ProfileViewModel.dart';
import 'package:my_foodapp/Views/address.dart';
import 'package:my_foodapp/Views/bottom_sheet/bottom_tabs.dart';
import 'package:my_foodapp/Views/profile.dart';
import 'package:my_foodapp/Views/restaurant_detail.dart';
import 'package:my_foodapp/Views/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentImageIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final String id = prefs.getString('ADDRESS_ID') ?? "";

      if (mounted) {
        Provider.of<HomeViewModel>(context, listen: false).getAddressApi(context, id);
        Provider.of<HomeViewModel>(context, listen: false).getAllCategory(context);
        Provider.of<HomeViewModel>(context, listen: false).restaurantList(context);
        context.read<MyAccountViewModel>().getProfile(context);
        context.read<HomeViewModel>().getUserData();
        context.read<ProfileViewModel>().getUserData();
        context.read<CartViewModel>().getAllCart(context);
      }
    });

    Future.microtask(() => Provider.of<HomeViewModel>(context, listen: false).loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        final address = vm.getAddressResponseModel.data;
        final category = vm.getAllCategoryResponseModel.data;
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
                            },
                            child: Row(
                              children: [
                                Image.asset('assets/images/Location.png', width: 20),
                                Text(
                                  address?.addressType ?? "",
                                  style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.large, color: AppColors.primaryBlack),
                                ),
                                Image.asset('assets/images/angle-down.png'),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(70, 137, 13, 1), width: 2.0),
                              color: Color.fromRGBO(77, 152, 14, 1),
                              shape: BoxShape.circle,
                            ),

                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    vm.firstLetter!,
                                    style: TextStyle(fontSize: AppFontSize.medium, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        address?.addressLine ?? "",
                        style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.large, color: AppColors.darkCharcoal),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 293,
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset('assets/images/Search1.png'),
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

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Image.asset('assets/images/Banner.png', fit: BoxFit.cover),
                              ),

                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'What’s on your mind',
                                    style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                                  ),
                                  SizedBox(width: 20),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                                    },
                                    child: Text(
                                      'See All',
                                      style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Image.asset('assets/images/Vector 1.png'),
                                ],
                              ),
                              SizedBox(height: 20),
                              if (vm.getAllCategoryResponseModel.data?.categories != null &&
                                  vm.getAllCategoryResponseModel.data!.categories!.isNotEmpty)
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category!.count!,
                                    itemBuilder: (context, index) {
                                      final Category = category.categories![index];

                                      return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: AppColors.primaryWhite),

                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.network('${Category.categoryImage}', width: 60, height: 60, fit: BoxFit.cover),
                                                ),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  Category.name!,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: AppFontWeights.medium,
                                                    color: Color.fromRGBO(32, 24, 24, 1),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              Divider(height: 5),

                              SizedBox(height: 20),

                              SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),

                                              borderRadius: BorderRadius.circular(5.0),
                                              color: Colors.white,
                                            ),

                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                'Near & fast ',
                                                style: TextStyle(fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Text(
                                'Top 2190 restaurant to explore',
                                style: TextStyle(fontSize: AppFontSize.medium, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                              ),

                              SizedBox(height: 20),
                              if (vm.restaurantListResponseModel.data?.restaurants != null &&
                                  vm.restaurantListResponseModel.data!.restaurants!.isNotEmpty)
                                ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: vm.restaurantListResponseModel.data!.restaurants!.length,

                                  itemBuilder: (context, index) {
                                    final restaurant = vm.restaurantListResponseModel.data!.restaurants![index];
                                    final hasMultipleImages = restaurant.image != null && restaurant.image!.length > 1;
                                    return InkWell(
                                      onTap: () {
                                        // Check karein ki image list khali toh nahi hai
                                        String? firstImage = (restaurant.image != null && restaurant.image!.isNotEmpty) ? restaurant.image![0] : null;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RestaurantDetail(
                                              restaurantId: restaurant.sId,
                                              restname: restaurant.name,
                                              restadd: restaurant.address,
                                              restrat: restaurant.rating.toString(),
                                              restImage: firstImage,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color.fromRGBO(197, 197, 197, 1), width: 1.0),

                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: AlignmentGeometry.bottomCenter,

                                              children: [
                                                restaurant.image != null && restaurant.image!.isNotEmpty
                                                    ? Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(20.0),
                                                            child: CarouselSlider.builder(
                                                              itemCount: restaurant.image!.length,
                                                              options: CarouselOptions(
                                                                height: 180.0,
                                                                autoPlay: false,
                                                                enableInfiniteScroll: false,
                                                                viewportFraction: 1.0,
                                                                enlargeCenterPage: false,

                                                                scrollPhysics: hasMultipleImages
                                                                    ? const ClampingScrollPhysics()
                                                                    : const NeverScrollableScrollPhysics(),
                                                                onPageChanged: (index, reason) {
                                                                  setState(() {
                                                                    _currentImageIndex = index;
                                                                  });
                                                                },
                                                              ),
                                                              itemBuilder: (context, itemIndex, pageViewIndex) {
                                                                final imageFilename = restaurant.image![itemIndex];
                                                                return SizedBox(
                                                                  width: double.infinity,
                                                                  child: Image.network('$imageFilename', fit: BoxFit.cover),
                                                                );
                                                              },
                                                            ),
                                                          ),

                                                          if (hasMultipleImages)
                                                            Positioned(
                                                              bottom: 16.0,
                                                              left: 16.0,
                                                              right: 0,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: restaurant.image!.asMap().entries.map((entry) {
                                                                  final bool isActive = _currentImageIndex == entry.key;
                                                                  return Container(
                                                                    width: 8.0,
                                                                    height: 8.0,
                                                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: isActive ? Colors.black : Colors.white.withOpacity(0.5),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                    : SizedBox(
                                                        width: double.infinity,
                                                        child: Image.asset('assets/images/Banner.png', fit: BoxFit.cover),
                                                      ),
                                                Positioned(
                                                  top: 10,
                                                  left: 10,

                                                  child: Container(
                                                    width: 150,
                                                    height: 40,

                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(94, 173, 29, 0.8),

                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                  ),
                                                ),

                                                Positioned(top: 15, left: 15, child: Image.asset('assets/images/leaf.png', width: 40, height: 30)),
                                                Positioned(
                                                  top: 20,
                                                  left: 50,
                                                  child: Text(
                                                    "Pure Veg Food",
                                                    style: TextStyle(fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 5),
                                                      Image.asset('assets/images/percent.png', color: Color.fromRGBO(94, 173, 29, 1)),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        "Flat ₹80 OFF above ₹199",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: AppFontWeights.bold,
                                                          color: AppColors.primaryWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await context.read<HomeViewModel>().toggleSaveRestaurant(context, restaurant.sId ?? "");
                                                    },
                                                    child: Image.asset(
                                                      context.watch<HomeViewModel>().savedRestaurantIds.contains(restaurant.sId)
                                                          ? 'assets/images/Vector 48.png'
                                                          : 'assets/images/save.png',
                                                      width: 50,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 10),

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      restaurant.name!,
                                                      style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.white),

                                                    child: Padding(
                                                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                              child: Row(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: AppFontWeights.regular,
                                                        color: AppColors.darkCharcoal,
                                                      ),
                                                      children: [
                                                        TextSpan(text: ' Burger -'),
                                                        TextSpan(text: ' Chicken -'),
                                                        TextSpan(text: ' Riche -'),
                                                        TextSpan(text: ' Wings '),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Image.asset('assets/images/Rectangle 4268.png'),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/Star 1.png'),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    restaurant.rating!.toString(),
                                                    style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.primaryBlack),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Image.asset('assets/images/Delivery.png'),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Free',
                                                    style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.primaryBlack),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Image.asset('assets/images/Clock.png'),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "20 min",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: AppFontWeights.regular,
                                                      color: Color.fromRGBO(24, 28, 46, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => SizedBox(height: 16),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: BottomTabs(),
        );
      },
    );
  }
}
