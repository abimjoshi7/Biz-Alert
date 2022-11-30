import 'package:biz_alert/providers/theme_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/style.dart';
import '../../../../models/response/top_gainers_res_model.dart';
import '../../../../providers/top_gainers_provider.dart';
import '../../companyDetail/screens/company_detail_screen.dart';

class TopGainers extends StatelessWidget {
  const TopGainers({
    Key? key,
    required this.context,
    required this.topGainersData,
  }) : super(key: key);

  final BuildContext context;
  final Future<TopGainersModel>? topGainersData;

  @override
  Widget build(BuildContext context) {
    final topGainers = Provider.of<TopGainersProvider>(context).topGainers;
    return FutureBuilder<TopGainersModel?>(
        future: topGainersData,
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
                          "Top Gainers",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
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
                          label: Text('LTP', style: dashboardTableStyle),
                        ),
                        DataColumn(
                          label: Text('Pt.Change', style: dashboardTableStyle),
                        ),
                        DataColumn(
                          label: Text('%Change', style: dashboardTableStyle),
                        ),
                      ],
                      rows: List.generate(
                          topGainers!.dataCollection.length < 5
                              ? topGainers.dataCollection.length
                              : 5, (index) {
                        final symbol = topGainers.dataCollection[index].symbol;
                        final ltp = topGainers.dataCollection[index].ltp;
                        final priceChange =
                            topGainers.dataCollection[index].priceChange;
                        final change =
                            topGainers.dataCollection[index].percentageChange;
                        return DataRow(
                            // color: MaterialStateColor.resolveWith((states) =>
                            //     index % 2 == 0
                            //         ? GlobalVariablesColor.mainColor1
                            //         : GlobalVariablesColor.mainColor2),
                            cells: [
                              // Symbol
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topGainers
                                            .dataCollection[index].symbol);
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
                              // ltp
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topGainers
                                            .dataCollection[index].symbol);
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
                              // PriceChange
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topGainers
                                            .dataCollection[index].symbol);
                                  },
                                  child: Text(
                                    priceChange.toString(),
                                    style: dashboardTableRowStyle.copyWith(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              // Change
                              DataCell(GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, CompanyDetailScreen.routeName,
                                      arguments: topGainers
                                          .dataCollection[index].symbol);
                                },
                                child: Text(
                                  change.toString(),
                                  style: dashboardTableRowStyle.copyWith(
                                    color: Colors.green,
                                  ),
                                ),
                              )),
                            ]);
                      }),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
