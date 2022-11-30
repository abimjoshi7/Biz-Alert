import 'package:biz_alert/constants/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final double width;
  final TextInputType? type;
  final bool readonly;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.width,
    this.maxLines = 1,
    this.type,
    this.readonly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration().copyWith(
          labelText: hintText,
        ),
        style: styleTextFormField.copyWith(fontWeight: FontWeight.w400),
        // validator: (val) {
        //   if (val == null || val.isEmpty) {
        //     return 'Enter your $hintText';
        //   }
        //   return null;
        // },
        maxLines: maxLines,
        keyboardType: type,
        readOnly: readonly,
      ),
    );
  }
}
