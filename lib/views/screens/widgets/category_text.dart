import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:foodlink/views/screens/widgets/home_products.dart';

import '../category_screen.dart';
import 'new_products_widget.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final Stream<QuerySnapshot> _catgoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(

      padding: const EdgeInsets.all(9.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _catgoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading categories"),
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
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ActionChip(
                                backgroundColor: Colors.orange,
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory =
                                        categoryData['categoryName'];
                                  });
                                },
                                label: Center(
                                  child: Text(
                                    categoryData['categoryName'].toUpperCase(),
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
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                  return CategoryScreen();
                  }));
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
          if (_selectedCategory == null) NewProductWidget(),
          if (_selectedCategory != null)
            HomeproductWidget(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
