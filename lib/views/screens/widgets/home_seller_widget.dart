import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodlink/views/screens/inner_screens/SellerDetails/widget/sellerDetail_model.dart';

import '../productDetail/widget/productDetailModel.dart';

class HomeSellerWidget extends StatelessWidget {
  final String cityValue;

  const HomeSellerWidget({super.key, required this.cityValue});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('vendors')
        .where('cityValue', isEqualTo: cityValue)
        .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading.....");
        }

        return Container(
            height: 100,
            child: PageView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final sellerData = snapshot.data!.docs[index];
                  return SellerDetailModel(
                    sellerData: sellerData,
                    fem: fem,
                  );
                }));
      },
    );
  }
}
