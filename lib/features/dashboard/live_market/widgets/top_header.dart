import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/models/response/live_market_trading_res_model.dart';
import 'package:biz_alert/providers/live_market_trading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TopHeader extends StatelessWidget {
  final Color? textColor;
  final Color? boxColor;
  final Color? textColor1;
  final Color? boxColor1;
  final String text;
  final String text1;
  final VoidCallback onPressed;
  final VoidCallback onPressed1;
  const TopHeader(
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Live Market
            GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 80.w,
                height: 45.h,
                decoration: BoxDecoration(
                  border: Border.all(color: GlobalVariablesColor.mainColor),
                  color: boxColor,
                  borderRadius: BorderRadius.circular(5),
                ),
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
            // Share Price
            GestureDetector(
              onTap: onPressed1,
              child: Container(
                width: 80.w,
                height: 45.h,
                decoration: BoxDecoration(
                  border: Border.all(color: GlobalVariablesColor.mainColor),
                  color: boxColor1,
                  borderRadius: BorderRadius.circular(5),
                ),
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
        ),
        // Date and Time
        const DateAndTime(),
      ],
    );
  }
}

class DateAndTime extends StatefulWidget {
  const DateAndTime({Key? key}) : super(key: key);

  @override
  State<DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  Future<LiveMarketTradingModel>? liveMarketData;

  @override
  void initState() {
    super.initState();
    final liveMarketTrading =
        Provider.of<LiveMarketTradingProvider>(context, listen: false);
    liveMarketData = liveMarketTrading.getLiveMarketTradingData();
  }

  @override
  Widget build(BuildContext context) {
    final liveMarketTrading =
        Provider.of<LiveMarketTradingProvider>(context).liveMarket;
    return FutureBuilder<LiveMarketTradingModel?>(
        future: liveMarketData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return Row(
              children: [
                // Date and Month
                Text(
                  DateFormat('MMM dd ').format(DateFormat("yyyy/MM/dd HH:mm:ss")
                      .parse(liveMarketTrading!.dataCollection[0].date
                          .toString())),
                  style: dateTimeStyle.copyWith(fontSize: 15.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "|",
                  style: dateTimeStyle.copyWith(fontSize: 25.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                // Time
                Text(
                  DateFormat('hh:mm a ').format(
                      DateFormat("yyyy/MM/dd HH:mm:ss").parse(
                          liveMarketTrading.dataCollection[0].date.toString())),
                  style: dateTimeStyle.copyWith(fontSize: 15.sp),
                ),
              ],
            );
          }
        });
  }
}
