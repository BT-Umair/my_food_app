import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/AddAddressViewModel.dart';
import 'package:my_foodapp/ViewModels/AddressViewModel.dart';
import 'package:my_foodapp/Views/add_address.dart';
import 'package:my_foodapp/Views/edit_address.dart';
import 'package:provider/provider.dart';

class Address extends StatefulWidget {
  final String? id;
  const Address({super.key, this.id});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Addressviewmodel>(context, listen: false).callAddressApi(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Addressviewmodel>(context);
    final addAddressVm = Provider.of<AddAddressViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Address',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SafeArea(
            bottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SAVED ADDRESSES',
                  style: TextStyle(fontSize: 12, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                ),
                SizedBox(height: 20),
                if (vm.getAddressListResponseModel.data?.addresses != null)
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: vm.getAddressListResponseModel.data!.addresses!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final address = vm.getAddressListResponseModel.data!.addresses![index];
                      return Container(
                        decoration: BoxDecoration(color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                vm.setDefaultApi(context, address.sId);
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/images/Home.png'),
                                  SizedBox(width: 8),
                                  Text(
                                    address.addressType!,
                                    style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.primaryBlack),
                                  ),
                                  Spacer(),
                                  Text(
                                    address.phone!,
                                    style: TextStyle(fontSize: 14, fontWeight: AppFontWeights.medium, color: AppColors.primaryBlack),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                vm.setDefaultApi(context, address.sId);
                              },
                              child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 31)),
                                  Text(
                                    address.fullName! + address.addressLine!,
                                    style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium, color: AppColors.darkCharcoal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 30)),
                                Image.asset('assets/images/Edit.png'),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddress(id: address.sId ?? "")));
                                  },
                                  child: Text(
                                    'Edit Address',
                                    style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(84, 163, 18, 1)),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Image.asset('assets/images/Delete.png'),

                                //  InkWell(
                                //   onTap: () {
                                //     showDialog(
                                //       context: context,
                                //       barrierDismissible: false,
                                //       builder: (BuildContext dialogContext) {
                                //         return AlertDialog(
                                //           content: const Text(
                                //             "Are you sure you Want to delete this address?",
                                //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                //           ),
                                //           actions: [
                                //             TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text("NO")),

                                //             ElevatedButton(
                                //               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                //               onPressed: () async {
                                //                 bool success = await addAddressVm.deleteAddressapi(context, address.sId);

                                //                 if (success) {
                                //                   addAddressVm.deleteAddressapi(context, widget.id);
                                //                   Navigator.pop(dialogContext);
                                //                 }
                                //               },
                                //               child: Text("YES", style: TextStyle(color: Colors.white)),
                                //             ),
                                //           ],
                                //         );
                                //       },
                                //     );
                                //   },
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext dialogContext) {
                                        final isDark = Theme.of(context).brightness == Brightness.dark;

                                        return AlertDialog(
                                          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                                          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(color: AppColors.primaryGreen.withOpacity(0.1), shape: BoxShape.circle),
                                                child: Icon(Icons.delete_outline_rounded, color: AppColors.primaryGreen, size: 36),
                                              ),
                                              const SizedBox(height: 16),

                                              Text(
                                                "Delete Address?",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDark ? Colors.white : const Color(0xFF212121),
                                                ),
                                              ),
                                              const SizedBox(height: 8),

                                              Text(
                                                "Are you sure you want to delete this address?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white60 : Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    ),
                                                    onPressed: () => Navigator.pop(dialogContext),
                                                    child: Text(
                                                      "NO, CANCEL",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: isDark ? Colors.white60 : Colors.grey[700],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),

                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.green,
                                                      elevation: 0,
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    ),
                                                    onPressed: () async {
                                                      if (!context.mounted) return;
                                                      bool success = await addAddressVm.deleteAddressapi(context, address.sId);
                                                      if (success && dialogContext.mounted) {
                                                        Navigator.pop(dialogContext);
                                                      }
                                                    },
                                                    child: const Text(
                                                      "YES, DELETE",
                                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },

                                  // child: const Icon(Icons.delete, color: Colors.grey),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Delete Address',
                                      style: TextStyle(fontSize: 13, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(84, 163, 18, 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 353,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress()));
                        },
                        style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          'Add New Address',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromRGBO(54, 58, 51, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
