import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:foodlink/views/screens/inner_screens/SellerDetails/vendor_detail_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:foodlink/provider/favourite_provider.dart';
import 'package:foodlink/views/screens/productDetail/product_detail_screen.dart';

import '../../../productDetail/vendor_store_detail_screen.dart';

class SellerDetailModel extends StatelessWidget {
  const SellerDetailModel({
    Key? key,
    required this.sellerData,
    required this.fem,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> sellerData;
  final double fem;

  @override
  Widget build(BuildContext context) {

    final FavouriteProvider _wishList =
    Provider.of<FavouriteProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Get.to(VendorStoreDetail(vendorData: sellerData));

      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height:  100 * fem,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffdddddd)),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0f000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 6 * fem,
                  ),
                ],
                borderRadius: BorderRadius.circular(
                    8.0), // Add border radius for a rounded look
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 48 * fem,
                      height: 50 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8.0), // Add border radius for a rounded look
                        child: Image.network(
                          // prouctData['storeImage'][0] ?? "",
                          sellerData['storeImage'],

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sellerData['bussinessName'],
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.525 * fem,
                            color: Color(0xff000000),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          sellerData['cityValue'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.pink,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   right: 15,
          //   top: 8,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: IconButton(
          //       onPressed: (){},
          //       // onPressed: () {
          //       //   _wishList.addProductToWish(
          //       //     sellerData['productName'],
          //       //     sellerData['productId'],
          //       //     sellerData['storeImage'],
          //       //     1,
          //       //     sellerData['quantity'],
          //       //     sellerData['productPrice'],
          //       //     sellerData['vendorId'],
          //       //     '',
          //       //     sellerData['scheduleDate'],
          //       //   );
          //       // },
          //       icon: _wishList.getwishItem.containsKey(sellerData['vendorId'])
          //           ? Icon(
          //         Icons.favorite,
          //         color: AppColors.mainColor,
          //       )
          //           : Icon(
          //         Icons.favorite_border,
          //         color: Colors.red,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
