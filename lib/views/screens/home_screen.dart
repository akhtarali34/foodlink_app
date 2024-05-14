import 'package:flutter/material.dart';
import 'package:foodlink/views/screens/category_screen.dart';
import 'package:foodlink/views/screens/widgets/banner_widget.dart';
import 'package:foodlink/views/screens/widgets/category_text.dart';
import 'package:foodlink/views/screens/widgets/customAppBar.dart';
import 'package:foodlink/views/screens/widgets/new_products_widget.dart';
import 'package:foodlink/views/screens/widgets/main_dishes.dart';
import 'package:foodlink/views/screens/widgets/reuseText_widget.dart';
import 'package:foodlink/views/screens/widgets/seller_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          SizedBox(
            height: 10,
          ),
          BannerWidget(),
          SizedBox(
            height: 10,
          ),
          CategoryText(),
          SizedBox(height: 5,),
          SellerWidget(),
          SizedBox(height: 5,),
        ],
      ),
    ));
  }
}
