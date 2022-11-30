import 'package:biz_alert/common/widgets/custom_app_bar.dart';
import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:biz_alert/models/response/gainer_losers_details.dart';
import 'package:biz_alert/models/response/top_brokers_res_model.dart';
import 'package:biz_alert/models/response/top_sector_res_model.dart';
import 'package:biz_alert/models/response/top_turnover_res_model.dart';
import 'package:biz_alert/providers/gainers_losers_detail_provider.dart';
import 'package:biz_alert/providers/theme_notifier_provider.dart';
import 'package:biz_alert/providers/top_brokers_provider.dart';
import 'package:biz_alert/providers/top_sector_provider.dart';
import 'package:biz_alert/providers/top_turnover_provider.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

import '../../companyDetail/screens/company_detail_screen.dart';

class MarketOverviewScreen extends StatefulWidget {
  static const String routeName = "/market-overview";
  const MarketOverviewScreen({Key? key}) : super(key: key);

  @override
  State<MarketOverviewScreen> createState() => _MarketOverviewScreenState();
}

class _MarketOverviewScreenState extends State<MarketOverviewScreen> {
  Future<AllGainersLosersDetailsResModel>? topGainersData;
  Future<AllGainersLosersDetailsResModel>? topLosersData;
  Future<TopTurnoverModel>? topTurnoverData;
  Future<TopSectorModel>? topSectorData;
  Future<TopBrokersResModel>? topBrokerData;

  @override
  void initState() {
    super.initState();

    final topGainers =
        Provider.of<AllGainersDetailProvider>(context, listen: false);
    topGainersData = topGainers.getAllGainersDetails();

    final topLosers =
        Provider.of<AllLosersDetailProvider>(context, listen: false);
    topLosersData = topLosers.getAllLosersDetails();

    final topTurnover =
        Provider.of<TopTurnoverProvider>(context, listen: false);
    topTurnoverData = topTurnover.getTopTurnoverData();

    final topSector = Provider.of<TopSectorProvider>(context, listen: false);
    topSectorData = topSector.getTopSectorData();

    final topBrokers = Provider.of<TopBrokersProvider>(context, listen: false);
    topBrokerData = topBrokers.getTopBrokersData();
  }

