import 'package:flutter/material.dart';
import 'package:my_foodapp/Utils/constants.dart';
import 'package:my_foodapp/ViewModels/RestaurantDetailViewModel.dart';
import 'package:my_foodapp/Views/Shimmer/favourites_shimmer.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantDetailViewModel>(context, listen: false).myWishlist(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailViewModel>(
      builder: (context, vm, child) {
        final fav = vm.myWishListResponseModel.data;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
            title: const Text(
              'Favourites',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(color: Color.fromRGBO(77, 152, 14, 1), shape: BoxShape.circle),
                  child: const Center(
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
                          padding: const EdgeInsets.all(10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 240,
                          ),
                          itemCount: fav?.getData?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = vm.myWishListResponseModel.data?.getData?[index];

                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: 169,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: AlignmentGeometry.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: item?.image != null && item!.image!.isNotEmpty
                                              ? Image.network(
                                                  item.image!.startsWith('http') ? item.image! : '${Const.BASE_URL}${item.image}',
                                                  height: 90,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,

                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                    'assets/images/SouthIndian.png',
                                                    height: 90,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset('assets/images/SouthIndian.png', height: 90, width: double.infinity, fit: BoxFit.cover),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: vm.isLoading
                                                ? null
                                                : () async {
                                                    bool isSuccess = await context.read<RestaurantDetailViewModel>().toggleWishlist(
                                                      context,
                                                      item?.sId ?? "",
                                                    );

                                                    if (isSuccess && context.mounted) {
                                                      context.read<RestaurantDetailViewModel>().myWishlist(context);
                                                    }
                                                  },

                                            child: Image.asset('assets/images/like (1).png', width: 32),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset('assets/images/Frame 2.png'),
                                        const Spacer(),
                                        const Icon(Icons.star, color: Color.fromRGBO(94, 173, 29, 1), size: 16),
                                        Text('${item?.rating ?? 0.0}', style: const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item?.name ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '₹${item?.price ?? 0}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color.fromRGBO(85, 85, 85, 1)),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        SizedBox(
                                          height: 30,
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: Color.fromRGBO(84, 163, 18, 1)),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                            ),
                                            child: const Text(
                                              'ADD',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromRGBO(84, 163, 18, 1)),
                                            ),
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
      },
    );
  }
}
