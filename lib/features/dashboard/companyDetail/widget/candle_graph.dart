import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../models/response/stock_graph_res_model.dart';

class CandleGraph extends StatelessWidget {
  const CandleGraph({
    Key? key,
    required this.stockGraphData,
    required this.height,
    required TooltipBehavior tooltip,
    required this.isShown,
  })  : _tooltip = tooltip,
        super(key: key);

  final Future<StockGraphResModel?>? stockGraphData;
  final double height;
  final TooltipBehavior _tooltip;
  final bool isShown;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StockGraphResModel?>(
      future: stockGraphData,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data?.status == "Success") {
          return Visibility(
            visible: isShown,
            child: SizedBox(
              height: height * 0.35,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          minimum:
                              snapshot.data!.dataCollection.agm.first.close / 2,
                          maximum:
                              snapshot.data!.dataCollection.agm.first.close * 2,
                          interval: 50),
                      tooltipBehavior: _tooltip,
                      series: <ChartSeries<Agm, String>>[
                        CandleSeries<Agm, String>(
                          openValueMapper: (Agm data, _) => data.open,
                          highValueMapper: (Agm data, _) => data.high,
                          lowValueMapper: (Agm data, _) => data.low,
                          closeValueMapper: (Agm data, _) => data.close,
                          dataSource: snapshot.data!.dataCollection.agm,
                          xValueMapper: (Agm data, _) => DateFormat.Md()
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  data.unixDateTime * 1000))
                              .toString(),
                          name: "Data",
                        )
                      ]),
                ),
              ),
            ),
          );
        }
        return const CustomLoader();
      },
    );
  }
}
