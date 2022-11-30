import 'package:biz_alert/constants/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color borderColor;
  final Color textColor;
  final double width;
  final double height;
  final double textSize;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.bgColor,
    required this.borderColor,
    required this.textSize,
    required this.textColor,
    required this.text,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: styleMainButton.copyWith(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
