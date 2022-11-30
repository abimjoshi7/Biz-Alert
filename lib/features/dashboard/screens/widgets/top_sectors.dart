import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/style.dart';
import '../../../../models/response/top_sector_res_model.dart';
import '../../../../providers/theme_notifier_provider.dart';
import '../../../../providers/top_sector_provider.dart';

class TopSector extends StatelessWidget {
  const TopSector({
    Key? key,
    required this.context,
    required this.topSectorData,
  }) : super(key: key);

  final BuildContext context;
  final Future<TopSectorModel>? topSectorData;

  @override
  Widget build(BuildContext context) {
    final topSector = Provider.of<TopSectorProvider>(context).topSector;
    return FutureBuilder<TopSectorModel?>(
        future: topSectorData,
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
                          "Top Sector",
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
                          label: Text('Sector', style: dashboardTableStyle),
                        ),
                        DataColumn(
                          label: Text('Turnover', style: dashboardTableStyle),
                        ),
                      ],
                      rows: List.generate(
                        topSector!.dataCollection.length < 5
                            ? topSector.dataCollection.length
                            : 5,
                        (index) {
                          final sector =
                              topSector.dataCollection[index].sectorName;
                          final turnOver =
                              topSector.dataCollection[index].turnover;

                          return DataRow(
                            cells: [
                              // Symbol
                              DataCell(
                                Text(
                                  sector,
                                  style: dashboardTableRowStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),

                              // Turnover
                              DataCell(
                                Text(
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
