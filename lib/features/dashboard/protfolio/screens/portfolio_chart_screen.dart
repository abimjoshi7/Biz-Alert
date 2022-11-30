import 'package:biz_alert/common/widgets/custom_app_bar.dart';
import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/add_portfolio_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/add_stock_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/delete_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/sell_stock_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/features/payment/screen/portfolio_pay.dart';
import 'package:biz_alert/models/response/dashboard_res_model.dart';
import 'package:biz_alert/models/response/get_portfolio_res_model.dart';
import 'package:biz_alert/models/response/get_shareholder_res.dart';
import 'package:biz_alert/models/response/portfolio_chart_res_model.dart';
import 'package:biz_alert/providers/dashboard_provider.dart';
import 'package:biz_alert/providers/get_portfolio_provider.dart';
import 'package:biz_alert/providers/get_shareholder_provider.dart';
import 'package:biz_alert/providers/portfolio_chart_provider.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';

class PortfolioChartScreen extends StatefulWidget {
  static const String routeName = "/portfolio-chart";
  const PortfolioChartScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioChartScreen> createState() => _PortfolioChartScreenState();
}

class _PortfolioChartScreenState extends State<PortfolioChartScreen> {
  Future<PortfolioChartResponseModel>? portfolioChartData;
  // For getting the portfolio and shareholder ID
  Future<GetPortfolioResponseModel>? portfolioIDData;
  Future<GetShareHolderResponseModel>? shareHolderIDData;
  Future<DashboardModel>? dashboardData;

  // For the chart
  final colorList = <Color>[
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.white,
    Colors.cyanAccent,
    Colors.black,
    Colors.deepOrange,
    Colors.pinkAccent,
    Colors.tealAccent,
    Colors.red,
    Colors.amberAccent,
    Colors.green,
    Colors.lightBlueAccent,
    Colors.deepPurpleAccent,
    Colors.limeAccent,
    Colors.amber,
    Colors.red.shade800,
    Colors.orange.shade800
  ];

  @override
  void initState() {
    super.initState();
    final portfolioChart =
        Provider.of<PortfolioChartProvider>(context, listen: false);
    portfolioChartData = portfolioChart.getPortofolioChartData();

    final portofolioId = Provider.of<PortfolioProvider>(context, listen: false);
    portfolioIDData = portofolioId.getPortfolio();

    final shareHolderId =
        Provider.of<ShareHolderProvider>(context, listen: false);
    shareHolderIDData = shareHolderId.getShareHolder();

    final dashboard = Provider.of<DashboardProvider>(context, listen: false);
    dashboardData = dashboard.getDashboardData();
  }

  // Calling Firebase messaging
  void main() async {
    await FirebaseMessaging.instance.subscribeToTopic("stockAlert");
  }

