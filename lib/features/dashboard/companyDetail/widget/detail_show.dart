import 'package:biz_alert/constants/style.dart';
import 'package:flutter/material.dart';

class DetailShow extends StatelessWidget {
  final String text;
  final String value;
  final Color color;
  const DetailShow(
      {Key? key, required this.text, required this.value, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              text,
              style: companyDetailStyle.copyWith(fontSize: 11),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              value,
              style: companyDetailStyle1.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
