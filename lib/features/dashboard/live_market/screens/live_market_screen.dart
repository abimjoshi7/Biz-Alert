import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/share_price_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/widgets/top_header.dart';
import 'package:biz_alert/models/response/live_market_trading_res_model.dart';
import 'package:biz_alert/models/response/market_summary_res_model.dart'
    as market;
import 'package:biz_alert/providers/live_market_trading_provider.dart';
import 'package:biz_alert/providers/market_summary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';

class LiveMarketScreen extends StatefulWidget {
  static const String routeName = "/live-market";
  const LiveMarketScreen({Key? key}) : super(key: key);

  @override
  State<LiveMarketScreen> createState() => _LiveMarketScreenState();
}

class _LiveMarketScreenState extends State<LiveMarketScreen> {
  Future<LiveMarketTradingModel>? liveMarketData;
  Future<market.MarketSummaryModel>? marketSummaryData;
  static const int sortSymbolDescending = 0;
  static const int sortLtpDescending = 1;
  static const int sortChangePercentDescending = 2;
  static const int sortOpenDescending = 3;
  static const int sortHighDescending = 4;
  static const int sortLowDescending = 5;
  static const int sortQtyDescending = 6;
  static const int sortPcloseDescending = 7;
  static const int sortDiffDescending = 8;
  bool isDescending = false;
  int sortType = sortSymbolDescending;

// For refresh indicator in DataTable
  final HDTRefreshController _hdtRefreshController = HDTRefreshController();

