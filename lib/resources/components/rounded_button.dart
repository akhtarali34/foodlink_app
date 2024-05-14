import 'package:flutter/material.dart';

import 'app_colors.dart';

class RoundedButton extends StatefulWidget {
  String title;
  VoidCallback onTap;
  bool loading;

  RoundedButton(
      {super.key,
        required this.title,
        required this.onTap,
        required this.loading});

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: height*0.06,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: widget.loading
              ? const CircularProgressIndicator(
            color: Colors.white,
          )
              : Text(
            widget.title,
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}