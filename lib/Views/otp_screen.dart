import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/OtpViewModel.dart';
import 'package:my_foodapp/Views/home_screen.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OtpViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 260,
              child: Image.asset('assets/images/otpbike.png', fit: BoxFit.contain),
            ),

            SizedBox(height: 10),

            Text('OTP Verification', style: TextStyle(fontSize: 22, fontWeight: AppFontWeights.bold)),

            SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'We are Sending you an OTP to Verify Your Phone Number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.bold, color: AppColors.darkCharcoal),
              ),
            ),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  width: 40,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: TextField(
                    controller: vm.otpControllers[index],
                    focusNode: vm.focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => vm.onOtpChanged(value, index),
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                    ),

                    onEditingComplete: () {
                      vm.onBackspace(index);
                    },
                  ),
                );
              }),
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 40)),
                Text(
                  "Edit Phone Number ?",
                  style: TextStyle(fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal, fontSize: 14),
                ),
              ],
            ),

            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 290,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    bool success = await vm.verifyOtp();

                    if (success) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(vm.otpMessageError)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(84, 163, 18, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: vm.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Verify Mobile',
                          style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                        ),
                ),
              ),
            ),

            SizedBox(height: 40),
            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RichText(
                text: TextSpan(
                  text: 'I Don’t Receive a Code! ',
                  style: TextStyle(color: AppColors.darkCharcoal, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Resend Code',
                      style: TextStyle(
                        color: Color.fromRGBO(70, 137, 13, 1),
                        decoration: TextDecoration.underline,
                        fontWeight: AppFontWeights.medium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
