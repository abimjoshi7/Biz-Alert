import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/style.dart';
import '../../../../models/response/top_turnover_res_model.dart';
import '../../../../providers/theme_notifier_provider.dart';
import '../../../../providers/top_turnover_provider.dart';

class TopTurnover extends StatelessWidget {
  const TopTurnover({
    Key? key,
    required this.context,
    required this.topTurnoverData,
  }) : super(key: key);

  final BuildContext context;
  final Future<TopTurnoverModel>? topTurnoverData;

  @override
  Widget build(BuildContext context) {
    final topTurnover = Provider.of<TopTurnoverProvider>(context).topTurnover;
    return FutureBuilder<TopTurnoverModel?>(
        future: topTurnoverData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  SizedBox(
                      height: 38,
                      child: Center(
                        child: Text(
                          "Top Turnover",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Provider.of<ThemeNotifier>(context)
                                        .getTheme() ==
                                    darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      headingRowHeight: 40,
                      columnSpacing: 30,
                      showBottomBorder: true,
                      dataRowHeight: 40,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => GlobalVariablesColor.mainColor),
                      columns: [
                        DataColumn(
                          label: Text('Symbol', style: dashboardTableStyle),
                        ),
                        DataColumn(
                          label: Text('Turnover', style: dashboardTableStyle),
                        ),
                        DataColumn(
                          label: Text('LTP', style: dashboardTableStyle),
                        ),
                      ],
                      rows: List.generate(
                        topTurnover!.dataCollection.length < 5
                            ? topTurnover.dataCollection.length
                            : 5,
                        (index) {
                          final symbol =
                              topTurnover.dataCollection[index].stockSymbol;
                          final turnOver =
                              topTurnover.dataCollection[index].turnover;
                          final ltp =
                              topTurnover.dataCollection[index].lastTradePrice;

                          return DataRow(
                            cells: [
                              // Symbol
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topTurnover
                                            .dataCollection[index].stockSymbol);
                                  },
                                  child: Text(
                                    symbol,
                                    style: dashboardTableRowStyle.copyWith(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              // Turnover
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topTurnover
                                            .dataCollection[index].stockSymbol);
                                  },
                                  child: Text(
                                    turnOver,
                                    style: dashboardTableRowStyle.copyWith(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              // ltp
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topTurnover
                                            .dataCollection[index].stockSymbol);
                                  },
                                  child: Text(
                                    ltp.toString(),
                                    style: dashboardTableRowStyle.copyWith(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
