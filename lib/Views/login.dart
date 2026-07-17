import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/LoginViewModel.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          body: SafeArea(
            bottom: true,

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(child: Image.asset('assets/images/Group 48095665.png', fit: BoxFit.cover)),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 270,
                          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
                        ),
                      ),

                      Positioned(bottom: 0, left: 0, right: 0, child: Image.asset('assets/images/Loginbg.png', height: 250)),
                    ],
                  ),

                  SizedBox(height: 30),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromRGBO(18, 13, 38, 1)),
                        ),
                        Text(
                          'Login and enjoy quick delivery.',
                          style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 10,
                          controller: phoneController,
                          onChanged: vm.setPhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Image.asset('assets/images/Calling.png', width: 20, height: 20, fit: BoxFit.fill),
                            ),

                            border: OutlineInputBorder(),
                            hintText: 'Enter your phone number',
                            labelText: 'Phone Number',
                            errorText: vm.phoneError,
                          ),
                        ),
                        Text('Forgot Password?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            width: 290,
                            height: 55,

                            child: ElevatedButton(
                              onPressed: () async {
                                if (await vm.login(context)) {}
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                foregroundColor: AppColors.primaryGreen,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                              ),

                              child: vm.isLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      "Sign In",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryWhite),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Center(child: Image.asset('assets/images/or.png')),
                        SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                            width: 275,
                            height: 56,

                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await vm.signInwithGoogle(context);
                              },
                              icon: Image.asset('assets/images/Google.png', width: 24, height: 24),
                              label: Text(
                                "Login With Google",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromRGBO(18, 13, 38, 1)),
                              ),
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 275,
                            height: 56,

                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Image.asset('assets/images/facebook.png', width: 24, height: 24),
                              label: Text(
                                "Login With Facebook",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromRGBO(18, 13, 38, 1)),
                              ),
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
