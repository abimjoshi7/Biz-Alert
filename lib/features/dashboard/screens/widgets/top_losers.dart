import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/style.dart';
import '../../../../models/response/top_losers_res_model.dart';
import '../../../../providers/theme_notifier_provider.dart';
import '../../../../providers/top_losers_provider.dart';

class TopLosers extends StatelessWidget {
  const TopLosers({
    Key? key,
    required this.context,
    required this.topLosersData,
  }) : super(key: key);

  final BuildContext context;
  final Future<TopLosersModel>? topLosersData;

  @override
  Widget build(BuildContext context) {
    final topLosers = Provider.of<TopLosersProvider>(context).topLosers;
    return FutureBuilder<TopLosersModel?>(
        future: topLosersData,
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
                          "Top Losers",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
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
                        topLosers!.dataCollection.length < 5
                            ? topLosers.dataCollection.length
                            : 5,
                        (index) {
                          final symbol = topLosers.dataCollection[index].symbol;
                          final ltp = topLosers.dataCollection[index].ltp;
                          final priceChange =
                              topLosers.dataCollection[index].priceChange;
                          final change =
                              topLosers.dataCollection[index].percentageChange;

                          return DataRow(
                            cells: [
                              // Symbol
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topLosers
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
                                        arguments: topLosers
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
                                        arguments: topLosers
                                            .dataCollection[index].symbol);
                                  },
                                  child: Text(
                                    priceChange.toString(),
                                    style: dashboardTableRowStyle.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),

                              // Change
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CompanyDetailScreen.routeName,
                                        arguments: topLosers
                                            .dataCollection[index].symbol);
                                  },
                                  child: Text(
                                    change.toString(),
                                    style: dashboardTableRowStyle.copyWith(
                                      color: Colors.red,
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
