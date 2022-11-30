import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar1 extends StatelessWidget {
  final String text;
  final IconData? icon1;
  final IconData? icon2;
  final VoidCallback onPressed;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  final Widget? child2;
  final PreferredSizeWidget? tabs;
  const CustomAppBar1({
    Key? key,
    required this.text,
    this.icon1,
    this.icon2,
    required this.onPressed,
    this.onPressed1,
    this.onPressed2,
    this.tabs,
    this.child2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //     color: GlobalVariablesColor.mainColor,
      //     // border: Border.all(color: GlobalVariablesColor.mainColor1)
      //   ),
      // ),
      // elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        // color: GlobalVariablesColor.backgroundColor,
        onPressed: onPressed,
      ), //Leading = for the left Sided

      title: Text(text,
          style: appbarTitleStyle.copyWith(
            color: GlobalVariablesColor.mainColor,
          )),

      centerTitle: true,

      actions: [
        IconButton(
          onPressed: onPressed1,
          icon: Icon(icon1),
          // color: GlobalVariablesColor.backgroundColor,
        ),
        child2 ??
            IconButton(
              onPressed: onPressed2,
              icon: Icon(
                icon2,
                color: GlobalVariablesColor.mainColor,
              ),
              // color: GlobalVariablesColor.backgroundColor,
            ),
      ],

      bottom: tabs,
    );
  }
}
