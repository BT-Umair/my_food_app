import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({super.key});

  @override
  State<AddCardSheet> createState() => _AddCardSheet();
}

class _AddCardSheet extends State<AddCardSheet> {
  final cardNameController = TextEditingController();
  final cardNoController = TextEditingController();
  final expiryController = TextEditingController();
  final securityCodeController = TextEditingController();

  String? cardNameError;
  String? cardNoError;
  String? expiryError;
  String? securityCodeError;

  bool validateCard() {
    setState(() {
      if (cardNameController.text.trim().isEmpty) {
        cardNameError = "Enter cardholder name";
      } else if (cardNameController.text.trim().length < 3) {
        cardNameError = "Name is too short";
      } else {
        cardNameError = null;
      }
      if (cardNoController.text.isEmpty) {
        cardNoError = "Enter card number";
      } else if (cardNoController.text.length < 16) {
        cardNoError = "Must be 16 digits";
      } else if (int.tryParse(cardNoController.text) == null) {
        cardNoError = "Numbers only";
      } else {
        cardNoError = null;
      }
      if (expiryController.text.isEmpty) {
        expiryError = "Enter expiry date";
      } else if (expiryController.text.length < 5 || !expiryController.text.contains('/')) {
        expiryError = "Use MM/YY format";
      } else {
        expiryError = null;
      }
      if (securityCodeController.text.isEmpty) {
        securityCodeError = "Enter security code";
      } else if (securityCodeController.text.length < 3) {
        securityCodeError = "Must be 3 or 4 digits";
      } else if (int.tryParse(securityCodeController.text) == null) {
        securityCodeError = "Numbers only";
      } else {
        securityCodeError = null;
      }
    });
    return cardNameError == null && cardNoError == null && expiryError == null && securityCodeError == null;
  }

  void saveCard(BuildContext context) {
    if (validateCard()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Card Added Successfully")));
    }
  }

  @override
  void dispose() {
    cardNameController.dispose();
    cardNoController.dispose();
    expiryController.dispose();
    securityCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isKeyboardVisible)
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
                  ),
                  child: Icon(Icons.close, size: 20),
                ),
              ),
            ),

          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.primaryWhite,
                      width: 393,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Your Credit/Debit Cards',
                            style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.large, color: AppColors.primaryBlack),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'NAME ON CARD',
                            style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: cardNameController,
                            decoration: InputDecoration(
                              suffixStyle: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(70, 137, 13, 1)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              hintText: 'Enter card name',
                              errorText: cardNameError,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'CARD NUMBER',
                            style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: cardNoController,
                            keyboardType: TextInputType.number,
                            maxLength: 16,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image.asset('assets/images/image 1.png', width: 140, height: 27),
                              ),
                              suffixStyle: TextStyle(fontSize: 14, fontWeight: AppFontWeights.regular, color: AppColors.primaryGreen),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              hintText: 'Enter card number',
                              errorText: cardNoError,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    'EXPIRE DATE',
                                    style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    'SECURITY CODE',
                                    style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: expiryController,
                                    keyboardType: TextInputType.datetime,
                                    maxLength: 5,
                                    decoration: InputDecoration(
                                      hintText: 'mm/yy',
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                      border: InputBorder.none,
                                      errorText: expiryError,
                                    ),
                                  ),
                                ),

                                Container(width: 1, height: 50, color: Colors.grey.shade300),

                                Expanded(
                                  child: TextField(
                                    controller: securityCodeController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: '***',
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                      border: InputBorder.none,
                                      errorText: securityCodeError,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // TextFormField(
                          //   controller: expiryController,
                          //   keyboardType: TextInputType.datetime,
                          //   maxLength: 5,
                          //   decoration: InputDecoration(
                          //     suffixStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(70, 137, 13, 1)),
                          //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          //     hintText: 'mm/yy',
                          //     errorText: expiryError,
                          //   ),
                          // ),
                          SizedBox(height: 15),

                          Center(
                            child: SizedBox(
                              width: 290,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  saveCard(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryGreen,
                                  foregroundColor: AppColors.primaryGreen,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
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
