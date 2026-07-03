import 'package:flutter/material.dart';
import 'package:my_foodapp/Views/Shimmer/favourites_shimmer.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'Favourites',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),

            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Color.fromRGBO(77, 152, 14, 1), shape: BoxShape.circle),
              child: Center(
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? favouriteShimmer()
          : SafeArea(
              bottom: true,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 230,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: 169,
                            height: 220,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(255, 255, 255, 1)),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentGeometry.topRight,
                                  children: [
                                    ClipRRect(borderRadius: BorderRadiusGeometry.circular(10), child: Image.asset('assets/images/SouthIndian.png')),
                                    Image.asset('assets/images/like.png'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset('assets/images/Frame 2.png'),
                                    Spacer(),
                                    Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1)),
                                    Text('5.0 (12)'),
                                  ],
                                ),
                                Text(
                                  'South Indian Thali',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '₹99',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(85, 85, 85, 1)),
                                    ),
                                    Spacer(),
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8))),
                                      child: Text(
                                        'ADD',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(84, 163, 18, 1)),
                                      ),
                                    ),
                                  ],
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
