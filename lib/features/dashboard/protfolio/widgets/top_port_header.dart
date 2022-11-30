import 'package:biz_alert/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// It is not used for anywhere for now

class TopPortfolioHeader extends StatelessWidget {
  final Color? textColor;
  final Color? boxColor;
  final Color? textColor1;
  final Color? boxColor1;
  final String text;
  final String text1;
  final VoidCallback onPressed;
  final VoidCallback onPressed1;
  const TopPortfolioHeader(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.boxColor,
      required this.text1,
      required this.textColor1,
      required this.boxColor1,
      required this.onPressed,
      required this.onPressed1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Portfolio Overview
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 130.w,
            height: 45.h,
            decoration: BoxDecoration(
                border: Border.all(color: GlobalVariablesColor.mainColor1),
                color: boxColor),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        // Summary
        GestureDetector(
          onTap: onPressed1,
          child: Container(
            width: 80.w,
            height: 45.h,
            decoration: BoxDecoration(
                border: Border.all(color: GlobalVariablesColor.mainColor1),
                color: boxColor1),
            child: Center(
              child: Text(
                text1,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
