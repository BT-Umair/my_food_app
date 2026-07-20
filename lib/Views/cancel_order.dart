import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CancelOrderViewModel.dart';
import 'package:provider/provider.dart';

class CancelOrder extends StatelessWidget {
  const CancelOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CancelOrderViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        actions: [Icon(Icons.more_vert_outlined)],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Cancel Order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We are Sorry to hear this',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(54, 58, 51, 1)),
              ),
              SizedBox(height: 12),
              Text(
                'Tell us why you choose to cancel your order, is the reason from our side?',
                style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(96, 101, 92, 1)),
              ),
              SizedBox(height: 10),
              Text(
                'Write down your reason to cancel your order:',
                style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(96, 101, 92, 1)),
              ),
              SizedBox(height: 14),
              TextField(
                controller: vm.reasonController,
                maxLength: 220,
                onChanged: vm.updateText,
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Write here......', border: OutlineInputBorder(), errorText: vm.errorMessage),
              ),
              Spacer(),
              Center(
                child: SizedBox(
                  width: 290,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: vm.isLoading ? null : () => vm.submitCancellation(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color.fromRGBO(70, 137, 13, 1),
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: vm.isLoading
                        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: AppColors.primaryWhite, strokeWidth: 2))
                        : Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
