import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/ProfileViewModel.dart';
import 'package:my_foodapp/ViewModels/ThemeProviderViewModel.dart';
import 'package:my_foodapp/Views/ViewCart/payment_mode.dart';
import 'package:my_foodapp/Views/address.dart';
import 'package:my_foodapp/Views/favourites.dart';
import 'package:my_foodapp/Views/my_account.dart';
import 'package:my_foodapp/Views/my_orders.dart';
import 'package:my_foodapp/Views/saved_byme.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
                  vm.firstLetter!,
                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SafeArea(
          bottom: true,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 379,
                height: 107,
                decoration: BoxDecoration(color: Color.fromRGBO(94, 173, 29, 0.1), borderRadius: BorderRadius.circular(20)),

                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vm.name!,
                          style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                        ),
                        Text(vm.emailAddress!),
                      ],
                    ),

                    Spacer(),
                    GestureDetector(
                      onTap: vm.getImageFromGallery,
                      child: Container(
                        width: 67,
                        height: 67,
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(94, 173, 29, 1),
                          backgroundImage: null,
                          child: Image.asset('assets/images/Camera.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                'General',
                style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(112, 117, 107, 1)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(color: Color.fromRGBO(250, 250, 250, 1), borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccount()));
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Image.asset('assets/images/Profile.png'),
                          SizedBox(width: 10),
                          Text(
                            'My Account',
                            style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/Orders.png'),
                          SizedBox(width: 10),
                          Text(
                            'My Orders',
                            style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMode()));
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/Credit Card.png'),
                          SizedBox(width: 10),
                          Text(
                            'Payment Mode',
                            style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/location2.png'),
                            SizedBox(width: 10),
                            Text(
                              "Addresses",
                              style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites()));
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/Heart.png'),
                          SizedBox(width: 10),
                          Text(
                            'Favorites',
                            style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Image.asset('assets/images/Subscription.png'),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SavedByme()));
                          },
                          child: Text(
                            'Saved By Me',
                            style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                          ),
                        ),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Image.asset('assets/images/Settings.png'),
                        SizedBox(width: 10),
                        Text(
                          'My Preferences',
                          style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_sharp, size: 20, color: AppColors.greenish),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),
              Text(
                'Theme',
                style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(112, 117, 107, 1)),
              ),
              Container(
                decoration: BoxDecoration(color: Color.fromRGBO(250, 250, 250, 1), borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/Vector.png'),
                        SizedBox(width: 10),
                        Text(
                          'Dark mode',
                          style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                        ),
                        Spacer(),
                        Switch(
                          // Current state check karne ke liye watch use karein
                          value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
                          onChanged: (bool value) {
                            // Value change karne ke liye read use karein
                            context.read<ThemeProvider>().toggleTheme(value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