  @override
  Widget build(BuildContext context) {
    final topGainers =
        Provider.of<AllGainersDetailProvider>(context).gainersDetails;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // backgroundColor: GlobalVariablesColor.backgroundColor,
        appBar: PreferredSize(
          // preferredSize: const Size.fromHeight(kToolbarHeight),
          preferredSize: const Size.fromHeight(100),
          child: FutureBuilder<AllGainersLosersDetailsResModel?>(
              future: topGainersData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CustomAppBar1(
                    onPressed: () {
                      Navigator.pop(context, DashboardScreen.routeName);
                    },
                    text: "LOADING....",
                    // tabs: TabBar(
                    //   tabs: [
                    //     //Gainers
                    //     Tab(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         // width: 400.w,
                    //         // height: 45.h,
                    //         child: Text(
                    //           'Gainers',
                    //           style: TextStyle(
                    //             fontSize: 15.sp,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),

                    //     //Losers
                    //     Tab(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         // width: 140.w,
                    //         // height: 45.h,
                    //         child: Text(
                    //           'Losers',
                    //           style: TextStyle(
                    //             fontSize: 15.sp,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),

                    //     //Turnovers
                    //     Tab(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         // width: 140.w,
                    //         // height: 45.h,
                    //         child: Text(
                    //           'Turnover',
                    //           style: TextStyle(
                    //             fontSize: 15.sp,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),

                    //     //Sectors
                    //     Tab(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         // width: 140.w,
                    //         // height: 45.h,
                    //         child: Text(
                    //           'Sectors',
                    //           style: TextStyle(
                    //             fontSize: 15.sp,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),

                    //     //brokers
                    //     Tab(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         // width: 140.w,
                    //         // height: 45.h,
                    //         child: Text(
                    //           'Brokers',
                    //           style: TextStyle(
                    //             fontSize: 15.sp,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    //   indicatorSize: TabBarIndicatorSize.tab,
                    //   labelColor: Colors.white,
                    //   unselectedLabelColor: Colors.grey[700],
                    //   indicator: const BubbleTabIndicator(
                    //     indicatorHeight: 40,
                    //     // indicatorColor: Colors.blue.shade300,
                    //     indicatorColor: GlobalVariablesColor.mainColor2,
                    //     tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    //     indicatorRadius: 2,
                    //   ),
                    // ),
                  );
                } else {
                  return CustomAppBar(
                    onPressed: () {
                      Navigator.pop(context, DashboardScreen.routeName);
                    },
                    text: "Market Overview",
                    text1: topGainers!.dataCollection[0].dateTime, //Market Date
                    tabs: TabBar(
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 400.w,
                            // height: 45.h,
                            child: FittedBox(
                              child: Text(
                                'Gainers',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 140.w,
                            // height: 45.h,
                            child: FittedBox(
                              child: Text(
                                'Losers',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 140.w,
                            // height: 45.h,
                            child: FittedBox(
                              child: Text(
                                'Turnover',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 140.w,
                            // height: 45.h,
                            child: FittedBox(
                              child: Text(
                                'Sectors',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 140.w,
                            // height: 45.h,
                            child: FittedBox(
                              child: Text(
                                'Brokers',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                      // labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[700],
                      indicator: const BubbleTabIndicator(
                        indicatorHeight: 40,
                        // indicatorColor: Colors.blue.shade300,
                        indicatorColor: GlobalVariablesColor.mainColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        indicatorRadius: 2,
                      ),
                    ),
                  );
                }
              }),
        ),
        body: TabBarView(
          children: [
            gainers(),
            losers(),
            turnOver(),
            sector(),
            brokers(),
          ],
        ),
      ),
    );
  }

  // Get Header Widget
  List<Widget> _getHeaderWidget() {
    return [
      _getHeaderItemWidget('Symbol'),
      _getHeaderItemWidget('LTP'),
      _getHeaderItemWidget('CH'),
      _getHeaderItemWidget('%CH'),
      _getHeaderItemWidget('High'),
      _getHeaderItemWidget('Low'),
      _getHeaderItemWidget('Open'),
      _getHeaderItemWidget('Qty'),
      _getHeaderItemWidget('LTV'),
      _getHeaderItemWidget('TurnOver'),
    ];
  }

  List<Widget> _getBrokerHeaderWidget() {
    return [
      _getHeaderItemWidget('Broker Code'),
      _getHeaderItemWidget('Broker Name'),
      _getHeaderItemWidget('Purchased Amount'),
      _getHeaderItemWidget('Sold Amount'),
      _getHeaderItemWidget('Matching Amount'),
      _getHeaderItemWidget('Total Amount'),
      _getHeaderItemWidget('Date'),
    ];
  }

  Widget _getHeaderItemWidget(String label) {
    return Container(
      width: label == 'TurnOver' ? 90 : 75,
      height: 40,
      padding: EdgeInsets.only(left: 5.w),
      color: Colors.transparent.withAlpha(10),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: tableStyle.copyWith(
            fontSize: 15.sp,
            color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Colors.white
                : Colors.black,
          ),
          textAlign: TextAlign.center),
    );
  }

  // Top Gainers Widget
  Widget gainers() {
    final topGainers =
        Provider.of<AllGainersDetailProvider>(context).gainersDetails;

    return FutureBuilder<AllGainersLosersDetailsResModel?>(
        future: topGainersData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CustomLoader();
          } else {
            return HorizontalDataTable(
              leftHandSideColBackgroundColor: Colors.transparent,
              rightHandSideColBackgroundColor: Colors.transparent,
              leftHandSideColumnWidth: 75,
              rightHandSideColumnWidth: 690,
              isFixedHeader: true,
              headerWidgets: _getHeaderWidget(),
              rowSeparatorWidget: Divider(
                color:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.white
                        : Colors.black,
                height: 1,
                thickness: 1,
              ),
              elevation: 0.0,
              verticalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: false,
                thickness: 0.0,
              ),
              horizontalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: false,
                thickness: 0.0,
              ),
              itemCount: topGainers!.dataCollection.length,
              leftSideItemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                        arguments: topGainers.dataCollection[index].symbol);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                          : GlobalVariablesColor.mainColor.withOpacity(0.5),
                      border: const Border.symmetric(
                        vertical: BorderSide(color: Colors.white),
                      ),
                    ),
                    width: 75,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    // color: ,
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      topGainers.dataCollection[index].symbol,
                      style: tableRowStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                        arguments: topGainers.dataCollection[index].symbol);
                  },
                  child: Container(
                    color: index % 2 == 0
                        ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                        : GlobalVariablesColor.mainColor.withOpacity(0.5),
                    child: Row(
                      children: [
                        // LTP
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].ltp.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Change
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].priceChange
                                .toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // %Change
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].percentageChange
                                .toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        //  High
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].high.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Low
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].low.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Open
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].open.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Qty
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].qty.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        // LTV
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].ltv.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        // turnover
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 90,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topGainers.dataCollection[index].turnOver
                                .toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  // Top Loser Widget
  Widget losers() {
    final topLosers =
        Provider.of<AllLosersDetailProvider>(context).losersDetails;
    return FutureBuilder<AllGainersLosersDetailsResModel?>(
        future: topLosersData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return HorizontalDataTable(
              leftHandSideColBackgroundColor: Colors.transparent,
              rightHandSideColBackgroundColor: Colors.transparent,
              leftHandSideColumnWidth: 75,
              rightHandSideColumnWidth: 690,
              isFixedHeader: true,
              headerWidgets: _getHeaderWidget(),
              rowSeparatorWidget: Divider(
                color:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.white
                        : Colors.black,
                height: 1,
                thickness: 1,
              ),
              elevation: 0.0,
              verticalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: false,
                thickness: 0.0,
              ),
              horizontalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: false,
                thickness: 0.0,
              ),
              itemCount: topLosers!.dataCollection.length,
              leftSideItemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                        arguments: topLosers.dataCollection[index].symbol);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                          : GlobalVariablesColor.mainColor.withOpacity(0.5),
                      border: const Border.symmetric(
                        vertical: BorderSide(color: Colors.white),
                      ),
                    ),
                    width: 75,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      topLosers.dataCollection[index].symbol,
                      style: tableRowStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                        arguments: topLosers.dataCollection[index].symbol);
                  },
                  child: Container(
                    color: index % 2 == 0
                        ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                        : GlobalVariablesColor.mainColor.withOpacity(0.5),
                    child: Row(
                      children: [
                        // LTP
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].ltp.toString(),
                            style: tableRowStyle
                                .copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black)
                                .copyWith(fontSize: 13.sp),
                          ),
                        ),

                        // Change
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].priceChange
                                .toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // %Change
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].percentageChange
                                .toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        //  High
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].high.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Low
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].low.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Open
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].open.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // Qty
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].qty.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // LTV
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].ltv.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        // turnover
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 90,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topLosers.dataCollection[index].turnOver.toString(),
                            style: tableRowStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            //     ),
            //   ],
            // );
          }
        });
  }

  // Top TurnOver Widget
  Widget turnOver() {
    final topTurnover = Provider.of<TopTurnoverProvider>(context).topTurnover;
    return FutureBuilder<TopTurnoverModel?>(
        future: topTurnoverData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CustomLoader();
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                border: const TableBorder(
                  verticalInside: BorderSide(
                      width: 1, color: Colors.white, style: BorderStyle.solid),
                  horizontalInside: BorderSide(
                      width: 1, color: Colors.white, style: BorderStyle.solid),
                ),
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                headingRowHeight: 40,
                columnSpacing: 30,
                showBottomBorder: true,
                dataRowHeight: 50,
                columns: [
                  DataColumn(
                    label: Text(
                      'Symbol',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Turnover',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'LTP',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'TTV',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                ],
                rows: List.generate(
                  topTurnover!.dataCollection.length,
                  (index) {
                    final symbol =
                        topTurnover.dataCollection[index].stockSymbol;
                    final turnOver = topTurnover.dataCollection[index].turnover;
                    final ltp =
                        topTurnover.dataCollection[index].lastTradePrice;
                    final ttv =
                        topTurnover.dataCollection[index].totalTradedVolume;

                    return DataRow(
                      color: MaterialStateColor.resolveWith(
                        (states) => index % 2 == 0
                            ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                            : GlobalVariablesColor.mainColor.withOpacity(0.5),
                      ),
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
                            child: Text(symbol,
                                style: dashboardTableRowStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black)),
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
                            child: Text(turnOver,
                                style: dashboardTableRowStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black)),
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
                            child: Text(ltp.toString(),
                                style: dashboardTableRowStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),

                        // ttv
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CompanyDetailScreen.routeName,
                                  arguments: topTurnover
                                      .dataCollection[index].stockSymbol);
                            },
                            child: Text(ttv.toString(),
                                style: dashboardTableRowStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        });
  }

  // Top Sector Widget
  Widget sector() {
    final topSector = Provider.of<TopSectorProvider>(context).topSector;
    return FutureBuilder<TopSectorModel?>(
        future: topSectorData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                border: const TableBorder(
                  verticalInside: BorderSide(
                      width: 1, color: Colors.white, style: BorderStyle.solid),
                  horizontalInside: BorderSide(
                      width: 1, color: Colors.white, style: BorderStyle.solid),
                ),
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                headingRowHeight: 40,
                columnSpacing: 30,
                showBottomBorder: true,
                dataRowHeight: 50,
                columns: [
                  DataColumn(
                    label: Text(
                      'Sector',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Turnover',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'TTV',
                      style: dashboardTableStyle.copyWith(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                ],
                rows: List.generate(
                  topSector!.dataCollection.length,
                  (index) {
                    final sector = topSector.dataCollection[index].sectorName;
                    final turnOver = topSector.dataCollection[index].turnover;
                    final totalTradedVolume =
                        topSector.dataCollection[index].totalTradedVolume;

                    return DataRow(
                      color: MaterialStateColor.resolveWith(
                        (states) => index % 2 == 0
                            ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                            : GlobalVariablesColor.mainColor.withOpacity(0.5),
                      ),
                      cells: [
                        // Symbol
                        DataCell(
                          Text(sector,
                              style: dashboardTableRowStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black)),
                        ),

                        // Turnover
                        DataCell(
                          Text(turnOver,
                              style: dashboardTableRowStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black)),
                        ),

                        DataCell(
                          Text(totalTradedVolume.toString(),
                              style: dashboardTableRowStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        });
  }

  // Top Broker Widget
  Widget brokers() {
    final topBrokers =
        Provider.of<TopBrokersProvider>(context).topBrokersResModel;
    return FutureBuilder<TopBrokersResModel?>(
        future: topBrokerData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            return HorizontalDataTable(
              leftHandSideColBackgroundColor: Colors.transparent,
              rightHandSideColBackgroundColor: Colors.transparent,
              leftHandSideColumnWidth: 75,
              rightHandSideColumnWidth: 450,
              isFixedHeader: true,
              headerWidgets: _getBrokerHeaderWidget(),
              rowSeparatorWidget: Divider(
                color:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.white
                        : Colors.black,
                height: 1,
                thickness: 1,
              ),
              elevation: 0.0,
              verticalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: false,
                thickness: 0.0,
              ),
              horizontalScrollbarStyle: const ScrollbarStyle(
                isAlwaysShown: false,
                thickness: 0.0,
              ),
              itemCount: topBrokers!.dataCollection.length,
              leftSideItemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                    //     arguments: topBrokers.dataCollection[index].symbol);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                          : GlobalVariablesColor.mainColor.withOpacity(0.5),
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                    width: 75,
                    height: 80,
                    alignment: Alignment.centerLeft,
                    // color: ,
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      topBrokers.dataCollection[index].brokerCode,
                      style: tableRowStyle.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                        arguments: topBrokers.dataCollection[index].brokerName);
                  },
                  child: Container(
                    color: index % 2 == 0
                        ? GlobalVariablesColor.mainColor.withOpacity(0.2)
                        : GlobalVariablesColor.mainColor.withOpacity(0.5),
                    child: Row(
                      children: [
                        // Broker Name
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 80,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topBrokers.dataCollection[index].brokerName
                                .toString(),
                            style: tableRowStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),

                        // Purchase Amount
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topBrokers.dataCollection[index].purchasedAmount
                                .toString(),
                            style: tableRowStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),

                        // Sold Amount
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topBrokers.dataCollection[index].soldAmount
                                .toString(),
                            style: tableRowStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),

                        //  Matching Amount
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topBrokers.dataCollection[index].matchingAmount
                                .toString(),
                            style: tableRowStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),

                        // Total Amount
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topBrokers.dataCollection[index].totalAmount
                                .toString(),
                            style: tableRowStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),

                        // Date
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 75,
                          height: 50,
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            topBrokers.dataCollection[index].date.toString(),
                            style: tableRowStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            // return SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: DataTable(
            //     border: const TableBorder(
            //       verticalInside: BorderSide(
            //           width: 1, color: Colors.white, style: BorderStyle.solid),
            //       horizontalInside: BorderSide(
            //           width: 1, color: Colors.white, style: BorderStyle.solid),
            //     ),
            //     headingRowColor: MaterialStateColor.resolveWith(
            //         (states) => Colors.blue[300]!),
            //     headingRowHeight: 40,
            //     columnSpacing: 30,
            //     showBottomBorder: true,
            //     dataRowHeight: 50,
            //     columns: [
            //       DataColumn(
            //         label: Text(
            //           'Broker Code',
            //           style: dashboardTableStyle.copyWith(color: Provider.of<ThemeNotifier>(context).getTheme == darkTheme ? Colors.white : Colors.black),
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Broker Name',
            //           style: dashboardTableStyle,
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Purchased Amount',
            //           style: dashboardTableStyle,
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Sold Amount',
            //           style: dashboardTableStyle,
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Matching Amount',
            //           style: dashboardTableStyle,
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Total Amount',
            //           style: dashboardTableStyle,
            //         ),
            //       ),
            //     ],
            //     rows: List.generate(
            //       topBroker!.dataCollection.length,
            //       (index) {
            //         final brokerCode =
            //             topBroker.dataCollection[index].brokerCode;
            //         final brokerName =
            //             topBroker.dataCollection[index].brokerName;
            //         final soldAmount =
            //             topBroker.dataCollection[index].soldAmount;
            //         final matchingAmount =
            //             topBroker.dataCollection[index].matchingAmount;
            //         final totalAmount =
            //             topBroker.dataCollection[index].totalAmount;
            //         final purchasedAmount =
            //             topBroker.dataCollection[index].purchasedAmount;

            //         return DataRow(
            //           color: MaterialStateColor.resolveWith(
            //             (states) => index % 2 == 0
            //                 ? GlobalVariablesColor.mainColor.withOpacity(0.2)
            //                 : GlobalVariablesColor.mainColor.withOpacity(0.5),
            //           ),
            //           cells: [
            //             // Symbol
            //             DataCell(
            //               Text(brokerCode,
            //                   style: dashboardTableRowStyle.copyWith(
            //                       color: Colors.black)),
            //             ),

            //             // Turnover
            //             DataCell(
            //               Text(brokerName,
            //                   style: dashboardTableRowStyle.copyWith(
            //                       color: Colors.black)),
            //             ),

            //             DataCell(
            //               Text(purchasedAmount.toString(),
            //                   style: dashboardTableRowStyle.copyWith(
            //                       color: Colors.black)),
            //             ),
            //             DataCell(
            //               Text(soldAmount.toString(),
            //                   style: dashboardTableRowStyle.copyWith(
            //                       color: Colors.black)),
            //             ),
            //             DataCell(
            //               Text(matchingAmount.toString(),
            //                   style: dashboardTableRowStyle.copyWith(
            //                       color: Colors.black)),
            //             ),
            //             DataCell(
            //               Text(totalAmount.toString(),
            //                   style: dashboardTableRowStyle.copyWith(
            //                       color: Colors.black)),
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //   ),
            // );
          }
        });
  }
}
