import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/models/response/get_indices_res_model.dart';
import 'package:biz_alert/providers/get_indices_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// It is not used anywhere for now

class DateAndTime extends StatefulWidget {
  const DateAndTime({Key? key}) : super(key: key);

  @override
  State<DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  Future<GetIndicesModel>? getIndicesData;

  @override
  void initState() {
    super.initState();
    final getIndices = Provider.of<GetIndicesProvider>(context, listen: false);
    getIndicesData = getIndices.getIndicesData();
  }

  @override
  Widget build(BuildContext context) {
    final getIndices = Provider.of<GetIndicesProvider>(context).getIndices;

    return FutureBuilder<GetIndicesModel?>(
        future: getIndicesData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Date and Month
                Text(
                  DateFormat('MMM dd').format(DateFormat("yyyy/MM/dd HH:mm:ss")
                      .parse(getIndices!.dataCollection[1].datetime)),
                  style: dateTimeStyle.copyWith(
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "|",
                  style: dateTimeStyle.copyWith(
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                // Time
                Text(
                  DateFormat('hh:mm:ss a ').format(
                      DateFormat("yyyy/MM/dd HH:mm:ss")
                          .parse(getIndices.dataCollection[1].datetime)),
                  style: dateTimeStyle.copyWith(fontSize: 15.sp),
                ),
              ],
            );
          }
        });
  }
}
