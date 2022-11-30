import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../models/response/stock_graph_res_model.dart';

class AreaGraph extends StatelessWidget {
  const AreaGraph({
    Key? key,
    required this.stockGraphData,
    required this.isShown,
    required this.tooltip,
  }) : super(key: key);

  final Future<StockGraphResModel?>? stockGraphData;
  final bool isShown;
  final TooltipBehavior tooltip;

  @override
  Widget build(BuildContext context) {
    // List<GraphData> graphData = [];

    return FutureBuilder<StockGraphResModel?>(
        future: stockGraphData,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.status == "Success") {
            return Visibility(
              visible: isShown,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      minimum:
                          snapshot.data!.dataCollection.agm.first.close / 2,
                      maximum:
                          snapshot.data!.dataCollection.agm.first.close * 2,
                      interval: 50),
                  tooltipBehavior: tooltip,
                  series: <ChartSeries<Agm, String>>[
                    AreaSeries<Agm, String>(
                        dataSource: snapshot.data!.dataCollection.agm,
                        xValueMapper: (Agm data, _) => DateFormat.Md()
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                data.unixDateTime * 1000))
                            .toString(),
                        yValueMapper: (Agm data, _) => data.close,
                        name: 'Data',
                        color: const Color.fromRGBO(8, 142, 255, 1))
                  ]),
            );
          }
          return const CustomLoader();

          // if (snapshot.hasData && snapshot.data?.status == "Success") {
          //   final dates = snapshot.data!.dataCollection.agm
          //       .map((e) => e.unixDateTime)
          //       .map((element) {
          //     return DateTime.fromMillisecondsSinceEpoch(element * 1000);
          //     // DateFormat.Md().format();
          //   }).toList();

          //   final values = snapshot.data!.dataCollection.agm
          //       .map((e) => e.close)
          //       .map((e) => e)
          //       .toList();

          //   for (DateTime date in dates) {
          //     for (double value in values) {
          //       graphData.add(GraphData(date, value));
          //     }
          //   }

          //   return Visibility(
          //     visible: isShown,
          //     child:
          //         // ElevatedButton(
          //         //   onPressed: () {
          //         //     graphData.forEach((element) {
          //         //       print(element.month);
          //         //       print(element.value);
          //         //     });
          //         //   },
          //         //   child: Text("test"),
          //         // )
          //         SfCartesianChart(
          //             primaryXAxis: DateTimeAxis(),
          //             series: <ChartSeries>[
          //           // Renders line chart
          //           LineSeries<GraphData, DateTime>(
          //               dataSource: graphData,
          //               xValueMapper: (GraphData graph, _) => graph.month,
          //               yValueMapper: (GraphData graph, _) => graph.value)
          //         ]),
          //   );
          // }
          // return const SizedBox.shrink();
        });
  }
}

class GraphData {
  GraphData(this.month, this.value);
  final DateTime month;
  final double value;
}
