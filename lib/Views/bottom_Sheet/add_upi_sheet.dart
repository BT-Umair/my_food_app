import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';

class AddUpiSheet extends StatefulWidget {
  const AddUpiSheet({super.key});

  @override
  State<AddUpiSheet> createState() => _AddUpiSheet();
}

class _AddUpiSheet extends State<AddUpiSheet> {
  final upiController = TextEditingController();
  String? upiError;
  bool isLoading = false;

  bool validateUpi() {
    setState(() {
      if (upiController.text.isEmpty) {
        upiError = "Please Enter UPI ID";
      } else if (!upiController.text.contains("@")) {
        upiError = "Please Enter Valid UPI ID";
      } else if (upiController.text.length < 10) {
        upiError = 'Please Enter 10 Digit';
      } else {
        upiError = null;
      }
    });
    return upiError == null;
  }

  void signIn(BuildContext context) {
    if (validateUpi()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved Successfully")));
    }
  }

  // 3. Move dispose OUTSIDE the build method
  // @override
  // void dispose() {
  //   upiController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
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
          Container(
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Your UPI Id',
                      style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.large, color: AppColors.primaryBlack),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLength: 10,
                      controller: upiController,
                      decoration: InputDecoration(
                        suffixText: 'Verify',
                        suffixStyle: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(70, 137, 13, 1)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter your UPI Id',
                        errorText: upiError,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/images/check-circle 1.png'),
                        SizedBox(width: 10),
                        Text(
                          'example1234@icici',
                          style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(70, 137, 13, 1)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 290,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // 4. Fixed: Only call signIn; it internally calls validateUpi
                            signIn(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: AppColors.primaryWhite,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Save and Continue",
                            style: TextStyle(fontWeight: AppFontWeights.bold, fontSize: AppFontSize.medium, color: AppColors.primaryWhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