  // For the refresh Indicator
  final GlobalKey<RefreshIndicatorState> refreshIndicatorStatePortfolio =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorStateSummary =
      GlobalKey<RefreshIndicatorState>();
  Future<PortfolioChartResponseModel?> refreshPortfolioChartScreen(
      BuildContext context) async {
    final res = await DioPortfolioChart().viewPortfolioChart();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final portfolioChart =
        Provider.of<PortfolioChartProvider>(context).portfolioChart;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: GlobalVariablesColor.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: FutureBuilder<PortfolioChartResponseModel?>(
              future: portfolioChartData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CustomAppBar1(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Biz Portfolio",
                    // Search Icon
                    icon1: Icons.search,
                    onPressed1: () async {
                      await showSearch(
                          context: context,
                          // delegate to customize the search bar
                          delegate: CustomSearchDelegate());
                    },
                    // Add Icon
                    icon2: Icons.add,
                    onPressed2: () {
                      Navigator.pushNamed(
                          context, AddPortfolioScreen.routeName);
                    },
                    tabs: TabBar(
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 400.w,
                            // height: 45.h,
                            child: Text(
                              'Portfolio Overview',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 140.w,
                            // height: 45.h,
                            child: Text(
                              'Summary',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
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
                        indicatorColor: GlobalVariablesColor.mainColor2,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        indicatorRadius: 2,
                      ),
                    ),
                  );
                } else {
                  return CustomAppBar(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Biz Protfolio",
                    text1: portfolioChart!.dataCollection!.data!
                        .portfolioSummary!.marketDate!, //Market Date
                    // Search Icon
                    icon1: Icons.search,
                    onPressed1: () async {
                      await showSearch(
                          context: context,
                          // delegate to customize the search bar
                          delegate: CustomSearchDelegate());
                    },
                    // Add Icon
                    icon2: Icons.add,
                    onPressed2: () {
                      Navigator.pushNamed(
                          context, AddPortfolioScreen.routeName);
                    },
                    tabs: TabBar(
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 400.w,
                            // height: 45.h,
                            child: Text(
                              'Portfolio Overview',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // width: 140.w,
                            // height: 45.h,
                            child: Text(
                              'Summary',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
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
            portfolioScreen(),
            chartsSummaryScreen(),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Portfolio Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Visibility(
                visible: false,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    heroTag: const Text("btn1"),
                    label: const Text(
                      "SB Maharjan",
                      style: TextStyle(fontSize: 15),
                    ),
                    backgroundColor: GlobalVariablesColor.mainColor,
                  ),
                ),
              ),
            ),
            // Add Stock
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0.5, 0.5),
                    ),
                  ],
                ),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, AddStockScreen.routeName);
                  },
                  heroTag: const Text("btn2"),
                  label: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 25,
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        'Add Stock',
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              Provider.of<ThemeNotifier>(context).getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: GlobalVariablesColor.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Portfolio Page in Tabbar
  portfolioScreen() {
    final portfolioChart =
        Provider.of<PortfolioChartProvider>(context).portfolioChart;
    final dashboard = Provider.of<DashboardProvider>(context).dashboard;

    return Padding(
      padding: EdgeInsets.all(5.w),
      child: RefreshIndicator(
        key: refreshIndicatorStatePortfolio,
        onRefresh: () => refreshPortfolioChartScreen(context),
        child: FutureBuilder<PortfolioChartResponseModel?>(
          future: portfolioChartData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CustomLoader();
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    // No Stock Added
                    portfolioChart!.dataCollection!.message ==
                            "Cannot cast DBNull.Value to type 'System.DateTime'. Please use a nullable type."
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                                  Center(
                                    child: Text(
                                      "No Stocks Added",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : portfolioChart.dataCollection!.message ==
                                "One or more data missing"
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                      ),
                                      Center(
                                        child: Text(
                                          "No Stocks Added",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.only(bottom: 70),
                                  child: Column(
                                    children: [
                                      // Renew Container
                                      FutureBuilder<DashboardModel?>(
                                          future: dashboardData,
                                          builder: (context, snapshot) {
                                            return Visibility(
                                              visible: dashboard!
                                                          .dataCollection
                                                          .data
                                                          .disableServies
                                                          .ncellPayment ==
                                                      false
                                                  ? false
                                                  : true,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff44C2FD),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            GlobalVariablesColor
                                                                .mainColor1)),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // As of Market Date
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "As of : ${portfolioChart.dataCollection!.data!.portfolioSummary!.marketDate!}",
                                                              style: portfolioblackStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.sp),
                                                            ),
                                                          ),
                                                          // Expiry Date
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Expiry Date : ${portfolioChart.dataCollection!.data!.portfolioSummary!.portfolioExpiryDate}",
                                                              style: portfolioblackStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Renew Button
                                                      Center(
                                                        child: SizedBox(
                                                          width: 150,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  PortfolioPayment
                                                                      .routeName);
                                                            },
                                                            style:
                                                                styleMainButton,
                                                            child: Text(
                                                              "Renew",
                                                              style: portfolioWhiteStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          20.sp),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          }),
                                      Divider(
                                        thickness: 0,
                                        color: Colors.white,
                                        height: 10.h,
                                      ),
                                      // Summary Container
                                      summaryCont(portfolioChart.dataCollection!
                                          .data!.portfolioSummary!),
                                      Divider(
                                        thickness: 0,
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                        height: 10.h,
                                      ),
                                      // Portfolio Container
                                      portfolioData(portfolioChart
                                          .dataCollection!
                                          .data!
                                          .sectorHoldings!),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Portfolio Overview Summary Container
  summaryCont(PortfolioSummary portfolioSummary) {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
        // color: GlobalVariablesColor.mainColor,
        border: Border.all(
          color: GlobalVariablesColor.mainColor1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // First Row
          // Summary
          Text(
            "Summary",
            style: portfolioWhiteStyle.copyWith(
              fontSize: 25.sp,
              color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          // Line
          Divider(
            thickness: 1,
            color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Colors.white
                : Colors.black,
          ),
          // Second Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Units
                  Text(
                    "Current Units",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Current Units",
                    style: portfolioGreyStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // Current Value
                  Text(
                    "Current Value",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    portfolioSummary.networth!,
                    style: portfolioGreyStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Estimated Loss or Estimated Gain
                  Text(
                    "Estimated Loss",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    portfolioSummary.overallGain!,
                    style: portfolioGreyStyle,
                  ),
                ],
              ),
              // Second Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sold Units
                  Text(
                    "Sold Units",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "0",
                    style: portfolioGreyStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Sold Value
                  Text(
                    "Sold Value",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Rs 0",
                    style: portfolioGreyStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Loss or Profit Percent
                  Text(
                    "Loss Per.",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Rs 0",
                    style: portfolioGreyStyle,
                  ),
                ],
              ),
              // Third Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Investement
                  Text(
                    "Investement",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    portfolioSummary.invertment!,
                    style: portfolioGreyStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Dividend
                  Text(
                    "Dividend",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "0",
                    style: portfolioGreyStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Today's Gain
                  Text(
                    "Today's Gain",
                    style: portfolioblackStyle.copyWith(
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    portfolioSummary.daysGain!,
                    style: portfolioGreyStyle,
                  ),
                ],
              ),
            ],
          ),
          // Line
          Divider(
            thickness: 1,
            color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Colors.white
                : Colors.black,
          ),
          // Third Row
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              // Receivable Amount
              RichText(
                text: TextSpan(
                  text: "Receivable Amount: ",
                  style: portfolioWhiteStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Rs -35",
                      style: portfolioWhiteStyle.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              // Profit or Loss
              RichText(
                text: TextSpan(
                  text: "Loss: ",
                  style: portfolioWhiteStyle.copyWith(
                    color: Provider.of<ThemeNotifier>(context).getTheme() ==
                            darkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "100%",
                      style: portfolioWhiteStyle.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // After Stock Added
  portfolioData(List<SectorHoldings> sectorHoldings) {
    final portfolioId =
        Provider.of<PortfolioProvider>(context).getPortfolioModel;
    final shareHolderId =
        Provider.of<ShareHolderProvider>(context).getShareHolderModel;
    List<Widget> list = <Widget>[];
    for (var i = 0; i < sectorHoldings.length; i++) {
      List<PortfolioHoldings> portfolioHolding =
          sectorHoldings[i].portfolioHoldings!;
      for (var j = 0; j < portfolioHolding.length; j++) {
        list.add(
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(5.h),
                // height: 250.w,
                decoration: BoxDecoration(
                  // color: GlobalVariablesColor.mainColor,
                  border: Border.all(
                    color: GlobalVariablesColor.mainColor1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                        arguments: portfolioHolding[j].symbol!);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // First Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Symbol Name
                          Text(
                            portfolioHolding[j].symbol!,
                            style: portfolioWhiteStyle.copyWith(
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          // LTP
                          RichText(
                            text: TextSpan(
                              text: "LTP: ",
                              style: portfolioWhiteStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: portfolioHolding[j].price,
                                  style: portfolioWhiteStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // CH
                          RichText(
                            text: TextSpan(
                              text: "CH: ",
                              style: portfolioWhiteStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: portfolioHolding[j].changeInPrice,
                                  style: portfolioWhiteStyle.copyWith(
                                      color: double.parse(portfolioHolding[j]
                                                  .changeInPrice!) >
                                              0
                                          ? Colors.green[800]
                                          : double.parse(portfolioHolding[j]
                                                      .changeInPrice!) <
                                                  0
                                              ? Colors.red[800]
                                              : Colors.blue[800]),
                                ),
                              ],
                            ),
                          ),
                          // Percent
                          Text(
                            sectorHoldings[i]
                                .portfolioHoldings![j]
                                .changeInPercentage!,
                            style: portfolioWhiteStyle.copyWith(
                                color: double.parse(portfolioHolding[j]
                                            .changeInPrice!) >
                                        0
                                    ? Colors.green[800]
                                    : double.parse(portfolioHolding[j]
                                                .changeInPrice!) <
                                            0
                                        ? Colors.red[800]
                                        : Colors.blue[800]),
                          ),
                          // Money Icon
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, SellStockScreen.routeName,
                                  arguments: [
                                    portfolioHolding[j].symbol!,
                                    portfolioHolding[j].companyID
                                  ]);
                            },
                            child: Icon(
                              Icons.attach_money,
                              size: 25.h,
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          // Delete Icon
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, DeletePortfolioScreen.routeName,
                                  arguments: [
                                    portfolioId!.dataCollection[0].portfolioId
                                        .toString(),
                                    shareHolderId!
                                        .dataCollection[0].shareholderId
                                        .toString(),
                                    portfolioHolding[j].companyID,
                                  ]);
                            },
                            child: Icon(
                              Icons.delete,
                              size: 25.h,
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                      // Line
                      Divider(
                        thickness: 1,
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      // Second Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Current Units
                              Text(
                                "Current Units",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                portfolioHolding[j].quantity!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // WACC
                              Text(
                                "WACC",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                portfolioHolding[j].rate!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Current Value
                              Text(
                                "Current Value",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                portfolioHolding[j].marketValue!,
                                style: portfolioGreyStyle,
                              ),
                            ],
                          ),
                          // Second Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sold Units
                              Text(
                                "Sold Units",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "0",
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Sold Value
                              Text(
                                "Sold Value",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "Rs 0",
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Dividend
                              Text(
                                "Dividend",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "Rs 0",
                                style: portfolioGreyStyle,
                              ),
                            ],
                          ),
                          // Third Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Investement
                              Text(
                                "Investement",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                portfolioHolding[j].investment!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Estimated Loss
                              Text(
                                "Estimated Loss",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                portfolioHolding[j].overall!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Today's Gain
                              Text(
                                "Today's Gain",
                                style: portfolioblackStyle.copyWith(
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                portfolioHolding[j].day!,
                                style: portfolioGreyStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Line
                      Divider(
                        thickness: 1,
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      // Third Row
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          // Receivable Amount
                          RichText(
                            text: TextSpan(
                              text: "Receivable Amount: ",
                              style: portfolioWhiteStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Rs -35",
                                  style: portfolioWhiteStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          // Profit or Loss
                          RichText(
                            text: TextSpan(
                              text: "Loss: ",
                              style: portfolioWhiteStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "100%",
                                  style: portfolioWhiteStyle.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 0,
                color:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.white
                        : Colors.black,
                height: 10.h,
              ),
            ],
          ),
        );
      }
    }
    return Column(children: list);
  }

  // Chart Page in Tabbar
  chartsSummaryScreen() {
    final portfolioChart =
        Provider.of<PortfolioChartProvider>(context).portfolioChart;
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: RefreshIndicator(
        key: refreshIndicatorStateSummary,
        onRefresh: () => refreshPortfolioChartScreen(context),
        child: FutureBuilder<PortfolioChartResponseModel?>(
          future: portfolioChartData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CustomLoader();
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    portfolioChart!.dataCollection!.message ==
                            "Cannot cast DBNull.Value to type 'System.DateTime'. Please use a nullable type."
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                                  Center(
                                    child: Text(
                                      "No Stocks Added",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : portfolioChart.dataCollection!.message ==
                                "One or more data missing"
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                      ),
                                      Center(
                                        child: Text(
                                          "No Stocks Added",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(
                                padding: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                  // color: GlobalVariablesColor.mainColor,
                                  border: Border.all(
                                    color: GlobalVariablesColor.mainColor1,
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.only(bottom: 70),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      // Current Investment Distribution
                                      Text(
                                        "Current Investment Distribution",
                                        style: portfolioWhiteStyle.copyWith(
                                          fontSize: 25.sp,
                                          color: Provider.of<ThemeNotifier>(
                                                          context)
                                                      .getTheme() ==
                                                  darkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),

                                      // Line
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      // Pie Charts Circle
                                      SizedBox(
                                        height: 350,
                                        // flex: 8,
                                        child: chartDistribution(portfolioChart
                                            .dataCollection!
                                            .data!
                                            .investmentChart!),
                                      ),

                                      const SizedBox(
                                        height: 50,
                                      ),

                                      // Pie Chart Data List
                                      SizedBox(
                                        height: 50,
                                        child: chartDataList(portfolioChart
                                            .dataCollection!
                                            .data!
                                            .investmentChart!),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // After Stock Added to show the pie chart circle
  chartDistribution(List<InvestmentChart> investmentChart) {
    // For Pie Chart
    Map<String, double> dataMap = {};
    for (var element in investmentChart) {
      dataMap[element.sectorName!] = element.investment!;
    }
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing:
          48, //Space between chart and legend -- also the size of chart if chart radius is not defined
      chartRadius: MediaQuery.of(context).size.width / 1.4,
      colorList: colorList, //Color List for Pie Chart
      initialAngleInDegree: 0,
      chartType: ChartType.disc, //Type of chart
      // ringStrokeWidth: 32, // For Ring
      legendOptions: const LegendOptions(showLegends: false),
      chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: false,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: true,
          decimalPlaces: 1,
          chartValueStyle: portfolioGreyStyle),
    );
  }

  // Pie chart data list
  chartDataList(List<InvestmentChart> investmentChart) {
    double total = 0.0;
    for (var element in investmentChart) {
      total = total + element.investment!;
    }

    return ListView.separated(
        itemCount: investmentChart.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50.r)),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: colorList[index],
                      borderRadius: BorderRadius.circular(50.r)),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  investmentChart[index].sectorName!,
                  style: TextStyle(color: colorList[index]),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '${(investmentChart[index].investment! * 100 / total).toStringAsFixed(1)} %',
                  style: TextStyle(color: colorList[index]),
                ),
              ],
            ),
          );
        });
  }
}

// For the implementation of search bar in portfolio using SearchDelegate
class CustomSearchDelegate extends SearchDelegate {
  // For Changing the design of a search bar in Search Delegate
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        color: GlobalVariablesColor.mainColor,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.none,
            color: Colors.white), // query Color
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
        border: InputBorder.none,
      ),
    );
  }

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? close(context, null) : query = '';
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back, color: Colors.white),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return portfolioSearch(context);
  }

  //  For the searching result
  portfolioSearch(context) {
    final portfolioChart =
        Provider.of<PortfolioChartProvider>(context).portfolioChart;
    final portfolioId =
        Provider.of<PortfolioProvider>(context).getPortfolioModel;
    final shareHolderId =
        Provider.of<ShareHolderProvider>(context).getShareHolderModel;
    List<Widget> list = <Widget>[];
    for (var i = 0;
        i < portfolioChart!.dataCollection!.data!.sectorHoldings!.length;
        i++) {
      List<PortfolioHoldings> portfolioHolding = portfolioChart
          .dataCollection!.data!.sectorHoldings![i].portfolioHoldings!;
      for (var element in portfolioHolding) {
        if (element.symbol!.toLowerCase().contains(query.toLowerCase())) {
          list.add(
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(5.h),
                  // height: 250.w,
                  decoration: BoxDecoration(
                    color: GlobalVariablesColor.mainColor,
                    border: Border.all(
                      color: GlobalVariablesColor.mainColor1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // First Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Symbol Name
                          Text(
                            element.symbol!,
                            style: portfolioWhiteStyle,
                          ),
                          // LTP
                          RichText(
                            text: TextSpan(
                              text: "LTP: ",
                              style: portfolioWhiteStyle,
                              children: [
                                TextSpan(
                                  text: element.price,
                                  style: portfolioWhiteStyle.copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // CH
                          RichText(
                            text: TextSpan(
                              text: "CH: ",
                              style: portfolioWhiteStyle,
                              children: [
                                TextSpan(
                                  text: element.changeInPrice,
                                  style: portfolioWhiteStyle.copyWith(
                                      color: double.parse(
                                                  element.changeInPrice!) >
                                              0
                                          ? Colors.green[800]
                                          : double.parse(
                                                      element.changeInPrice!) <
                                                  0
                                              ? Colors.red[800]
                                              : Colors.blue[800]),
                                ),
                              ],
                            ),
                          ),
                          // Percent
                          Text(
                            element.changeInPercentage!,
                            style: portfolioWhiteStyle.copyWith(
                                color: double.parse(element.changeInPrice!) > 0
                                    ? Colors.green[800]
                                    : double.parse(element.changeInPrice!) < 0
                                        ? Colors.red[800]
                                        : Colors.blue[800]),
                          ),
                          // Money Icon
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, SellStockScreen.routeName,
                                  arguments: [
                                    element.symbol!,
                                    element.companyID
                                  ]);
                            },
                            child: Icon(
                              Icons.attach_money,
                              size: 25.h,
                              color: Colors.white,
                            ),
                          ),
                          // Delete Icon
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, DeletePortfolioScreen.routeName,
                                  arguments: [
                                    portfolioId!.dataCollection[0].portfolioId
                                        .toString(),
                                    shareHolderId!
                                        .dataCollection[0].shareholderId
                                        .toString(),
                                    element.companyID,
                                  ]);
                            },
                            child: Icon(
                              Icons.delete,
                              size: 25.h,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      // Line
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      // Second Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Current Units
                              Text(
                                "Current Units",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                element.quantity!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // WACC
                              Text(
                                "WACC",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                element.rate!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Current Value
                              Text(
                                "Current Value",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                element.marketValue!,
                                style: portfolioGreyStyle,
                              ),
                            ],
                          ),
                          // Second Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sold Units
                              Text(
                                "Sold Units",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                "0",
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Sold Value
                              Text(
                                "Sold Value",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                "Rs 0",
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Dividend
                              Text(
                                "Dividend",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                "Rs 0",
                                style: portfolioGreyStyle,
                              ),
                            ],
                          ),
                          // Third Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Investement
                              Text(
                                "Investement",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                element.investment!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Estimated Loss
                              Text(
                                "Estimated Loss",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                element.overall!,
                                style: portfolioGreyStyle,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Today's Gain
                              Text(
                                "Today's Gain",
                                style: portfolioblackStyle,
                              ),
                              Text(
                                element.day!,
                                style: portfolioGreyStyle,
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Line
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      // Third Row
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          // Receivable Amount
                          RichText(
                            text: TextSpan(
                              text: "Receivable Amount: ",
                              style: portfolioWhiteStyle,
                              children: [
                                TextSpan(
                                  text: "Rs -35",
                                  style: portfolioWhiteStyle,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          // Profit or Loss
                          RichText(
                            text: TextSpan(
                              text: "Loss: ",
                              style: portfolioWhiteStyle,
                              children: [
                                TextSpan(
                                  text: "100%",
                                  style: portfolioWhiteStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0,
                  color: Colors.white,
                  height: 10.h,
                ),
              ],
            ),
          );
        } else {
          // return Container(
          //   margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //   width: MediaQuery.of(context).size.width,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     color: GlobalVariablesColor.mainColor,
          //     border: Border.all(color: GlobalVariablesColor.mainColor2),
          //   ),
          //   child: const Center(
          //     child: Text(
          //       "No results found",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 15,
          //           fontWeight: FontWeight.w500),
          //     ),
          //   ),
          // );

        }
      }
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(children: list),
      ),
    );
  }
}
