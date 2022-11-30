import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/companyDetail/widget/detail_show.dart';
import 'package:biz_alert/models/response/company_detail_floorsheet_res_model.dart';
import 'package:biz_alert/models/response/company_detail_res.dart';
import 'package:biz_alert/models/response/stock_graph_res_model.dart';
import 'package:biz_alert/providers/company_detail_provider.dart';
import 'package:biz_alert/providers/theme_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../models/response/company_detail_price_history_res_model.dart';
import '../widget/area_graph.dart';
import '../widget/candle_graph.dart';

class CompanyDetailScreen extends StatefulWidget {
  static const String routeName = "/company-detail";
  final String companySym;
  const CompanyDetailScreen({Key? key, required this.companySym})
      : super(key: key);

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen>
    with SingleTickerProviderStateMixin {
  // Of Chart
  String doubleTime(String timer) {
    var first = timer.substring(0, timer.indexOf(':'));
    var second = timer.substring(timer.indexOf(":") + 1);
    int hour = int.parse(first);
    int min = int.parse(second);

    String output = "$hour:$min";
    return output;
  }

  String? priceHistoryDate;

  bool showArea = false;
  bool showCandle = true;

  late CompanyDetailProvider companyDetail;
  int graphPeriod = 6;

  late TooltipBehavior _tooltip;
  late List<Agm> data;
  // Calling the Api
  Future<CompanyDetailResModel?>? companyDetailData;

  Future<CompanyDetailFloorsheetResModel?>? companyDetailFloorsheetData;

  Future<CompanyDetailPriceHistoryResModel?>? companyDetailPriceHistoryData;

  Future<StockGraphResModel?>? stockGraphData;

  // Get Header Widget
  List<Widget> _getFloorsheetHeaderWidget() {
    return [
      _getHeaderItemWidget('Date'),
      _getHeaderItemWidget('Buyer'),
      _getHeaderItemWidget('Seller'),
      _getHeaderItemWidget('Qty'),
      _getHeaderItemWidget('Rate'),
      _getHeaderItemWidget('Amount'),
    ];
  }

  //get price history widget
  List<Widget> _getPriceHistoryHeaderWidget() {
    return [
      _getHeaderItemWidget('Date'),
      _getHeaderItemWidget('LTP'),
      _getHeaderItemWidget('%CH'),
      _getHeaderItemWidget('High'),
      _getHeaderItemWidget('Low'),
      _getHeaderItemWidget('Open'),
      _getHeaderItemWidget('Qty'),
      _getHeaderItemWidget('Turnover'),
    ];
  }

  Widget _getHeaderItemWidget(String label) {
    return Builder(builder: (context) {
      final width = MediaQuery.of(context).size.width;
      return Container(
        width: label == 'Turnover'
            ? 90
            : label == 'Date'
                ? width * 0.3
                : 75,
        height: 40,
        padding: EdgeInsets.only(left: 5.w),
        color: Colors.transparent.withAlpha(10),
        alignment: Alignment.centerLeft,
        child: Text(label,
            style: tableStyle.copyWith(
                fontSize: 15.sp,
                color:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.white
                        : Colors.black),
            textAlign: TextAlign.center),
      );
    });
  }

  @override
  void initState() {
    companyDetail = Provider.of<CompanyDetailProvider>(context, listen: false);
    companyDetailData = companyDetail.getCompanyDetailData(widget.companySym);
    companyDetailFloorsheetData =
        companyDetail.getCompanyDetailFloorsheetData(widget.companySym);
    companyDetailPriceHistoryData =
        companyDetail.getCompanyDetailPriceHistoryData(widget.companySym);

    stockGraphData =
        companyDetail.getStockGraph(widget.companySym, graphPeriod);

    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    companyDetailPriceHistoryData = companyDetail
        .getCompanyDetailPriceHistoryData(widget.companySym, priceHistoryDate);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final companyDetail =
        Provider.of<CompanyDetailProvider>(context).companyDetail;
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          text: "${widget.companySym} Details",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: ToggleButtons(
                        constraints:
                            const BoxConstraints(maxHeight: 25, maxWidth: 25),
                        isSelected: [showArea, showCandle],
                        onPressed: (int index) {
                          setState(() {
                            if (index == 0) {
                              showArea = !showArea;
                              showCandle = false;
                            }

                            if (index == 1) {
                              showCandle = !showCandle;
                              showArea = false;
                            }
                          });
                        },
                        children: const <Widget>[
                          Icon(Icons.area_chart_outlined),
                          Icon(Icons.candlestick_chart_outlined),
                        ],
                      ),
                    ),
                  ),
                ),
                //Candle Graph
                SliverToBoxAdapter(
                  child: CandleGraph(
                      stockGraphData: stockGraphData,
                      height: height,
                      tooltip: _tooltip,
                      isShown: showCandle),
                ),

                // Area Chart
                SliverToBoxAdapter(
                  child: AreaGraph(
                    stockGraphData: stockGraphData,
                    isShown: showArea,
                    tooltip: _tooltip,
                  ),
                ),
                //Company Detail
                SliverToBoxAdapter(
                  child: FutureBuilder<CompanyDetailResModel?>(
                    future: companyDetailData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            // Company Name
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Container(
                                // margin: const EdgeInsets.symmetric(
                                //     horizontal: 10, vertical: 10),
                                height: 50.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: GlobalVariablesColor.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    companyDetail!.dataCollection
                                        .companyDetail[0].companyName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            // Table with Company Detail
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Last Traded Price",
                                      style: companyDetailStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                        companyDetail.dataCollection
                                            .companyDetail[0].ltp,
                                        style: companyDetailStyle1.copyWith(
                                            fontSize: 11,
                                            color: companyDetail
                                                        .dataCollection
                                                        .companyDetail[0]
                                                        .percentageChange
                                                        .startsWith("-") ==
                                                    true
                                                ? Colors.red
                                                : Colors.green)
                                        //  TextStyle(
                                        //     fontSize: 14.sp,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: ),
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            DetailShow(
                              text: "Last Traded On",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].lastTradeOn,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Percentage Change",
                                      style: companyDetailStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      companyDetail.dataCollection
                                          .companyDetail[0].percentageChange,
                                      style: companyDetailStyle1.copyWith(
                                          fontSize: 11,
                                          color: companyDetail
                                                      .dataCollection
                                                      .companyDetail[0]
                                                      .percentageChange
                                                      .startsWith("-") ==
                                                  true
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            DetailShow(
                              text: "52 Weeks High/Low",
                              value: companyDetail.dataCollection
                                  .companyDetail[0].fifityTwoWeeksHighLow,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Day Average",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].dayAverage,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "One Year Yield",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].oneYearYield,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "EPS",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].eps,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "PE Ratio",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].peRatio,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Bonus",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].bonus,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Market Capitalization",
                              value: companyDetail.dataCollection
                                  .companyDetail[0].marketCapitalization,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Book Value",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].bv,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Previous Book Value",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].pbv,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Average Volume",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].avgVol,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Shares Outsanding",
                              value: companyDetail.dataCollection
                                  .companyDetail[0].sharesOutstanding,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "120 Days",
                              value: companyDetail.dataCollection
                                  .companyDetail[0].oneHundredTwentyDays,
                              color: GlobalVariablesColor.mainColor1
                                  .withOpacity(0.5),
                            ),
                            DetailShow(
                              text: "Sector",
                              value: companyDetail
                                  .dataCollection.companyDetail[0].sector,
                              color: GlobalVariablesColor.mainColor2
                                  .withOpacity(0.5),
                            ),

                            // Bonus
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    elevation: 2.0,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 400,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "SN",
                                                    style: companyDetailStyle,
                                                  ),
                                                  Text(
                                                    "Fiscal Year",
                                                    style: companyDetailStyle,
                                                  ),
                                                  Text(
                                                    "Percent",
                                                    style: companyDetailStyle,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                child: companyDetail
                                                        .dataCollection
                                                        .bonus
                                                        .isEmpty
                                                    ? Center(
                                                        child: Text(
                                                          "No any data!!!",
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : ListView.separated(
                                                        separatorBuilder:
                                                            ((context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Container(
                                                              height: 1,
                                                              color:
                                                                  GlobalVariablesColor
                                                                      .mainColor,
                                                            ),
                                                          );
                                                        }),
                                                        itemCount: companyDetail
                                                            .dataCollection
                                                            .bonus
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  companyDetail
                                                                      .dataCollection
                                                                      .bonus[
                                                                          index]
                                                                      .sNo,
                                                                  style:
                                                                      companyDetailStyle1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  companyDetail
                                                                      .dataCollection
                                                                      .bonus[
                                                                          index]
                                                                      .fiscalYear,
                                                                  style:
                                                                      companyDetailStyle1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  "${companyDetail.dataCollection.bonus[index].bonusSharePercent} %",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style:
                                                                      companyDetailStyle1,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: const DetailShow(
                                text: "Bonus",
                                value: "",
                                color: GlobalVariablesColor.mainColor,
                              ),
                            ),

                            //  Right Share
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    elevation: 2.0,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 400,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "SN",
                                                    style: companyDetailStyle,
                                                  ),
                                                  Text(
                                                    "Fiscal Year",
                                                    style: companyDetailStyle,
                                                  ),
                                                  Text(
                                                    "Right Percent",
                                                    style: companyDetailStyle,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                  child: companyDetail
                                                          .dataCollection
                                                          .right
                                                          .isEmpty
                                                      ? Center(
                                                          child: Text(
                                                            "No any data!!!",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : ListView.separated(
                                                          separatorBuilder:
                                                              ((context,
                                                                  index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5),
                                                              child: Container(
                                                                height: 1,
                                                                color: GlobalVariablesColor
                                                                    .mainColor,
                                                              ),
                                                            );
                                                          }),
                                                          itemCount:
                                                              companyDetail
                                                                  .dataCollection
                                                                  .right
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    companyDetail
                                                                        .dataCollection
                                                                        .right[
                                                                            index]
                                                                        .sNo,
                                                                    style:
                                                                        companyDetailStyle1,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    companyDetail
                                                                        .dataCollection
                                                                        .right[
                                                                            index]
                                                                        .fiscalYear,
                                                                    style:
                                                                        companyDetailStyle1,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    "${companyDetail.dataCollection.right[index].bonusSharePercent} %",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        companyDetailStyle1,
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: DetailShow(
                                text: "RightShare",
                                value: "",
                                color: GlobalVariablesColor.mainColor
                                    .withOpacity(0.5),
                              ),
                            ),

                            // Dividend
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    elevation: 2.0,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 400,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "SN",
                                                    style: companyDetailStyle,
                                                  ),
                                                  Text(
                                                    "Fiscal Year",
                                                    style: companyDetailStyle,
                                                  ),
                                                  Text(
                                                    "Dividend Percent",
                                                    style: companyDetailStyle,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                  child: companyDetail
                                                          .dataCollection
                                                          .divident
                                                          .isEmpty
                                                      ? Center(
                                                          child: Text(
                                                            "No any data!!!",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : ListView.separated(
                                                          separatorBuilder:
                                                              ((context,
                                                                  index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5),
                                                              child: Container(
                                                                height: 1,
                                                                color: GlobalVariablesColor
                                                                    .mainColor,
                                                              ),
                                                            );
                                                          }),
                                                          itemCount:
                                                              companyDetail
                                                                  .dataCollection
                                                                  .divident
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    companyDetail
                                                                        .dataCollection
                                                                        .divident[
                                                                            index]
                                                                        .sNo,
                                                                    style:
                                                                        companyDetailStyle1,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    companyDetail
                                                                        .dataCollection
                                                                        .divident[
                                                                            index]
                                                                        .fiscalYear,
                                                                    style:
                                                                        companyDetailStyle1,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    "${companyDetail.dataCollection.divident[index].cashDividendPercent} %",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        companyDetailStyle1,
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: DetailShow(
                                text: "Dividend",
                                value: "",
                                color: GlobalVariablesColor.mainColor
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(tabs: [
                  Tab(
                    child: Text(
                      "Floorsheet",
                      style: TextStyle(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Price History",
                      style: TextStyle(
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                ]),
                Expanded(
                  child: TabBarView(children: [
                    FutureBuilder<CompanyDetailFloorsheetResModel?>(
                      future: companyDetailFloorsheetData,
                      builder: (_, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data?.status == "Success") {
                          return HorizontalDataTable(
                            onScrollControllerReady:
                                (verticalController, horizontalController) {},
                            leftHandSideColBackgroundColor: Colors.transparent,
                            rightHandSideColBackgroundColor: Colors.transparent,
                            leftHandSideColumnWidth: width * 0.3,
                            rightHandSideColumnWidth: 375,
                            isFixedHeader: true,
                            headerWidgets: _getFloorsheetHeaderWidget(),
                            rowSeparatorWidget: Divider(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
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
                            itemCount: snapshot.data!.dataCollection.length,
                            leftSideItemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                                  //     arguments: topGainers.dataCollection[index].symbol);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? GlobalVariablesColor.mainColor
                                            .withOpacity(0.2)
                                        : GlobalVariablesColor.mainColor
                                            .withOpacity(0.5),
                                    border: Border.symmetric(
                                      vertical: BorderSide(
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                  width: 95,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    snapshot.data!.dataCollection[index]
                                        .floorsheetDate,
                                    style: tableRowStyle.copyWith(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                            rightSideItemBuilder:
                                (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                                  //     arguments: topGainers.dataCollection[index].symbol);
                                },
                                child: Container(
                                  color: index % 2 == 0
                                      ? GlobalVariablesColor.mainColor
                                          .withOpacity(0.2)
                                      : GlobalVariablesColor.mainColor
                                          .withOpacity(0.5),
                                  child: Row(
                                    children: [
                                      // Buyer Broker
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 75,
                                        height: 50,
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Text(
                                          snapshot.data!.dataCollection[index]
                                              .buyerBrokerCode
                                              .toString(),
                                          style: tableRowStyle.copyWith(
                                            color: Provider.of<ThemeNotifier>(
                                                            context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),

                                      // Seller Broker
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 75,
                                        height: 50,
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Text(
                                          snapshot.data!.dataCollection[index]
                                              .sellerBrokerCode
                                              .toString(),
                                          style: tableRowStyle.copyWith(
                                            color: Provider.of<ThemeNotifier>(
                                                            context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),

                                      // Quantity
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 75,
                                        height: 50,
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: Text(
                                          snapshot.data!.dataCollection[index]
                                              .quantity
                                              .toString(),
                                          style: tableRowStyle.copyWith(
                                            color: Provider.of<ThemeNotifier>(
                                                            context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),

                                      //  Amount
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 75,
                                        height: 50,
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(
                                          snapshot
                                              .data!.dataCollection[index].rate
                                              .toString(),
                                          style: tableRowStyle.copyWith(
                                            color: Provider.of<ThemeNotifier>(
                                                            context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 75,
                                        height: 50,
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(
                                          snapshot.data!.dataCollection[index]
                                              .amount
                                              .toString(),
                                          style: tableRowStyle.copyWith(
                                            color: Provider.of<ThemeNotifier>(
                                                            context)
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
                        }
                        return const CustomLoader();
                      },
                    ),
                    FutureBuilder<CompanyDetailPriceHistoryResModel?>(
                        future: companyDetailPriceHistoryData,
                        builder: (_, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data?.status == "Success") {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () async {
                                    final dateTime1 = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2019),
                                        lastDate: DateTime.now());
                                    setState(() {
                                      priceHistoryDate =
                                          DateFormat("yMd").format(dateTime1!);
                                    });
                                  },
                                  leading: const Icon(Icons.calendar_month),
                                  title: const Text(
                                    "Pick a date to filter data",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: HorizontalDataTable(
                                    leftHandSideColBackgroundColor:
                                        Colors.transparent,
                                    rightHandSideColBackgroundColor:
                                        Colors.transparent,
                                    leftHandSideColumnWidth: width * 0.3,
                                    rightHandSideColumnWidth: 540,
                                    isFixedHeader: true,
                                    headerWidgets:
                                        _getPriceHistoryHeaderWidget(),
                                    rowSeparatorWidget: Divider(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      height: 1,
                                      thickness: 1,
                                    ),
                                    elevation: 0.0,
                                    verticalScrollbarStyle:
                                        const ScrollbarStyle(
                                      isAlwaysShown: false,
                                      thickness: 0.0,
                                    ),
                                    horizontalScrollbarStyle:
                                        const ScrollbarStyle(
                                      isAlwaysShown: false,
                                      thickness: 0.0,
                                    ),
                                    itemCount:
                                        snapshot.data!.dataCollection.length,
                                    leftSideItemBuilder:
                                        (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                                          //     arguments: topGainers.dataCollection[index].symbol);
                                        },
                                        child: Container(
                                          width: width * 0.3,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? GlobalVariablesColor.mainColor
                                                    .withOpacity(0.2)
                                                : GlobalVariablesColor.mainColor
                                                    .withOpacity(0.5),
                                            border: Border.symmetric(
                                              vertical: BorderSide(
                                                color:
                                                    Provider.of<ThemeNotifier>(
                                                                    context)
                                                                .getTheme() ==
                                                            darkTheme
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            snapshot.data!.dataCollection[index]
                                                .dateTime,
                                            style: tableRowStyle.copyWith(
                                              color: Provider.of<ThemeNotifier>(
                                                              context)
                                                          .getTheme() ==
                                                      darkTheme
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    rightSideItemBuilder:
                                        (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                                          //     arguments: topGainers.dataCollection[index].symbol);
                                        },
                                        child: Container(
                                          color: index % 2 == 0
                                              ? GlobalVariablesColor.mainColor
                                                  .withOpacity(0.2)
                                              : GlobalVariablesColor.mainColor
                                                  .withOpacity(0.5),
                                          child: Row(
                                            children: [
                                              // LTP
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot.data!
                                                      .dataCollection[index].ltp
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
                                                                    .getTheme() ==
                                                                darkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),

                                              // %Change
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .dataCollection[index]
                                                      .percentageChange
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
                                                                    .getTheme() ==
                                                                darkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),

                                              // high
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .dataCollection[index]
                                                      .high
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
                                                                    .getTheme() ==
                                                                darkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),

                                              //  low
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot.data!
                                                      .dataCollection[index].low
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
                                                                    .getTheme() ==
                                                                darkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),

                                              //open
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .dataCollection[index]
                                                      .open
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
                                                                    .getTheme() ==
                                                                darkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),

                                              //quantity
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot.data!
                                                      .dataCollection[index].qty
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
                                                                    .getTheme() ==
                                                                darkTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),

                                              //turnover
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 90,
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .dataCollection[index]
                                                      .turnover
                                                      .toString(),
                                                  style: tableRowStyle.copyWith(
                                                    color:
                                                        Provider.of<ThemeNotifier>(
                                                                        context)
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
                                  ),
                                ),
                              ],
                            );
                          }
                          return const CustomLoader();
                        }),
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
