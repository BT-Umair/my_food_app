import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget myordersshimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: EdgeInsets.all(20),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},

                  child: Container(
                    padding: EdgeInsets.all(15),

                    child: Text('', textAlign: TextAlign.center),
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {},

                  child: Container(
                    padding: EdgeInsets.all(15),

                    child: Text('', textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              itemCount: 4,

              separatorBuilder: (_, __) => SizedBox(height: 15),

              itemBuilder: (context, index) {
                final order = index;

                return Container(
                  padding: EdgeInsets.all(10),

                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: AssetImage('assets/images/Paneer.png'), fit: BoxFit.cover),
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text("", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    Text("", style: TextStyle(fontWeight: FontWeight.w500)),
                                    SizedBox(width: 10),
                                    Text(""),
                                  ],
                                ),

                                SizedBox(height: 5),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('', style: TextStyle(fontWeight: FontWeight.w500)),
                                    SizedBox(width: 10),
                                    Expanded(child: Text("")),
                                  ],
                                ),

                                SizedBox(height: 5),

                                Row(
                                  children: [
                                    Text('', style: TextStyle(fontWeight: FontWeight.w500)),
                                    SizedBox(width: 10),
                                    Text(""),
                                  ],
                                ),

                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},

                              style: OutlinedButton.styleFrom(
                                fixedSize: Size.fromHeight(45),
                                side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),

                              child: Text(
                                "",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          OutlinedButton(
                            onPressed: () {},

                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromHeight(45),
                              side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1), width: 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),

                            child: Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ],
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
