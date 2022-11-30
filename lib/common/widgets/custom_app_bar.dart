import 'package:biz_alert/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final String text1;
  final IconData? icon1;
  final IconData? icon2;
  final VoidCallback onPressed;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  final PreferredSizeWidget? tabs;

  const CustomAppBar({
    Key? key,
    required this.text,
    this.text1 = "",
    this.icon1,
    this.icon2,
    required this.onPressed,
    this.onPressed1,
    this.onPressed2,
    this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            // color: GlobalVariablesColor.mainColor,
            // border: Border.all(color: GlobalVariablesColor.mainColor1)
            ),
      ),
      elevation: 1.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        // color: GlobalVariablesColor.backgroundColor,
        onPressed: onPressed,
      ), //Leading = for the left Sided

      title: Column(
        children: [
          Text(text, style: appbarTitleStyle),
          Text(text1, style: appbarTitleStyle.copyWith(fontSize: 15.sp)),
        ],
      ),
      centerTitle: true,

      actions: [
        IconButton(
          onPressed: onPressed1,
          icon: Icon(icon1),
          // color: GlobalVariablesColor.backgroundColor,
        ),
        IconButton(
          onPressed: onPressed2,
          icon: Icon(icon2),
          // color: GlobalVariablesColor.backgroundColor,
        ),
      ],

      bottom: tabs,
    );
  }
}
