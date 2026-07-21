import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/ViewModels/CouponViewModel.dart';
import 'package:provider/provider.dart';

class ViewCoupon extends StatelessWidget {
  const ViewCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => CouponViewModel(), child: const _ViewCouponBody());
  }
}

class _ViewCouponBody extends StatefulWidget {
  const _ViewCouponBody();

  @override
  State<_ViewCouponBody> createState() => _ViewCouponBodyState();
}

class _ViewCouponBodyState extends State<_ViewCouponBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CouponViewModel>().getAllActiveCoupon(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CouponViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        title: const Text("Coupon Code"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              if (vm.selectedIndex != null && vm.getAllActiveCouponResponseModel?.data != null) {
                String selectedCode = vm.getAllActiveCouponResponseModel!.data![vm.selectedIndex!].code ?? "";

                if (selectedCode.isNotEmpty) {
                  bool isApplied = await vm.applyCouponCode(context, selectedCode);
                  setState(() {});
                  if (isApplied && context.mounted) {
                    // CRITICAL FIX: Back jaane se pehle Cart ka data refresh kiya
                    // Isse View Cart screen par naya amount turant dikhega
                    await context.read<CartViewModel>().getAllCart(context);
                    Navigator.pop(context, selectedCode);
                  }
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a coupon from the list first")));
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  "Apply",
                  style: TextStyle(color: Color.fromRGBO(94, 173, 29, 1), fontWeight: AppFontWeights.bold, fontSize: AppFontSize.medium),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: vm.updateSearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(94, 173, 29, 1)),
                hintText: "Type coupon name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Select from these",
              style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(112, 117, 107, 1)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color.fromRGBO(94, 173, 29, 1)))
                  : (vm.getAllActiveCouponResponseModel?.data == null || vm.getAllActiveCouponResponseModel!.data!.isEmpty)
                  ? const Center(child: Text("No active coupons available"))
                  : ListView.separated(
                      itemCount: vm.getAllActiveCouponResponseModel!.data!.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = vm.getAllActiveCouponResponseModel!.data![index];

                        return InkWell(
                          onTap: () => vm.selectCoupon(index),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromRGBO(197, 197, 197, 1)),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(250, 250, 250, 1),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.code ?? "NO CODE",
                                        style: TextStyle(fontWeight: AppFontWeights.medium, color: Color.fromRGBO(96, 101, 92, 1)),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        item.description ?? "",
                                        style: TextStyle(fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                                      ),
                                    ],
                                  ),
                                ),
                                Radio<int>(
                                  value: index,
                                  groupValue: vm.selectedIndex,
                                  activeColor: AppColors.primaryGreen,
                                  onChanged: (value) => vm.selectCoupon(value!),
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
  }
}
