import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/AddAddressViewModel.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatefulWidget {
  final String? id;

  const EditAddress({super.key, this.id});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(widget.id);
      Provider.of<AddAddressViewModel>(context, listen: false).getAddressApi(context, widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddAddressViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            vm.clearControllers();
          },
        ),
        title: Text(
          'Address',
          style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
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
                  style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              TextFormField(
                controller: vm.nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: vm.getAddressResponseModel.data?.fullName,
                  labelText: 'Enter Delivery Name',
                  errorText: vm.nameError,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: vm.phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: vm.getAddressResponseModel.data?.phone,
                  labelText: 'Phone number',
                  errorText: vm.phoneError,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: vm.addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: 'Complete Address',
                  labelText: 'Complete Address',
                  errorText: vm.addressError,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: vm.landmarkController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: 'Near Land mark',
                  labelText: 'Near Land mark',
                  errorText: vm.landmarkError,
                ),
              ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: vm.cityController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              //     hintText: 'Enter City',
              //     labelText: 'City',
              //     errorText: vm.cityError,
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: vm.stateController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              //     hintText: 'Enter State',
              //     labelText: 'State',
              //     errorText: vm.stateError,
              //   ),
              // ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 6,
                keyboardType: TextInputType.numberWithOptions(),
                controller: vm.pinCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: 'Enter PinCode',
                  labelText: 'Pincode',
                  errorText: vm.pinCodeError,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 290,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    vm.edit(context, widget.id);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                    backgroundColor: Color.fromRGBO(70, 137, 13, 1),
                    foregroundColor: Color.fromRGBO(70, 137, 13, 1),
                  ),

                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: AppFontWeights.medium, color: AppColors.primaryWhite),
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
