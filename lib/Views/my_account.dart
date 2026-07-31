import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/MyAccountViewModel.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyAccountViewModel>().getProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MyAccountViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: AppColors.primaryWhite, title: Text("My Account"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20),

            GestureDetector(
              onTap: () => vm.showOptions(context, vm),
              child: SizedBox(
                width: 120,
                height: 120,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: vm.image != null ? FileImage(vm.image!) : null,
                  child: vm.image == null ? Image.asset("assets/images/Avatars.png") : null,
                ),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: vm.userNameController,
              decoration: InputDecoration(
                hintText: "User Name",
                suffixIcon: GestureDetector(
                  onTap: () {
                    vm.userNameController.clear();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Change", style: TextStyle(color: Colors.blue)),
                  ),
                ),
                errorText: vm.errorUserName,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                SizedBox(
                  height: 48,
                  width: 68,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: '+91',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: TextField(
                    maxLength: 10,
                    controller: vm.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          vm.phoneController.clear();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Change", style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                      errorText: vm.errorPhone,
                      suffixStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(94, 173, 29, 1)),
                      hintText: 'Phone Number',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: vm.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Email',
                errorText: vm.errorEmail,
              ),
            ),
            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: vm.selectedGender,
              decoration: InputDecoration(
                labelText: 'Gender',
                errorText: vm.errorGender,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: vm.genderOptions.map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
              onChanged: vm.setGender,
            ),

            Spacer(),
            Center(
              child: SizedBox(
                width: 290,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(84, 163, 18, 1),
                    foregroundColor: Color.fromRGBO(84, 163, 18, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                  ),
                  onPressed: () => vm.saveProfile(context),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.bold, color: AppColors.primaryWhite),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
