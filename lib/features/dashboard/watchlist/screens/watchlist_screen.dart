import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_watchlist_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/saved_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/services/dio_watchlist.dart';
import 'package:biz_alert/models/request/del_req_watchlist.dart';
import 'package:biz_alert/models/response/get_res_watchlist.dart';
import 'package:biz_alert/models/response/saved_res%20_watchlist_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';
import '../../companyDetail/screens/company_detail_screen.dart';

class WatchlistScreen extends StatefulWidget {
  static const String routeName = "/watchlist";

  const WatchlistScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late DioWatchList _dioWatchList;

// For refresh indicator in DataTable
  // Future<GetResponseWatchList?> refreshWatchlistScreen(
  //     BuildContext context) async {
  //   final res = await DioWatchList().getInitialShareInfo();
  //   return res;
  // }

  static const int sortSymbolDescending = 0;
  static const int sortLtpDescending = 1;
  static const int sortChangePercentDescending = 2;
  static const int sortChangeDescending = 3;
  static const int sortHighDescending = 4;
  static const int sortLowDescending = 5;
  static const int sortQtyDescending = 6;
  static const int sortPcloseDescending = 7;
  bool isDescending = false;
  int sortType = sortSymbolDescending;

  @override
  void initState() {
    super.initState();
    _dioWatchList = DioWatchList();
  }

