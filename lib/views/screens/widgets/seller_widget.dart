import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:foodlink/views/screens/widgets/home_products.dart';
import 'package:foodlink/views/screens/widgets/home_seller_widget.dart';
import 'package:foodlink/views/screens/widgets/new_seller_widget.dart';

import '../category_screen.dart';
import 'new_products_widget.dart';

class SellerWidget extends StatefulWidget {
  @override
  State<SellerWidget> createState() => _SellerWidgetState();
}

class _SellerWidgetState extends State<SellerWidget> {
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final Stream<QuerySnapshot> _sellerStream =
    FirebaseFirestore.instance.collection('vendors').snapshots();
    return Padding(

      padding: const EdgeInsets.all(9.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Sellers',
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _sellerStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading Sellers"),
                );
              }

              return Container(

                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final sellerData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ActionChip(
                                backgroundColor: Colors.orange,
                                onPressed: () {
                                  setState(() {

                                    _selectedCity =
                                    sellerData['cityValue'];
                                  });
                                },
                                label: Center(
                                  child: Text(
                                    sellerData['cityValue'].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //       return CategoryScreen();
                        //     }));
                      },
                      child: Container(
                        child: Icon(Icons.arrow_forward_ios_sharp, color: AppColors.mainColor,),


                      ),
                    ),

                  ],
                ),
              );
            },
          ),
          if (_selectedCity == null) NewSellerWidget(),
          if (_selectedCity != null)
            HomeSellerWidget(cityValue: _selectedCity!),
        ],
      ),
    );
  }
}
