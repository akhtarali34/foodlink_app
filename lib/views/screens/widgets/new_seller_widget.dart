import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:foodlink/views/screens/inner_screens/SellerDetails/widget/sellerDetail_model.dart';

import '../productDetail/widget/productDetailModel.dart';

class NewSellerWidget extends StatefulWidget {
  @override
  _NewSellerWidgetState createState() => _NewSellerWidgetState();
}

class _NewSellerWidgetState extends State<NewSellerWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;
  int _currentPage = 0;
  late Stream<QuerySnapshot> _productsStream;
  late AsyncSnapshot<QuerySnapshot> _snapshot;

  @override
  void initState() {
    super.initState();
    _productsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _snapshot.data!.size - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LinearProgressIndicator(
              color: AppColors.mainColor,
            ),
          );
        }

        _snapshot = snapshot; // Assign the snapshot to the class-level variable

        return SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _pageController,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final sellerData = snapshot.data!.docs[index];
              return SellerDetailModel(
                sellerData: sellerData,
                fem: fem,
              );
            },
          ),
        );
      },
    );
  }
}
