import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:foodlink/provider/favourite_provider.dart';

import '../../provider/cart_provider.dart';
import 'inner_screens/checkout_screen.dart';
import 'main_Screen.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavouriteProvider _wishProvider =
        Provider.of<FavouriteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: Text(
          'Wishlist Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _wishProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
            ),
          ),
        ],
      ),
      body: _wishProvider.getwishItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _wishProvider.getwishItem.length,
              itemBuilder: (context, index) {
                final wishData =
                    _wishProvider.getwishItem.values.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: SizedBox(
                      height: 150,
                      child: Row(children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(wishData.imageUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wishData.productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                              Text(
                                '\$' + " " + wishData.price.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                  color: AppColors.mainColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _wishProvider.removeItem(wishData.productId);
                                },
                                icon: Icon(
                                  color: AppColors.mainColor,
                                  Icons.cancel,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Wishlist is Empty',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You haven't added any items to your wishlist yet\n. You can add them from the home screen",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