  @override
  void initState() {
    super.initState();
    final liveMarketTrading =
        Provider.of<LiveMarketTradingProvider>(context, listen: false);
    liveMarketData = liveMarketTrading.getLiveMarketTradingData();

    final marketSummary =
        Provider.of<MarketSummaryProvider>(context, listen: false);
    marketSummaryData = marketSummary.getMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Live Market",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TopHeader(
                // Live Market
                text: "Live Market",
                textColor: Colors.white,
                boxColor: GlobalVariablesColor.mainColor,
                onPressed: () {},

                // Share Price
                text1: "Share Price",
                textColor1: Colors.black,
                boxColor1: Colors.grey[350],
                onPressed1: () {
                  Navigator.popAndPushNamed(
                      context, SharePriceScreen.routeName);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const AAA()),
                  // );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              liveMarketDataList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeaderItemWidget(String label, IconData ic) {
    return Container(
        // color: GlobalVariablesColor.mainColor,
        color: Colors.transparent.withAlpha(10),
        width: 75.w,
        height: 35.h,
        padding: EdgeInsets.only(left: 5.w),
        alignment: Alignment.centerLeft,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(label,
                style: tableStyle.copyWith(
                    fontSize: 13.sp,
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black),
                textAlign: TextAlign.center),
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 3.h),
              child: Icon(
                ic,
                size: 10.h,
                color:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ],
        ));
  }

  // Live Market all Data Screen
  Widget liveMarketDataList() {
    final liveMarketTrading =
        Provider.of<LiveMarketTradingProvider>(context).liveMarket;
    final marketSummary =
        Provider.of<MarketSummaryProvider>(context).marketSummary;
    return Column(
      children: [
        // Live Market Data
        SizedBox(
          height: Dimensions.height400,
          child: FutureBuilder<LiveMarketTradingModel>(
            future: liveMarketData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(),
                );
              } else {
                return HorizontalDataTable(
                    leftHandSideColBackgroundColor: Colors.transparent,
                    rightHandSideColBackgroundColor: Colors.transparent,
                    leftHandSideColumnWidth: 75.w,
                    rightHandSideColumnWidth: 600.w,
                    isFixedHeader: true,
                    headerWidgets: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortSymbolDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child: _getHeaderItemWidget(
                              'Symbol', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortLtpDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child:
                              _getHeaderItemWidget('LTP', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortChangePercentDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child: _getHeaderItemWidget(
                              '%Change', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortOpenDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child:
                              _getHeaderItemWidget('Open', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortHighDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child:
                              _getHeaderItemWidget('High', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortLowDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child:
                              _getHeaderItemWidget('Low', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortQtyDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child:
                              _getHeaderItemWidget('Qty', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortPcloseDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child: _getHeaderItemWidget(
                              'PClose', Icons.unfold_more)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              sortType = sortDiffDescending;
                              isDescending = !isDescending;
                            });
                          },
                          child:
                              _getHeaderItemWidget('Diff', Icons.unfold_more)),
                    ],
                    rowSeparatorWidget: Divider(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                      height: 1,
                      thickness: 1,
                    ),
                    tableHeight: 400.h,
                    elevation: 0.0,
                    verticalScrollbarStyle: const ScrollbarStyle(
                      isAlwaysShown: false,
                      thickness: 0.0,
                    ),
                    horizontalScrollbarStyle: const ScrollbarStyle(
                      isAlwaysShown: false,
                      thickness: 0.0,
                    ),
                    enablePullToRefresh: true, //Refresh Indicator Start
                    refreshIndicator: const WaterDropHeader(),
                    refreshIndicatorHeight: 60,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      _hdtRefreshController.refreshCompleted();
                    },
                    loadIndicator: const ClassicFooter(),
                    enablePullToLoadNewData: true,
                    onLoad: () async {
                      //Do sth
                      await Future.delayed(const Duration(milliseconds: 500));
                      _hdtRefreshController.loadComplete();
                    },
                    htdRefreshController:
                        _hdtRefreshController, //Refresh Indicator End
                    itemCount: liveMarketTrading!.dataCollection.length,
                    // Symbol Name
                    leftSideItemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // For going to company detail page

                          Navigator.pushNamed(
                              context, CompanyDetailScreen.routeName,
                              arguments: liveMarketTrading
                                  .dataCollection[index].symbol);
                        },
                        child: StatefulBuilder(builder: ((context, setState) {
                          setState(() {
                            switch (sortType) {
                              case sortSymbolDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? b.symbol.compareTo(a.symbol)
                                        : a.symbol.compareTo(b.symbol);
                                  }),
                                );
                                break;
                              case sortLtpDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? double.parse(
                                                b.ltp.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                a.ltp.replaceAll(',', '')))
                                        : double.parse(
                                                a.ltp.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                b.ltp.replaceAll(',', '')));
                                  }),
                                );
                                break;
                              case sortChangePercentDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? double.parse(b.percentageChangePrice)
                                            .compareTo(double.parse(
                                                a.percentageChangePrice))
                                        : double.parse(a.percentageChangePrice)
                                            .compareTo(double.parse(
                                                b.percentageChangePrice));
                                  }),
                                );
                                break;
                              case sortOpenDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? double.parse(
                                                b.open.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                a.open.replaceAll(',', '')))
                                        : double.parse(
                                                a.open.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                b.open.replaceAll(',', '')));
                                  }),
                                );
                                break;
                              case sortHighDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? double.parse(
                                                b.high.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                a.high.replaceAll(',', '')))
                                        : double.parse(
                                                a.high.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                b.high.replaceAll(',', '')));
                                  }),
                                );
                                break;
                              case sortLowDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? double.parse(
                                                b.low.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                a.low.replaceAll(',', '')))
                                        : double.parse(
                                                a.low.replaceAll(',', ''))
                                            .compareTo(double.parse(
                                                b.low.replaceAll(',', '')));
                                  }),
                                );
                                break;
                              case sortQtyDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? int.parse(b.qty)
                                            .compareTo(int.parse(a.qty))
                                        : int.parse(a.qty)
                                            .compareTo(int.parse(b.qty));
                                  }),
                                );
                                break;
                              case sortPcloseDescending:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return isDescending
                                        ? double.parse(b.previousClose
                                                .replaceAll(',', ''))
                                            .compareTo(double.parse(a
                                                .previousClose
                                                .replaceAll(',', '')))
                                        : double.parse(a.previousClose
                                                .replaceAll(',', ''))
                                            .compareTo(double.parse(b
                                                .previousClose
                                                .replaceAll(',', '')));
                                  }),
                                );
                                break;
                              case sortDiffDescending:
                              // liveMarketTrading.dataCollection.sort(
                              //   ((a, b) {
                              //     return isDescending
                              //         ? b.date.compareTo(a.date)
                              //         : a.date.compareTo(b.date);
                              //   }),
                              // );
                              // break;

                              default:
                                liveMarketTrading.dataCollection.sort(
                                  ((a, b) {
                                    return a.symbol.compareTo(b.symbol);
                                  }),
                                );
                            }
                          });

                          return Container(
                            color: double.parse(liveMarketTrading
                                        .dataCollection[index]
                                        .percentageChangePrice) >
                                    0
                                ? Colors.green
                                : double.parse(liveMarketTrading
                                            .dataCollection[index]
                                            .percentageChangePrice) <
                                        0
                                    ? Colors.red
                                    : Colors.blue,
                            width: 70.w,
                            height: 35.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              liveMarketTrading.dataCollection[index].symbol,
                              style: tableRowStyle.copyWith(
                                  fontSize: 10.sp,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          );
                        })),
                      );
                    },
                    rightSideItemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // For going to company detail page
                          Navigator.pushNamed(
                              context, CompanyDetailScreen.routeName,
                              arguments: liveMarketTrading
                                  .dataCollection[index].symbol);
                        },
                        child: Container(
                          color: double.parse(liveMarketTrading
                                      .dataCollection[index]
                                      .percentageChangePrice) >
                                  0
                              ? Colors.green
                              : double.parse(liveMarketTrading
                                          .dataCollection[index]
                                          .percentageChangePrice) <
                                      0
                                  ? Colors.red
                                  : Colors.blue,
                          child: Row(
                            children: [
                              // LTP
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 75.w,
                                height: 35.h,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index].ltp,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // %Change
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index]
                                      .percentageChangePrice,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // Open
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index].open,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // High
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index].high,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // Low
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index].low,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // Qty
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index].qty,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // PClose
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading
                                      .dataCollection[index].previousClose,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              // Diff
                              Container(
                                width: 75.w,
                                height: 35.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  liveMarketTrading.dataCollection[index].open,
                                  style: tableRowStyle.copyWith(
                                      fontSize: 10.sp,
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
                    });
              }
            },
          ),
        ),

        // Market Summary
        FutureBuilder<market.MarketSummaryModel?>(
            future: marketSummaryData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 35.h,
                      color: GlobalVariablesColor.mainColor,
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Market Summary",
                              style: appbarTitleStyle,
                            ),
                          ),
                          Text(
                            "As of : ${marketSummary!.dataCollection[0].asofDate}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    marketSummaryDataList(marketSummary.dataCollection),
                  ],
                );
              }
            }),
      ],
    );
  }

  // Market Summary
  Widget marketSummaryDataList(List<market.DataCollection> dataCollection) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Total TurnOver and Transaction and Market Capitalization
        Container(
          padding: EdgeInsets.only(left: 5.w),
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                "TOTAL TURNOVER RS:",
                style: marketSummaryStyle,
              ),

              SizedBox(
                height: 5.h,
              ),

              Text(
                dataCollection[0].totalTurnover,
                style: marketSummaryStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),

              SizedBox(
                height: 15.h,
              ),
              // Line
              Container(
                color: Colors.grey,
                height: 1,
                width: MediaQuery.of(context).size.width * 0.45,
              ),

              SizedBox(
                height: 15.h,
              ),
              Text(
                "TOTAL TRANSACTIONS",
                style: marketSummaryStyle,
              ),

              SizedBox(
                height: 5.h,
              ),

              Text(
                dataCollection[0].totalTransactions,
                style: marketSummaryStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),

              SizedBox(
                height: 15.h,
              ),
              // Line
              Container(
                color: Colors.grey,
                height: 1,
                width: MediaQuery.of(context).size.width * 0.45,
              ),

              SizedBox(
                height: 15.h,
              ),

              Text(
                "TOTAL MARKET CAPITALIZATION RS:",
                style: marketSummaryStyle,
              ),

              SizedBox(
                height: 5.h,
              ),

              Text(
                dataCollection[0].totalMarketCapitalization,
                style: marketSummaryStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        // Line
        Container(
          margin: EdgeInsets.only(top: 5.h),
          color: Colors.grey,
          height: Dimensions.height180,
          width: 1,
        ),
        SizedBox(
          width: 5.w,
        ),
        //  Total Shares and Scripts and Float Market Capitalization
        Container(
          padding: EdgeInsets.only(left: 5.w),
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                "TOTAL TRADED SHARES:",
                style: marketSummaryStyle,
              ),

              SizedBox(
                height: 5.h,
              ),

              Text(
                dataCollection[0].tradeshares,
                style: marketSummaryStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),

              SizedBox(
                height: 15.h,
              ),
              // Line
              Container(
                color: Colors.grey,
                height: 1,
                width: MediaQuery.of(context).size.width * 0.45,
              ),

              SizedBox(
                height: 15.h,
              ),
              Text(
                "TOTAL SCRIPTS TRADED",
                style: marketSummaryStyle,
              ),

              SizedBox(
                height: 5.h,
              ),

              Text(
                dataCollection[0].totalScriptsTraded,
                style: marketSummaryStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),

              SizedBox(
                height: 15.h,
              ),
              // Line
              Container(
                color: Colors.grey,
                height: 1,
                width: MediaQuery.of(context).size.width * 0.45,
              ),

              SizedBox(
                height: 15.h,
              ),

              Text(
                "TOTAL FLOAT MARKET CAPITALIZATION RS:",
                style: marketSummaryStyle,
              ),

              SizedBox(
                height: 5.h,
              ),

              Text(
                dataCollection[0].floatedMarketCapitalization,
                style: marketSummaryStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
