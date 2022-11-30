import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_watchlist_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/watchlist_screen.dart';
import 'package:biz_alert/models/response/saved_res%20_watchlist_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

import '../../../../models/request/del_req_watchlist.dart';
import '../../../../providers/theme_notifier_provider.dart';
import '../../companyDetail/screens/company_detail_screen.dart';
import '../services/dio_watchlist.dart';

class SavedStockAlertScreen extends StatefulWidget {
  static const String routeName = '/saved-stock-alert';
  const SavedStockAlertScreen({Key? key}) : super(key: key);

  @override
  State<SavedStockAlertScreen> createState() => _SavedStockAlertScreenState();
}

class _SavedStockAlertScreenState extends State<SavedStockAlertScreen> {
  late DioWatchList _dioWatchList;

  @override
  void initState() {
    super.initState();
    _dioWatchList = DioWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.popAndPushNamed(context, WatchlistScreen.routeName);
          },
          text: "Stock Alert",
          icon2: Icons.add,
          onPressed2: () {
            Navigator.popAndPushNamed(
                context, AddStockWatchlistScreen.routeName);
          },
        ),
      ),
      body: stockAdded(),
    );
  }

  // Get Header Widget
  List<Widget> _getHeaderWidget() {
    return [
      _getHeaderItemWidget('Symbol'),
      _getHeaderItemWidget('Greater than'),
      _getHeaderItemWidget('Less than'),
      _getHeaderItemWidget(''),
      _getHeaderItemWidget(''),
    ];
  }

  Widget _getHeaderItemWidget(
    String label,
  ) {
    return Container(
      width: label == ""
          ? 40.w
          : label == "Greater than"
              ? 117.w
              : label == "Less than"
                  ? 115.w
                  : 80.w,
      height: 45.h,
      padding: EdgeInsets.only(left: 5.w),
      alignment: Alignment.centerLeft,
      color: Colors.transparent.withAlpha(10),
      child: Text(label,
          style: tableStyle.copyWith(
            fontSize: 18.sp,
            color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Colors.white
                : Colors.black,
          ),
          textAlign: TextAlign.center),
    );
  }

  // Share Price all data screen
  Widget stockAdded() {
    return FutureBuilder<GetSavedWatchlistAlertResponse>(
        future: _dioWatchList.getInitialWatchlistAlertInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.status == "Success") {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Table
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: HorizontalDataTable(
                        leftHandSideColBackgroundColor: Colors.transparent,
                        rightHandSideColBackgroundColor: Colors.transparent,
                        leftHandSideColumnWidth: 80.w,
                        rightHandSideColumnWidth: 312.w,
                        isFixedHeader: true,
                        headerWidgets: _getHeaderWidget(),
                        rowSeparatorWidget: const Divider(
                          color: Colors.transparent,
                          height: 1,
                          thickness: 1,
                        ),
                        elevation: 0,
                        verticalScrollbarStyle: const ScrollbarStyle(
                          isAlwaysShown: false,
                          thickness: 0.0,
                        ),
                        horizontalScrollbarStyle: const ScrollbarStyle(
                          isAlwaysShown: false,
                          thickness: 0.0,
                        ),
                        itemCount: snapshot.data!.dataCollection.d.alert.length,
                        // Symbol Name
                        leftSideItemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CompanyDetailScreen.routeName,
                                  arguments: snapshot.data!.dataCollection.d
                                      .alert[index].stockSymbol);
                            },
                            child: Container(
                              color: index % 2 == 0
                                  ? GlobalVariablesColor.mainColor
                                      .withOpacity(0.2)
                                  : GlobalVariablesColor.mainColor
                                      .withOpacity(0.5),
                              width: 80.w,
                              height: 45.h,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5.w),
                              child: Text(
                                snapshot.data!.dataCollection.d.alert[index]
                                    .stockSymbol,
                                style: stockAlertSyle.copyWith(
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
                            (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CompanyDetailScreen.routeName,
                                  arguments: snapshot.data!.dataCollection.d
                                      .alert[index].stockSymbol);
                            },
                            child: Container(
                              color: index % 2 == 0
                                  ? GlobalVariablesColor.mainColor
                                      .withOpacity(0.2)
                                  : GlobalVariablesColor.mainColor
                                      .withOpacity(0.5),
                              child: Row(
                                children: [
                                  // Greater than
                                  Container(
                                    width: 117.w,
                                    height: 45.h,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text(
                                      snapshot.data!.dataCollection.d
                                          .alert[index].increasePrice
                                          .toString(),
                                      style: stockAlertSyle.copyWith(
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),

                                  // Lesser than
                                  Container(
                                    width: 115.w,
                                    height: 45.h,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text(
                                      snapshot.data!.dataCollection.d
                                          .alert[index].decreasePrice
                                          .toString(),
                                      style: stockAlertSyle.copyWith(
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),

                                  // Notification Icon
                                  GestureDetector(
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
                                          Icons.notifications_outlined,
                                          size: 20,
                                          color: GlobalVariablesColor.mainColor,
                                        )),
                                  ),

                                  // Delete Icon
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          content: Text(
                                            "Are you sure?",
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
                                                                .alert[index]
                                                                .companyId),
                                                      );
                                                      setState(() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    bgColor:
                                                        GlobalVariablesColor
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
                                    },
                                    child: Container(
                                      width: 40.w,
                                      height: 45.h,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        size: 20,
                                        color: Colors.red,
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
                  ),
                ],
              );
            }
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Stock Alert Added!",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        });
  }
}
