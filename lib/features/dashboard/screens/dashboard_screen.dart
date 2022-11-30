import 'package:badges/badges.dart';
import 'package:biz_alert/admob.dart';
import 'package:biz_alert/common/services/hivemodel.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/biz_services/screens/biz_services_screen.dart';
import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/live_market_screen.dart';
import 'package:biz_alert/features/dashboard/login_profile/screens/login_profile_screen.dart';
import 'package:biz_alert/features/dashboard/news/screens/news_screen.dart';
import 'package:biz_alert/features/dashboard/notification/screens/notification_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/portfolio_chart_screen.dart';
import 'package:biz_alert/features/dashboard/screens/testing123.dart';
import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/watchlist_screen.dart';
import 'package:biz_alert/features/logout_profile/screens/logout_profile_screen.dart';
import 'package:biz_alert/features/payment/screen/portfolio_pay.dart';
import 'package:biz_alert/features/payment/services/dio_payment.dart';
import 'package:biz_alert/models/response/dashboard_res_model.dart';
import 'package:biz_alert/models/response/get_indices_res_model.dart';
import 'package:biz_alert/models/response/live_index_graph_res_model.dart';
import 'package:biz_alert/models/response/market_summary_res_model.dart';
import 'package:biz_alert/models/response/top_gainers_res_model.dart';
import 'package:biz_alert/models/response/top_losers_res_model.dart';
import 'package:biz_alert/models/response/top_sector_res_model.dart';
import 'package:biz_alert/models/response/top_turnover_res_model.dart';
import 'package:biz_alert/models/response/user_active_service_res.dart';
import 'package:biz_alert/providers/dashboard_provider.dart';
import 'package:biz_alert/providers/get_indices_provider.dart';
import 'package:biz_alert/providers/live_index_graph_provider.dart';
import 'package:biz_alert/providers/market_summary_provider.dart';
import 'package:biz_alert/providers/top_gainers_provider.dart';
import 'package:biz_alert/providers/top_losers_provider.dart';
import 'package:biz_alert/providers/top_sector_provider.dart';
import 'package:biz_alert/providers/top_turnover_provider.dart';
import 'package:biz_alert/providers/user_active_service_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../../providers/theme_notifier_provider.dart';
import 'widgets/widgets.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard-screen';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<DashboardModel>? dashboardData;
  Future<GetIndicesModel>? getIndicesData;
  Future<MarketSummaryModel>? marketSummaryData;
  Future<TopGainersModel>? topGainersData;
  Future<TopLosersModel>? topLosersData;
  Future<TopTurnoverModel>? topTurnoverData;
  Future<TopSectorModel>? topSectorData;
  Future<LiveIndexGraphModel?>? liveIndexGraphData;
  Future<UserActiveServiceResponseModel?>? userActiveServiceData;

  //notfication box hive
  final getNotificationBox = Hive.box(notificationBox);

  // For Search in Dashboard that navigate to company detail page
  StockDbModel stockSymbol = Hive.box(companyIdSymbol).get("stockInfo");

  // Of Chart
  String doubleTime(String timer) {
    var first = timer.substring(0, timer.indexOf(':'));
    var second = timer.substring(timer.indexOf(":") + 1);
    int hour = int.parse(first);
    int min = int.parse(second);

    String output = "$hour:$min";
    return output;
  }

  // For Changing Index
  String? indexName;
  int indexID = 58;

  // Creating for changing the data according to change in index name
  Future<LiveIndexGraphModel?>? getLiveIndexGraphData() async {
    final liveIndexGraph =
        Provider.of<LiveIndexGraphProvider>(context, listen: false);
    LiveIndexGraphModel? liveIndexGraphModel =
        await liveIndexGraph.getLiveIndexGraphData(indexID);

    return liveIndexGraphModel;
  }

  // Of BottomNavigationBar
  double bottomBarWidth = 100.w;
  DateTime backpress = DateTime.now();

  // For Authentication
  final SecureStorage secureStorage = SecureStorage();

  String? finalToken;

  @override
  void initState() {
    super.initState();
    secureStorage.readData(key: saveToken).then((value) => finalToken = value);

    final dashboard = Provider.of<DashboardProvider>(context, listen: false);
    dashboardData = dashboard.getDashboardData();

    final getIndices = Provider.of<GetIndicesProvider>(context, listen: false);
    getIndicesData = getIndices.getIndicesData();

    final marketSummary =
        Provider.of<MarketSummaryProvider>(context, listen: false);
    marketSummaryData = marketSummary.getMarketData();

    final topGainers = Provider.of<TopGainersProvider>(context, listen: false);
    topGainersData = topGainers.getTopGainersData();

    final topLosers = Provider.of<TopLosersProvider>(context, listen: false);
    topLosersData = topLosers.getTopLosersData();

    final topTurnover =
        Provider.of<TopTurnoverProvider>(context, listen: false);
    topTurnoverData = topTurnover.getTopTurnoverData();

    final topSector = Provider.of<TopSectorProvider>(context, listen: false);
    topSectorData = topSector.getTopSectorData();

    liveIndexGraphData = getLiveIndexGraphData();

    final userActiveService =
        Provider.of<UserActiveServiceProvider>(context, listen: false);
    userActiveServiceData = userActiveService.getUserActiveService();

    tz.initializeTimeZones();

    myBanner.load();
  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();
  }

  // For the refresh Indicator
  final GlobalKey<RefreshIndicatorState> refreshIndicatorState =
      GlobalKey<RefreshIndicatorState>();
  Future refreshPortfolioChartScreen(BuildContext context) async {
    return dashboardData;
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = Provider.of<DashboardProvider>(context).dashboard;

    final getIndices = Provider.of<GetIndicesProvider>(context).getIndices;
    final marketSummary =
        Provider.of<MarketSummaryProvider>(context).marketSummary;
    final liveIndexGraph =
        Provider.of<LiveIndexGraphProvider>(context).liveIndexGraph;

    return SafeArea(
      child: Scaffold(
        // AppBar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            elevation: 2,
            // flexibleSpace: Container(psep
            //   decoration: const BoxDecoration(color: Colors.white),
            // ),
            // Biz Alert Image
            leading: InkWell(
              onTap: (() => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const Testing123()))),
              child: Container(
                padding: EdgeInsets.only(left: 5.w),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 120.w,
                  height: 45.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              // Person Icon
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () async {
                    // checking whether the user is logged in or not
                    if (finalToken == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Text(
                            "Wanna Login! So you can set your profile?",
                            style: styleTextFormField.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 18.sp),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LogOutProfileScreen(),
                                        ),
                                      );
                                    },
                                    bgColor: GlobalVariablesColor.mainColor,
                                    borderColor: GlobalVariablesColor.mainColor,
                                    textSize: 15.sp,
                                    textColor: Colors.white,
                                    text: "Yes",
                                    width: 80,
                                    height: 30),
                                const SizedBox(width: 5),
                                CustomButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    bgColor: Colors.grey,
                                    borderColor: Colors.grey,
                                    textSize: 15.sp,
                                    textColor: Colors.black,
                                    text: "No",
                                    width: 80,
                                    height: 30),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        LoginProfileScreen.routeName,
                        arguments:
                            await SecureStorage().readData(key: saveUserID),
                      );
                    }
                  },
                  child: const Icon(
                    Icons.person_outline,
                    color: GlobalVariablesColor.mainColor,
                    size: 30,
                  ),
                ),
              ),
              // Notification Icon
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, NotificationScreen.routeName);
                  },
                  child: Badge(
                    position: BadgePosition.topEnd(
                      top: 5,
                      end: -5,
                    ),
                    badgeContent: StreamBuilder<BoxEvent>(
                      stream: getNotificationBox.watch(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(getNotificationBox.length.toString());
                        }
                        if (snapshot.hasData) {
                          return Text((snapshot.data!.key + 1).toString());
                        }
                        return const Text("99");
                      }),
                      // child: Text(badgeNumber == 0 ? "0" : badgeNumber.toString())
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: GlobalVariablesColor.mainColor,
                      size: 30,
                    ),
                  ),
                ),
              ),

              // Search Icon
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () async {
                    await showSearch(
                        context: context,
                        // delegate to customize the search bar
                        delegate: CustomSearchDelegate());
                  },
                  child: const Icon(
                    Icons.search,
                    color: GlobalVariablesColor.mainColor,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          key: refreshIndicatorState,
          onRefresh: () => refreshPortfolioChartScreen(context),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // NEPSE INDEX and Menu Icon and Date, Time and Market
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                    top: 15.h,
                    bottom: 15.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // NEPSE INDEX and Menu Icon
                      FutureBuilder<LiveIndexGraphModel?>(
                          future: liveIndexGraphData,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return Row(
                                children: [
                                  // NEPSE INDEX
                                  GestureDetector(
                                    onTap: () {
                                      // Just trying for Notification
                                      // NotificationService().showNotification(
                                      //   1,
                                      //   liveIndexGraph!.dataCollection.data
                                      //       .indexSummary.indexName,
                                      //   liveIndexGraph.dataCollection.data
                                      //       .indexSummary.indexPoint,
                                      // );
                                    },
                                    child: Text(
                                      // "NEPSE Index",
                                      "${liveIndexGraph!.dataCollection.data.indexSummary.indexName} INDEX",
                                      // indexName!,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  // Menu Icon
                                  indexDropDown(),
                                ],
                              );
                            }
                          }),

                      // Date Time and Month
                      SizedBox(
                        child: FutureBuilder<GetIndicesModel?>(
                          future: getIndicesData,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return Row(
                                children: [
                                  // Date and Month
                                  Text(
                                    DateFormat('MMM d ').format(
                                        DateFormat("yyyy/MM/dd HH:mm").parse(
                                            getIndices!
                                                .dataCollection[0].datetime)),
                                    style:
                                        dateTimeStyle.copyWith(fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    "|",
                                    style:
                                        dateTimeStyle.copyWith(fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  // Time
                                  Text(
                                    DateFormat('h:m a ').format(
                                        DateFormat("yyyy/MM/dd HH:mm").parse(
                                            getIndices
                                                .dataCollection[0].datetime)),
                                    style:
                                        dateTimeStyle.copyWith(fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Total Point, Loss/Profit, Percent, Market Status
                FutureBuilder<LiveIndexGraphModel?>(
                    future: liveIndexGraphData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                            ),
                            child: Row(
                              children: [
                                // Total Points
                                Text(
                                  liveIndexGraph!.dataCollection.data
                                      .indexSummary.indexPoint,
                                  style: dateTimeStyle.copyWith(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15.sp),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                // Loss/Profit
                                Icon(
                                  double.parse(liveIndexGraph
                                              .dataCollection
                                              .data
                                              .indexSummary
                                              .percentageChange) >
                                          0
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  size: 13.h,
                                  color: double.parse(liveIndexGraph
                                              .dataCollection
                                              .data
                                              .indexSummary
                                              .percentageChange) >
                                          0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Text(
                                  liveIndexGraph.dataCollection.data
                                      .indexSummary.absoluteChange,
                                  style: dateTimeStyle.copyWith(
                                      color: double.parse(liveIndexGraph
                                                  .dataCollection
                                                  .data
                                                  .indexSummary
                                                  .percentageChange) >
                                              0
                                          ? Colors.green
                                          : Colors.red),
                                ),

                                SizedBox(
                                  width: 5.w,
                                ),

                                // Percentage
                                Text(
                                  "${liveIndexGraph.dataCollection.data.indexSummary.percentageChange}%",
                                  style: dateTimeStyle.copyWith(
                                      color: double.parse(liveIndexGraph
                                                  .dataCollection
                                                  .data
                                                  .indexSummary
                                                  .percentageChange) >
                                              0
                                          ? Colors.green
                                          : Colors.red),
                                ),

                                Flexible(
                                  child: Container(),
                                ),
                                // Market Status
                                Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  decoration: BoxDecoration(
                                      color: liveIndexGraph.dataCollection.data
                                                  .marketStatus.status ==
                                              "close"
                                          ? Colors.red
                                          : Colors.green,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: liveIndexGraph
                                                      .dataCollection
                                                      .data
                                                      .marketStatus
                                                      .status ==
                                                  "close"
                                              ? Colors.red.withOpacity(0.5)
                                              : Colors.green.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0.5, 0.5),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 5),
                                    child: Text(
                                      liveIndexGraph.dataCollection.data
                                          .marketStatus.status,
                                      // "Market Closed",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),

                const SizedBox(
                  height: 5,
                ),

                // Chart (Line Chart)
                liveChart(),
                const SizedBox(
                  height: 10,
                ),

                // Advanced, Declined, Unchanged,  TurnOvers,Traded Shares
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: FutureBuilder<LiveIndexGraphModel?>(
                      future: liveIndexGraphData,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // Advanced
                                  Container(
                                    width: 100,
                                    height: 60.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          topLeft: Radius.circular(5)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "ADVANCED",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          liveIndexGraph!.dataCollection.data
                                              .indexSummary.advances,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Declined
                                  Container(
                                    width: 100,
                                    height: 60.h,
                                    color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "DECLINED",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          liveIndexGraph.dataCollection.data
                                              .indexSummary.declines,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Unchanged
                                  Container(
                                    width: 100,
                                    height: 60.h,
                                    color: Colors.blue[300],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "UNCHANGED",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          liveIndexGraph.dataCollection.data
                                              .indexSummary.noChange,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // TurnOvers,Traded Shares
                                  FutureBuilder<MarketSummaryModel?>(
                                      future: marketSummaryData,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        } else {
                                          return SizedBox(
                                            child: Row(
                                              children: [
                                                // TurnOvers
                                                Container(
                                                  width: 160,
                                                  height: 60.h,
                                                  color: GlobalVariablesColor
                                                      .mainColor1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "Total Turnover",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 3),
                                                        child: Text(
                                                          " Rs: ${marketSummary!.dataCollection[0].totalTurnover}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Traded Shares
                                                Container(
                                                  width: 160,
                                                  height: 60.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: GlobalVariablesColor
                                                        .mainColor2,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "Total Traded Shares",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 3),
                                                        child: Text(
                                                          marketSummary
                                                              .dataCollection[0]
                                                              .tradeshares,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Top Gainers, Top Losers, Top Turnover, Top Sector
                // Table Slider
                SizedBox(
                  height: 280,
                  // color: Colors.orange,
                  child: CarouselSlider(
                    //Slider Container properties
                    options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      // aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.95,
                    ),
                    items: [
                      // Gainers
                      TopGainers(
                          context: context, topGainersData: topGainersData),

                      // Losers
                      TopLosers(context: context, topLosersData: topLosersData),

                      // Turnover
                      TopTurnover(
                          context: context, topTurnoverData: topTurnoverData),

                      // Sector
                      TopSector(context: context, topSectorData: topSectorData)
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        // * Bottom Navigation Bar
        bottomNavigationBar: buildBottomNavigationMenu(context),
      ),
    );
  }

  //For the Menu Icon in dashboard
  Widget indexDropDown() {
    final dashboard = Provider.of<DashboardProvider>(context).dashboard;
    final userActiveService =
        Provider.of<UserActiveServiceProvider>(context).userActiveService;
    return FutureBuilder<DashboardModel?>(
        future: dashboardData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Icon(
                  Icons.list,
                  size: 24.h,
                  color: GlobalVariablesColor.mainColor,
                ),
                items: dashboard!.dataCollection.data.index
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.name,
                        child: Text(
                          e.name,
                          style: dropDownStyle.copyWith(
                              fontSize: 15.sp,
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                value: indexName,
                onChanged: (value) async {
                  setState(() {
                    indexName = value as String;
                    final sym = dashboard.dataCollection.data.index
                        .firstWhere((element) => element.name == indexName);
                    indexID = sym.indexId;
                    getLiveIndexGraphData();
                  });
                },
                itemHeight: 50,
                dropdownMaxHeight: 300,
                itemPadding: const EdgeInsets.only(left: 16, right: 16),
                dropdownWidth: 160,
                dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: GlobalVariablesColor.mainColor,
                ),
                dropdownElevation: 8,
                offset: const Offset(0, 8),
              ),
            );
          }
        });
  }

  // Live Chart
  Widget liveChart() {
    final liveIndexGraph =
        Provider.of<LiveIndexGraphProvider>(context).liveIndexGraph;
    return FutureBuilder<LiveIndexGraphModel?>(
      future: liveIndexGraphData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return Padding(
            padding:
                EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
            child: AspectRatio(
              aspectRatio: 1.8,
              child: SfCartesianChart(
                plotAreaBorderColor: Colors.white,
                primaryXAxis: CategoryAxis(
                  interval: 2,
                  majorGridLines: const MajorGridLines(width: 0),
                  interactiveTooltip: const InteractiveTooltip(
                      // Enables the crosshair tooltip
                      enable: true),
                ),
                // For showing the data when user touch the graph
                trackballBehavior: TrackballBehavior(
                    enable: true,
                    lineColor: double.parse(liveIndexGraph!.dataCollection.data
                                .indexSummary.percentageChange) >
                            0
                        ? Colors.green
                        : double.parse(liveIndexGraph.dataCollection.data
                                    .indexSummary.percentageChange) <
                                0
                            ? Colors.red
                            : Colors.blue,
                    lineDashArray: const <double>[5, 5],
                    lineWidth: 2,
                    lineType: TrackballLineType.vertical,
                    activationMode: ActivationMode.singleTap,
                    tooltipSettings:
                        const InteractiveTooltip(format: 'point.x : point.y')),
                series: [
                  AreaSeries(
                      color: double.parse(liveIndexGraph.dataCollection.data
                                  .indexSummary.percentageChange) >
                              0
                          ? Colors.green.withOpacity(0.5)
                          : double.parse(liveIndexGraph.dataCollection.data
                                      .indexSummary.percentageChange) <
                                  0
                              ? Colors.red.withOpacity(0.5)
                              : Colors.blue.withOpacity(0.5),
                      borderColor: double.parse(liveIndexGraph.dataCollection
                                  .data.indexSummary.percentageChange) >
                              0
                          ? Colors.green
                          : double.parse(liveIndexGraph.dataCollection.data
                                      .indexSummary.percentageChange) <
                                  0
                              ? Colors.red
                              : Colors.blue,
                      borderWidth: 2,
                      dataSource: List.generate(
                        liveIndexGraph.dataCollection.data.indexGraph.length,
                        (index) => _MyData(
                            time: doubleTime(
                              DateFormat('h:m').format(
                                DateFormat("HH:mm").parse(liveIndexGraph
                                    .dataCollection
                                    .data
                                    .indexGraph[index]
                                    .time),
                              ),
                            ),
                            value: liveIndexGraph
                                .dataCollection.data.indexGraph[index].value),
                      ),
                      xValueMapper: (_MyData mydata, _) => mydata.time,
                      yValueMapper: (_MyData mydata, _) => mydata.value)
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Top Loser Widget

  // Top TurnOver Widget

  // Top Sector Widget

  // Bottom Navigation Bar using Goole Nav Bar Package
  buildBottomNavigationMenu(context) {
    final userActiveService =
        Provider.of<UserActiveServiceProvider>(context).userActiveService;
    final dashboard = Provider.of<DashboardProvider>(context).dashboard;
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        backpress = DateTime.now();
        if (cantExit) {
          // show snackbar
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: FutureBuilder<DashboardModel?>(
            future: dashboardData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                // Checking the UserActiveService Subscription for portfolio
                return FutureBuilder<UserActiveServiceResponseModel?>(
                    future: userActiveServiceData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return BottomNavigationBar(
                          elevation: 2,
                          iconSize: Dimensions.iconSize25,
                          // backgroundColor: GlobalVariablesColor.backgroundColor,
                          selectedItemColor: GlobalVariablesColor.mainColor,
                          unselectedItemColor: GlobalVariablesColor.mainColor,
                          type: BottomNavigationBarType.fixed,
                          items: [
                            // Live Market
                            BottomNavigationBarItem(
                              tooltip: "Live Market",
                              icon: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, LiveMarketScreen.routeName);
                                },
                                child: SizedBox(
                                  width: 100,
                                  child: Icon(
                                    Icons.live_tv,
                                    size: 30.h,
                                  ),
                                ),
                              ),
                              label: '',
                            ),

                            // News
                            BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, NewsScreen.routeName);
                                },
                                child: SizedBox(
                                  width: bottomBarWidth,
                                  child: Icon(
                                    Icons.newspaper,
                                    size: 30.h,
                                  ),
                                ),
                              ),
                              label: '',
                            ),

                            // Protfolio
                            BottomNavigationBarItem(
                              // Checking the Ncell Subscription
                              icon: GestureDetector(
                                onTap: () async {
                                  // checking whether the user is logged in or not
                                  if (finalToken == null) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: Text(
                                          "Wanna set Portfolio! Do Login?",
                                          style: styleTextFormField.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.sp),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomButton(
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LogOutProfileScreen(),
                                                      ),
                                                    );
                                                  },
                                                  bgColor: GlobalVariablesColor
                                                      .mainColor,
                                                  borderColor:
                                                      GlobalVariablesColor
                                                          .mainColor,
                                                  textSize: 15.sp,
                                                  textColor: Colors.white,
                                                  text: "Yes",
                                                  width: 80,
                                                  height: 30),
                                              const SizedBox(width: 5),
                                              CustomButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  bgColor: Colors.grey,
                                                  borderColor: Colors.grey,
                                                  textSize: 15.sp,
                                                  textColor: Colors.black,
                                                  text: "No",
                                                  width: 80,
                                                  height: 30),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (finalToken != null) {
                                    dashboard!.dataCollection.data
                                                .disableServies.ncellPayment ==
                                            false
                                        ? Navigator.pushNamed(
                                            context,
                                            PortfolioChartScreen.routeName,
                                          )
                                        : userActiveService!.dataCollection
                                                    .data[0].isExpired ==
                                                0
                                            ? Navigator.pushNamed(
                                                context,
                                                PortfolioChartScreen.routeName,
                                              )
                                            : Navigator.pushNamed(context,
                                                PortfolioPayment.routeName);
                                  } else {
                                    Navigator.pushNamed(
                                        context, PortfolioPayment.routeName);
                                  }
                                },
                                child: SizedBox(
                                  width: bottomBarWidth,
                                  child: Icon(
                                    Icons.work,
                                    size: 30.h,
                                  ),
                                ),
                              ),

                              label: '',
                            ),

                            // Watchlist
                            BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () async {
                                  // checking whether the user is logged in or not
                                  if (finalToken == null) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: Text(
                                          "Want to have watchlist! Do Login?",
                                          style: styleTextFormField.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.sp),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomButton(
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LogOutProfileScreen(),
                                                      ),
                                                    );
                                                  },
                                                  bgColor: GlobalVariablesColor
                                                      .mainColor,
                                                  borderColor:
                                                      GlobalVariablesColor
                                                          .mainColor,
                                                  textSize: 15.sp,
                                                  textColor: Colors.white,
                                                  text: "Yes",
                                                  width: 80,
                                                  height: 30),
                                              const SizedBox(width: 5),
                                              CustomButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  bgColor: Colors.grey,
                                                  borderColor: Colors.grey,
                                                  textSize: 15.sp,
                                                  textColor: Colors.black,
                                                  text: "No",
                                                  width: 80,
                                                  height: 30),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    Navigator.pushNamed(
                                        context, WatchlistScreen.routeName
                                        // arguments:
                                        //     await SecureStorage().readData(key: saveUserID),
                                        );
                                  }
                                },
                                child: SizedBox(
                                  width: bottomBarWidth,
                                  child: Icon(
                                    Icons.visibility,
                                    size: 30.h,
                                  ),
                                ),
                              ),
                              label: '',
                            ),

                            // Biz Services
                            BottomNavigationBarItem(
                              icon: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, BizServicesScreen.routeName,
                                      arguments: {
                                        "ncellPayment": dashboard!
                                            .dataCollection
                                            .data
                                            .disableServies
                                            .ncellPayment
                                      });
                                },
                                child: SizedBox(
                                  width: bottomBarWidth,
                                  child: Icon(
                                    Icons.miscellaneous_services,
                                    size: 30.h,
                                  ),
                                ),
                              ),
                              label: '',
                            ),
                          ],
                        );
                      }
                    });
              }
            }),
      ),
    );
  }
}