  // Calling Firebase messaging
  void main() async {
    await FirebaseMessaging.instance.subscribeToTopic("watchlist");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context, DashboardScreen.routeName);
          },
          text: "Watchlist",
          icon2: Icons.add,
          onPressed2: () {
            Navigator.popAndPushNamed(
                context, AddStockWatchlistScreen.routeName);
          },
        ),
      ),
      body: stockAdded(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.popAndPushNamed(context, SavedStockAlertScreen.routeName);
          },
          heroTag: const Text("btn1"),
          label: Text(
            'Stock Alert',
            style: TextStyle(
              fontSize: 20,
              color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          backgroundColor: GlobalVariablesColor.mainColor,
        ),
      ),
    );
  }

  Widget _getHeaderItemWidget(String label, [IconData? ic]) {
    return Container(
      width: label == "" ? 88.w : 66.w,
      height: 45.h,
      padding: EdgeInsets.only(left: 5.w),
      alignment: Alignment.centerLeft,
      color: Colors.transparent.withAlpha(10),
      child: Wrap(direction: Axis.horizontal, children: [
        Text(label,
            style: tableStyle.copyWith(
              fontSize: 12.sp,
              color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.white
                  : Colors.black,
            ),
            textAlign: TextAlign.center),
        Padding(
          padding: EdgeInsets.only(left: 3.w, top: 3.h),
          child: Icon(
            ic,
            size: 10.h,
            color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Colors.white
                : Colors.black,
          ),
        ),
      ]),
    );
  }

  // Added Stock to WatchList
  Widget stockAdded() {
    return FutureBuilder<GetResponseWatchList>(
        future: _dioWatchList.getInitialShareInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CustomLoader();
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: HorizontalDataTable(
                      leftHandSideColBackgroundColor: Colors.transparent,
                      rightHandSideColBackgroundColor: Colors.transparent,
                      // scrollPhysics: const NeverScrollableScrollPhysics(),
                      leftHandSideColumnWidth: 66.w,
                      rightHandSideColumnWidth: 480.w,
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
                                sortType = sortHighDescending;
                                isDescending = !isDescending;
                              });
                            },
                            child: _getHeaderItemWidget(
                                'High', Icons.unfold_more)),
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
                                sortType = sortChangeDescending;
                                isDescending = !isDescending;
                              });
                            },
                            child: _getHeaderItemWidget(
                                'Change', Icons.unfold_more)),
                        InkWell(
                            onTap: () {
                              setState(() {
                                sortType = sortChangePercentDescending;
                                isDescending = !isDescending;
                              });
                            },
                            child: _getHeaderItemWidget(
                                'Ch %', Icons.unfold_more)),
                        InkWell(
                            onTap: () {
                              setState(() {
                                sortType = sortQtyDescending;
                                isDescending = !isDescending;
                              });
                            },
                            child: _getHeaderItemWidget(
                                'PClose', Icons.unfold_more)),
                        InkWell(
                            onTap: () {
                              setState(() {
                                sortType = sortPcloseDescending;
                                isDescending = !isDescending;
                              });
                            },
                            child: _getHeaderItemWidget(
                              '',
                            )),
                      ],
                      rowSeparatorWidget: const Divider(
                        color: Colors.transparent,
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
                      itemCount: snapshot.data!.dataCollection.d.data.length,
                      // Symbol Name
                      leftSideItemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CompanyDetailScreen.routeName,
                                arguments: snapshot
                                    .data!.dataCollection.d.data[index].symbol);
                          },
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              setState(
                                () {
                                  switch (sortType) {
                                    case sortSymbolDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.symbol.compareTo(a.symbol)
                                              : a.symbol.compareTo(b.symbol);
                                        }),
                                      );
                                      break;
                                    case sortLtpDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.ltp.compareTo(a.ltp)
                                              : a.ltp.compareTo(b.ltp);
                                        }),
                                      );
                                      break;
                                    case sortChangePercentDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.percentChange
                                                  .compareTo(a.percentChange)
                                              : a.percentChange
                                                  .compareTo(b.percentChange);
                                        }),
                                      );
                                      break;
                                    case sortChangeDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.turnover.compareTo(a.turnover)
                                              : a.turnover
                                                  .compareTo(b.turnover);
                                        }),
                                      );
                                      break;
                                    case sortHighDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.high.compareTo(a.high)
                                              : a.high.compareTo(b.high);
                                        }),
                                      );
                                      break;
                                    case sortLowDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.low.compareTo(a.low)
                                              : a.low.compareTo(b.low);
                                        }),
                                      );
                                      break;
                                    case sortQtyDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.qty.compareTo(a.qty)
                                              : a.qty.compareTo(b.qty);
                                        }),
                                      );
                                      break;
                                    case sortPcloseDescending:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return isDescending
                                              ? b.pltp.compareTo(a.pltp)
                                              : a.pltp.compareTo(b.pltp);
                                        }),
                                      );
                                      break;

                                    default:
                                      snapshot.data!.dataCollection.d.data.sort(
                                        ((a, b) {
                                          return a.symbol.compareTo(b.symbol);
                                        }),
                                      );
                                  }
                                },
                              );

                              return Container(
                                color: snapshot.data!.dataCollection.d
                                            .data[index].percentChange >
                                        0
                                    ? Colors.green
                                    : snapshot.data!.dataCollection.d
                                                .data[index].percentChange <
                                            0
                                        ? Colors.red
                                        : Colors.blue,
                                width: 66.w,
                                height: 45.h,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  snapshot.data!.dataCollection.d.data[index]
                                      .symbol,
                                  style: tableRowStyle.copyWith(
                                    fontSize: 13.sp,
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      rightSideItemBuilder: (BuildContext context, int index) {
                        var change = snapshot
                                .data!.dataCollection.d.data[index].ltp -
                            snapshot.data!.dataCollection.d.data[index]
                                .pltp; //Bringing out the change by calculating

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CompanyDetailScreen.routeName,
                                arguments: snapshot
                                    .data!.dataCollection.d.data[index].symbol);
                          },
                          child: Container(
                            color: snapshot.data!.dataCollection.d.data[index]
                                        .percentChange >
                                    0
                                ? Colors.green
                                : snapshot.data!.dataCollection.d.data[index]
                                            .percentChange <
                                        0
                                    ? Colors.red
                                    : Colors.blue,
                            child: Row(
                              children: [
                                // LTP
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 66.w,
                                  height: 45.h,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    snapshot
                                        .data!.dataCollection.d.data[index].ltp
                                        .toString(),
                                    style: tableRowStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),

                                // High
                                Container(
                                  width: 66.w,
                                  height: 45.h,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    snapshot
                                        .data!.dataCollection.d.data[index].high
                                        .toString(),
                                    style: tableRowStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                // Low
                                Container(
                                  width: 66.w,
                                  height: 45.h,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    snapshot
                                        .data!.dataCollection.d.data[index].low
                                        .toString(),
                                    style: tableRowStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                // Change
                                Container(
                                  width: 66.w,
                                  height: 45.h,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    change.abs().toStringAsFixed(2),
                                    style: tableRowStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                // %Change
                                Container(
                                  width: 66.w,
                                  height: 45.h,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    snapshot.data!.dataCollection.d.data[index]
                                        .percentChange
                                        .toString(),
                                    style: tableRowStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),

                                // PClose
                                Container(
                                  width: 66.w,
                                  height: 45.h,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    snapshot
                                        .data!.dataCollection.d.data[index].pltp
                                        .toString(),
                                    style: tableRowStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),

                                // Notification Icon
                                FutureBuilder<GetSavedWatchlistAlertResponse>(
                                    future: _dioWatchList
                                        .getInitialWatchlistAlertInfo(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.popAndPushNamed(context,
                                                AddStockAlertScreen.routeName,
                                                arguments: {
                                                  "symbol": snapshot
                                                      .data!
                                                      .dataCollection
                                                      .d
                                                      .alert[index]
                                                      .stockSymbol,
                                                  "companyID": snapshot
                                                      .data!
                                                      .dataCollection
                                                      .d
                                                      .alert[index]
                                                      .companyId,
                                                  "increasePrice": snapshot
                                                      .data
                                                      ?.dataCollection
                                                      .d
                                                      .alert[index]
                                                      .increasePrice,
                                                  "decreasePrice": snapshot
                                                      .data
                                                      ?.dataCollection
                                                      .d
                                                      .alert[index]
                                                      .decreasePrice,
                                                  "emailIncrease": snapshot
                                                      .data
                                                      ?.dataCollection
                                                      .d
                                                      .alert[index]
                                                      .sendEmailOnIncrease,
                                                  "emailDecrease": snapshot
                                                      .data
                                                      ?.dataCollection
                                                      .d
                                                      .alert[index]
                                                      .sendEmailOnDecrease,
                                                });
                                          },
                                          child: Container(
                                            width: 40.w,
                                            height: 45.h,
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: const Icon(
                                                Icons.notifications,
                                                size: 25,
                                                color: GlobalVariablesColor
                                                    .mainColor),
                                          ),
                                        );
                                      }
                                    }),

                                // Delete Icon
                                GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content: const Text(
                                            "Are you sure you want to delete?"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomButton(
                                                  onPressed: () async {
                                                    await _dioWatchList
                                                        .deleteWatchlist(
                                                      DeleteRequestWatchlist(
                                                          userId: await SecureStorage()
                                                              .readData(
                                                                  key:
                                                                      saveUserID),
                                                          companyId: snapshot
                                                              .data!
                                                              .dataCollection
                                                              .d
                                                              .data[index]
                                                              .companyId),
                                                    );
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
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
                                                    Navigator.of(context).pop();
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
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 45.h,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: const Icon(Icons.delete,
                                        size: 25, color: Colors.redAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Error establishing connection. Please try again."),
            );
          }
        });
  }
}


// import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
// import 'package:biz_alert/common/widgets/custom_button.dart';
// import 'package:biz_alert/common/widgets/custom_loader.dart';
// import 'package:biz_alert/constants/globalVariables.dart';
// import 'package:biz_alert/constants/secure_constant.dart';
// import 'package:biz_alert/constants/secure_storage.dart';
// import 'package:biz_alert/constants/style.dart';
// import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
// import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_alert.dart';
// import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_watchlist_screen.dart';
// import 'package:biz_alert/features/dashboard/watchlist/screens/saved_stock_alert.dart';
// import 'package:biz_alert/features/dashboard/watchlist/services/dio_watchlist.dart';
// import 'package:biz_alert/models/request/del_req_watchlist.dart';
// import 'package:biz_alert/models/response/get_res_watchlist.dart';
// import 'package:biz_alert/models/response/saved_res%20_watchlist_alert.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';

// import '../../companyDetail/screens/company_detail_screen.dart';

// class WatchlistScreen extends StatefulWidget {
//   static const String routeName = "/watchlist";

//   const WatchlistScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<WatchlistScreen> createState() => _WatchlistScreenState();
// }

// class _WatchlistScreenState extends State<WatchlistScreen> {
//   late DioWatchList _dioWatchList;
//   static const int sortSymbolDescending = 0;
//   static const int sortLtpDescending = 1;
//   static const int sortChangePercentDescending = 2;
//   static const int sortHighDescending = 4;
//   static const int sortLowDescending = 5;
//   static const int sortPcloseDescending = 7;
//   bool isDescending = false;
//   int sortType = sortSymbolDescending;

// // For refresh indicator in DataTable
//   // Future<GetResponseWatchList?> refreshWatchlistScreen(
//   //     BuildContext context) async {
//   //   final res = await DioWatchList().getInitialShareInfo();
//   //   return res;
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _dioWatchList = DioWatchList();
//   }

//   // Calling Firebase messaging
//   void main() async {
//     await FirebaseMessaging.instance.subscribeToTopic("watchlist");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GlobalVariablesColor.backgroundColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: CustomAppBar1(
//           onPressed: () {
//             Navigator.pop(context, DashboardScreen.routeName);
//           },
//           text: "Watchlist",
//           icon2: Icons.add,
//           onPressed2: () {
//             Navigator.popAndPushNamed(
//                 context, AddStockWatchlistScreen.routeName);
//           },
//         ),
//       ),
//       body: stockAdded(),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//         child: FloatingActionButton.extended(
//           onPressed: () {
//             Navigator.popAndPushNamed(context, SavedStockAlertScreen.routeName);
//           },
//           heroTag: const Text("btn1"),
//           label: const Text(
//             'Stock Alert',
//             style: TextStyle(fontSize: 20),
//           ),
//           backgroundColor: GlobalVariablesColor.mainColor,
//         ),
//       ),
//     );
//   }

//   // Get Header Widget
//   // List<Widget> _getHeaderWidget() {
//   //   return [
//   //     _getHeaderItemWidget('SYM'),
//   //     _getHeaderItemWidget('LTP'),
//   //     _getHeaderItemWidget('High'),
//   //     _getHeaderItemWidget('Low'),
//   //     _getHeaderItemWidget('CH'),
//   //     _getHeaderItemWidget('CH%'),
//   //     _getHeaderItemWidget('PClose'),
//   //     _getHeaderItemWidget(''),
//   //     _getHeaderItemWidget(''),
//   //   ];
//   // }

//   Widget _getHeaderItemWidget(String label, IconData ic) {
//     return Container(
//         width: label == "" ? 40.w : 70.w,
//         height: 45.h,
//         padding: EdgeInsets.only(left: 5.w),
//         alignment: Alignment.centerLeft,
//         color: Colors.blue[300],
//         child: Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             Text(label,
//                 style:
//                     tableStyle.copyWith(fontSize: 15.sp, color: Colors.white),
//                 textAlign: TextAlign.center),
//             Padding(
//               padding: EdgeInsets.only(left: 3.w, top: 3.h),
//               child: Icon(
//                 ic,
//                 size: 10.h,
//               ),
//             ),
//           ],
//         ));
//   }

//   // Added Stock to WatchList
//   Widget stockAdded() {
//     return FutureBuilder<GetResponseWatchList>(
//         future: _dioWatchList.getInitialShareInfo(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             // return const Center(child: CustomLoader());
//             return const CustomLoader();
//           } else {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Table
//                 Expanded(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     child: HorizontalDataTable(
//                       // scrollPhysics: const NeverScrollableScrollPhysics(),
//                       leftHandSideColumnWidth: 66.w,
//                       rightHandSideColumnWidth: 480.w,
//                       isFixedHeader: true,
//                       headerWidgets: [
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortSymbolDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child: _getHeaderItemWidget(
//                                 'Symbol', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortLtpDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child:
//                                 _getHeaderItemWidget('LTP', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortHighDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child: _getHeaderItemWidget(
//                                 'High', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortLowDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child:
//                                 _getHeaderItemWidget('Low', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortChangePercentDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child: _getHeaderItemWidget(
//                                 '%Change', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortPcloseDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child: _getHeaderItemWidget(
//                                 'PClose', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortPcloseDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child: _getHeaderItemWidget('', Icons.unfold_more)),
//                         InkWell(
//                             onTap: () {
//                               setState(() {
//                                 sortType = sortPcloseDescending;
//                                 isDescending = !isDescending;
//                               });
//                             },
//                             child: _getHeaderItemWidget('', Icons.unfold_more)),
//                       ],
//                       rowSeparatorWidget: const Divider(
//                         color: Colors.white,
//                         height: 1,
//                         thickness: 1,
//                       ),
//                       elevation: 0.0,
//                       verticalScrollbarStyle: const ScrollbarStyle(
//                         isAlwaysShown: false,
//                         thickness: 0.0,
//                       ),
//                       horizontalScrollbarStyle: const ScrollbarStyle(
//                         isAlwaysShown: false,
//                         thickness: 0.0,
//                       ),
//                       itemCount: snapshot.data!.dataCollection.d.data.length,
//                       // Symbol Name
//                       leftSideItemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, CompanyDetailScreen.routeName,
//                                 arguments: snapshot
//                                     .data!.dataCollection.d.data[index].symbol);
//                           },
//                           child: Container(
//                             color: snapshot.data!.dataCollection.d.data[index]
//                                         .percentChange >
//                                     0
//                                 ? Colors.green
//                                 : snapshot.data!.dataCollection.d.data[index]
//                                             .percentChange <
//                                         0
//                                     ? Colors.red
//                                     : Colors.blue,
//                             width: 66.w,
//                             height: 45.h,
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.only(left: 5.w),
//                             child: Text(
//                               snapshot
//                                   .data!.dataCollection.d.data[index].symbol,
//                               style: tableRowStyle.copyWith(fontSize: 13.sp),
//                             ),
//                           ),
//                         );
//                       },
//                       rightSideItemBuilder: (BuildContext context, int index) {
//                         var change = snapshot
//                                 .data!.dataCollection.d.data[index].ltp -
//                             snapshot.data!.dataCollection.d.data[index]
//                                 .pltp; //Bringing out the change by calculating

//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, CompanyDetailScreen.routeName,
//                                 arguments: snapshot
//                                     .data!.dataCollection.d.data[index].symbol);
//                           },
//                           child: StatefulBuilder(builder: (context, setState) {
//                             setState(() {
//                               switch (sortType) {
//                                 case sortSymbolDescending:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return isDescending
//                                           ? b.symbol.compareTo(a.symbol)
//                                           : a.symbol.compareTo(b.symbol);
//                                     }),
//                                   );
//                                   break;
//                                 case sortLtpDescending:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return isDescending
//                                           ? b.ltp.compareTo(a.ltp)
//                                           : a.ltp.compareTo(b.ltp);
//                                     }),
//                                   );
//                                   break;
//                                 case sortChangePercentDescending:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return isDescending
//                                           ? b.percentChange
//                                               .compareTo(a.percentChange)
//                                           : a.percentChange
//                                               .compareTo(b.percentChange);
//                                     }),
//                                   );
//                                   break;

//                                 case sortHighDescending:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return isDescending
//                                           ? b.high.compareTo(a.high)
//                                           : a.high.compareTo(b.high);
//                                     }),
//                                   );
//                                   break;
//                                 case sortLowDescending:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return isDescending
//                                           ? b.low.compareTo(a.low)
//                                           : a.low.compareTo(b.low);
//                                     }),
//                                   );
//                                   break;

//                                 case sortPcloseDescending:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return isDescending
//                                           ? b.pltp.compareTo(a.pltp)
//                                           : a.pltp.compareTo(b.pltp);
//                                     }),
//                                   );
//                                   break;

//                                 default:
//                                   snapshot.data!.dataCollection.d.data.sort(
//                                     ((a, b) {
//                                       return a.symbol.compareTo(b.symbol);
//                                     }),
//                                   );
//                               }
//                               // if (isSymbolDescending == true) {
//                               //   liveMarketTrading.dataCollection.sort(
//                               //     ((a, b) {
//                               //       return b.symbol.compareTo(a.symbol);
//                               //     }),
//                               //   );
//                               // }
//                               // else if (isChangePercentDescending == true) {
//                               //   liveMarketTrading.dataCollection.sort(
//                               //     ((a, b) {
//                               //       return b.percentageChangePrice
//                               //           .compareTo(a.percentageChangePrice);
//                               //     }),
//                               //   );
//                               // } else if (isOpenDescending == true) {
//                               //   liveMarketTrading.dataCollection.sort(
//                               //     ((a, b) {
//                               //       return b.open.compareTo(a.open);
//                               //     }),
//                               //   );
//                               // } else {
//                               //   liveMarketTrading.dataCollection.sort(
//                               //     ((a, b) {
//                               //       return a.symbol.compareTo(b.symbol);
//                               //     }),
//                               //   );
//                               // }
//                             });
//                             return Container(
//                               color: snapshot.data!.dataCollection.d.data[index]
//                                           .percentChange >
//                                       0
//                                   ? Colors.green
//                                   : snapshot.data!.dataCollection.d.data[index]
//                                               .percentChange <
//                                           0
//                                       ? Colors.red
//                                       : Colors.blue,
//                               child: Row(
//                                 children: [
//                                   // LTP
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     width: 66.w,
//                                     height: 45.h,
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Text(
//                                       snapshot.data!.dataCollection.d
//                                           .data[index].ltp
//                                           .toString(),
//                                       style: tableRowStyle.copyWith(
//                                           fontSize: 13.sp),
//                                     ),
//                                   ),

//                                   // High

//                                   // Change
//                                   // Container(
//                                   //   width: 66.w,
//                                   //   height: 45.h,
//                                   //   alignment: Alignment.centerLeft,
//                                   //   padding: EdgeInsets.only(left: 5.w),
//                                   //   child: Text(
//                                   //     change.abs().toStringAsFixed(2),
//                                   //     style:
//                                   //         tableRowStyle.copyWith(fontSize: 13.sp),
//                                   //   ),
//                                   // ),

//                                   // %Change
//                                   Container(
//                                     width: 66.w,
//                                     height: 45.h,
//                                     alignment: Alignment.centerLeft,
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Text(
//                                       snapshot.data!.dataCollection.d
//                                           .data[index].percentChange
//                                           .toString(),
//                                       style: tableRowStyle.copyWith(
//                                           fontSize: 13.sp),
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 66.w,
//                                     height: 45.h,
//                                     alignment: Alignment.centerLeft,
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Text(
//                                       snapshot.data!.dataCollection.d
//                                           .data[index].high
//                                           .toString(),
//                                       style: tableRowStyle.copyWith(
//                                           fontSize: 13.sp),
//                                     ),
//                                   ),
//                                   // Low
//                                   Container(
//                                     width: 66.w,
//                                     height: 45.h,
//                                     alignment: Alignment.centerLeft,
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Text(
//                                       snapshot.data!.dataCollection.d
//                                           .data[index].low
//                                           .toString(),
//                                       style: tableRowStyle.copyWith(
//                                           fontSize: 13.sp),
//                                     ),
//                                   ),

//                                   // PClose
//                                   Container(
//                                     width: 66.w,
//                                     height: 45.h,
//                                     alignment: Alignment.centerLeft,
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Text(
//                                       snapshot.data!.dataCollection.d
//                                           .data[index].pltp
//                                           .toString(),
//                                       style: tableRowStyle.copyWith(
//                                           fontSize: 13.sp),
//                                     ),
//                                   ),

//                                   // Notification Icon
//                                   FutureBuilder<GetSavedWatchlistAlertResponse>(
//                                       future: _dioWatchList
//                                           .getInitialWatchlistAlertInfo(),
//                                       builder: (context, snapshot) {
//                                         if (!snapshot.hasData) {
//                                           return Container();
//                                         } else {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               Navigator.popAndPushNamed(context,
//                                                   AddStockAlertScreen.routeName,
//                                                   arguments: {
//                                                     "symbol": snapshot
//                                                         .data!
//                                                         .dataCollection
//                                                         .d
//                                                         .alert[index]
//                                                         .stockSymbol,
//                                                     "companyID": snapshot
//                                                         .data!
//                                                         .dataCollection
//                                                         .d
//                                                         .alert[index]
//                                                         .companyId,
//                                                     "increasePrice": snapshot
//                                                         .data
//                                                         ?.dataCollection
//                                                         .d
//                                                         .alert[index]
//                                                         .increasePrice,
//                                                     "decreasePrice": snapshot
//                                                         .data
//                                                         ?.dataCollection
//                                                         .d
//                                                         .alert[index]
//                                                         .decreasePrice,
//                                                     "emailIncrease": snapshot
//                                                         .data
//                                                         ?.dataCollection
//                                                         .d
//                                                         .alert[index]
//                                                         .sendEmailOnIncrease,
//                                                     "emailDecrease": snapshot
//                                                         .data
//                                                         ?.dataCollection
//                                                         .d
//                                                         .alert[index]
//                                                         .sendEmailOnDecrease,
//                                                   });
//                                             },
//                                             child: Container(
//                                               width: 40.w,
//                                               height: 45.h,
//                                               alignment: Alignment.centerLeft,
//                                               padding:
//                                                   EdgeInsets.only(left: 5.w),
//                                               child: const Icon(
//                                                   Icons.notifications,
//                                                   size: 25,
//                                                   color: Colors.white),
//                                             ),
//                                           );
//                                         }
//                                       }),

//                                   // Delete Icon
//                                   GestureDetector(
//                                     onTap: () async {
//                                       await showDialog(
//                                         context: context,
//                                         builder: (_) => AlertDialog(
//                                           content: const Text(
//                                               "Are you sure you want to delete?"),
//                                           actions: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 CustomButton(
//                                                     onPressed: () async {
//                                                       await _dioWatchList
//                                                           .deleteWatchlist(
//                                                         DeleteRequestWatchlist(
//                                                             userId: await SecureStorage()
//                                                                 .readData(
//                                                                     key:
//                                                                         saveUserID),
//                                                             companyId: snapshot
//                                                                 .data!
//                                                                 .dataCollection
//                                                                 .d
//                                                                 .data[index]
//                                                                 .companyId),
//                                                       );
//                                                       setState(() {
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                       });
//                                                     },
//                                                     bgColor:
//                                                         GlobalVariablesColor
//                                                             .mainColor,
//                                                     borderColor:
//                                                         GlobalVariablesColor
//                                                             .mainColor,
//                                                     textSize: 15.sp,
//                                                     textColor: Colors.white,
//                                                     text: "Yes",
//                                                     width: 80,
//                                                     height: 30),
//                                                 const SizedBox(width: 5),
//                                                 CustomButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     },
//                                                     bgColor: Colors.grey,
//                                                     borderColor: Colors.grey,
//                                                     textSize: 15.sp,
//                                                     textColor: Colors.black,
//                                                     text: "No",
//                                                     width: 80,
//                                                     height: 30),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                         width: 40.w,
//                                         height: 45.h,
//                                         alignment: Alignment.centerLeft,
//                                         padding: EdgeInsets.only(left: 5.w),
//                                         child: const Icon(Icons.delete,
//                                             size: 25, color: Colors.white)),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//         });
//   }
// }
