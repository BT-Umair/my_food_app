import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget myaccountshimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        SizedBox(height: 20),
        GestureDetector(
          // onTap: showOptions,
          child: Container(
            width: 120,
            height: 120,
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              // radius: 60,
              backgroundColor: Colors.transparent,
              // backgroundImage: _image != null ? FileImage(_image!) : null,
              // child: _image == null ? Image.asset('assets/images/Avatars.png') : null,
            ),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixText: 'Change',
              hintText: '',
              suffixStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(94, 173, 29, 1)),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SizedBox(
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
            ),
            SizedBox(width: 14),

            Expanded(
              child: SizedBox(
                height: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixText: 'Change',
                    suffixStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(94, 173, 29, 1)),
                    hintText: '',
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: '',
          ),
        ),
        SizedBox(height: 20),

        // DropdownButtonFormField<String>(
        //   value: selectedGender,
        //   decoration: InputDecoration(
        //     labelText: 'Gender',
        //     suffixText: 'Change',
        //     suffixStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(94, 173, 29, 1)),

        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //   ),
        //   items: genderOptions.map((String gender) {
        //     return DropdownMenuItem<String>(value: gender, child: Text(gender));
        //   }).toList(),
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       selectedGender = newValue;
        //     });
        //   },
        //   validator: (value) => value == null ? 'Please select a gender' : null,
        // ),
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
              onPressed: () {},
              child: Text(
                '',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