// For the implementation of search bar in dashboard using SearchDelegate
class CustomSearchDelegate extends SearchDelegate {
  // For Search in Dashboard that navigate to company detail page
  StockDbModel stockSymbol = Hive.box(companyIdSymbol).get("stockInfo");
  // For Changing the design of a search bar in Search Delegate
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      // appBarTheme: const AppBarTheme(
      //   color: GlobalVariablesColor.mainColor,
      // ),
      // textSelectionTheme:
      //     const TextSelectionThemeData(cursorColor: Colors.white),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          decoration: TextDecoration.none,
          // color: Colors.white
        ), // query Color
      ),
      inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: GlobalVariablesColor.mainColor),
          border: InputBorder.none),
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
          // color: Colors.white,
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
      icon: const Icon(
        Icons.arrow_back,
        //  color: Colors.white
      ),
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
    return dashboardSearch(context);
  }

  //  For the searching result
  dashboardSearch(context) {
    List<Widget> list = <Widget>[];
    for (var e in stockSymbol.dataCollection) {
      if (e.companyName.toLowerCase().contains(query.toLowerCase()) ||
          e.stockSymbol.toLowerCase().contains(query.toLowerCase())) {
        list.add(GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                arguments: e.stockSymbol);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            color: GlobalVariablesColor.mainColor.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.companyName,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  e.stockSymbol,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: GlobalVariablesColor.greyBackgroundCOlor,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ));
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(0.w),
        child: Column(children: list),
      ),
    );
  }
}

// For Chart
class _MyData {
  final String time;
  final double value;

  _MyData({
    required this.time,
    required this.value,
  });
}
