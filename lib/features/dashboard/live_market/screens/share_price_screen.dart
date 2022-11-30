import 'package:biz_alert/common/services/dio_hive.dart';
import 'package:biz_alert/common/services/hive_sector_model.dart';
import 'package:biz_alert/common/services/hivemodel.dart';
import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/live_market_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/services/dio_live_market.dart';
import 'package:biz_alert/features/dashboard/live_market/widgets/error_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/widgets/top_header.dart';
import 'package:biz_alert/models/response/get_today_shareprice_res_model.dart'
    as share_price;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';

class SharePriceScreen extends StatefulWidget {
  static const String routeName = '/share-price';

  const SharePriceScreen({Key? key}) : super(key: key);

  @override
  State<SharePriceScreen> createState() => _SharePriceScreenState();
}

class _SharePriceScreenState extends State<SharePriceScreen> {
  static const int sortSymbol = 0;
  static const int sortLtp = 1;
  static const int sortHigh = 2;
  static const int sortLow = 3;
  static const int sortChangePercent = 4;
  bool isDescending = false;
  int sortType = sortSymbol;
  // For Hive Local Database to get stock Info {used for stock symbol}
  StockDbModel stockSymbol = Hive.box(companyIdSymbol).get("stockInfo");
  // StockSectorDbModel sectorName = Hive.box(sectorCompany).get("sectorInfo");

  Future<StockSectorDbModel?>? sector;
  Future<StockSectorDbModel?>? getSector() async {
    StockSectorDbModel? stockSectorDbModel = await DioHiveDB().viewSector();
    return stockSectorDbModel;
  }

// For searching --
  bool isSearchActivated = false;
  final TextEditingController dropDownController = TextEditingController();

  // For DropDown
  var symbol_drop;
  var sector_drop;

  // For selected transaction date
  DateTime? selectedTransactionDate;
  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        selectedTransactionDate = pickedDate;
      });
    });
  }

  // For Search
  String searchSymbol = "";
  String searchSector = "";
  // For Appending the Data in Today's Share Price --
  double get size => MediaQuery.of(context).size.width;

  final PagingController<int, share_price.DataCollection> _pagingController =
      PagingController(
    firstPageKey: 1,
  );

  bool noMoreItems = false;
  // --For Appending the Data in Today's Share Price

  @override
  void initState() {
    super.initState();
    sector = getSector();

    _pagingController.addPageRequestListener((pageKey) {
      _pageFetch(pageKey);
    });
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
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopHeader(
              // Live Market
              text: "Live Market",
              textColor: Colors.black,
              boxColor: Colors.grey[350],
              onPressed: () {
                Navigator.popAndPushNamed(context, LiveMarketScreen.routeName);
              },

              // Share Price
              text1: "Share Price",
              textColor1: Colors.white,
              boxColor1: GlobalVariablesColor.mainColor,
              onPressed1: () {},
            ),
            SizedBox(
              height: 15.h,
            ),
            //dropdown and search field
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Stock Symbol
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stock Symbol
                    Text(
                      "Stock Symbol",
                      style: styleTextFormField.copyWith(
                        fontSize: 13.sp,
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      height: 35.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius2)),
                        // color: Colors.white
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: false,
                          hint: const Text(
                            'Select Symbol',
                            style: TextStyle(
                                fontSize: 14,
                                color: GlobalVariablesColor.mainColor
                                // color: Theme.of(context).hintColor,
                                ),
                          ),
                          items: stockSymbol.dataCollection.map((e) {
                            return DropdownMenuItem(
                              value: e.stockSymbol,
                              child: Text(
                                e.stockSymbol,
                                style: dropDownStyle.copyWith(
                                    fontSize: 10.sp,
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            );
                          }).toList(),
                          value: symbol_drop,
                          onChanged: (newVal) async {
                            setState(() {
                              symbol_drop = newVal;
                              searchSymbol = symbol_drop;
                            });
                          },
                          // buttonHeight: 45,
                          // buttonWidth: 320.w,
                          itemHeight: 40,
                          dropdownMaxHeight: 300,
                          dropdownWidth: 150.w,
                          searchController: dropDownController,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              maxLines: 2,
                              controller: dropDownController,
                              decoration: InputDecoration(
                                isDense: true,
                                // contentPadding: const EdgeInsets.symmetric(
                                //   horizontal: 10,
                                //   vertical: 8,
                                // ),
                                hintText: 'Search Symbol...',
                                hintStyle: TextStyle(fontSize: 12.sp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .toLowerCase()
                                .contains(searchValue.toLowerCase()));
                          },
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              dropDownController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),

                // Transcation Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transaction Date",
                      style: styleTextFormField.copyWith(
                        fontSize: 13.sp,
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      height: 35.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius2)),
                        // color: Colors.white
                      ),
                      child: GestureDetector(
                        onTap: _pickDateDialog,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedTransactionDate ==
                                      null //ternary expression to check if date is null
                                  ? ''
                                  : ' ${DateFormat.yMMMd().format(selectedTransactionDate!)}',
                              style: dropDownStyle.copyWith(
                                  fontSize: 12.sp,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            const Align(
                              // alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.calendar_month,
                                size: 25,
                                color: GlobalVariablesColor.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),

                //Search
                Padding(
                  padding: EdgeInsets.only(top: 27.w),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        if (searchSymbol.isNotEmpty) {
                          isSearchActivated = true;
                        }
                      });
                    },
                    child: Icon(
                      Icons.search,
                      size: Dimensions.iconSize30,
                      color: GlobalVariablesColor.mainColor,
                    ),
                  ),
                ),
              ],
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: DataTable(columns: const [
            //         DataColumn(

            //           label: Text("123123"),
            //         ),
            //         DataColumn(
            //           label: Text("123123"),
            //         ),
            //         DataColumn(
            //           label: Text("123123"),
            //         ),
            //         DataColumn(
            //           label: Text("123123"),
            //         ),
            //         DataColumn(
            //           label: Text("123123"),
            //         ),
            //         DataColumn(
            //           label: Text("123123"),
            //         ),
            //       ], rows: const [
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //             DataCell(
            //               Text("321321"),
            //             ),
            //           ],
            //         ),
            //       ]),
            //     ),
            //   ),
            // ),
            sharePriceList(),
          ],
        ),
      ),
    );
  }

  // Share Price all data screen
  sharePriceList() {
    return Expanded(
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          _getTitleWidget(context),
          SizedBox(
            height: 680.h,
            child: PagedListView<int, share_price.DataCollection>(
              pagingController: _pagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<share_price.DataCollection>(
                itemBuilder: (context, item, index) {
                  return isSearchActivated == false
                      ? StatefulBuilder(
                          builder: ((context, setState) {
                            setState(
                              () {
                                switch (sortType) {
                                  case sortSymbol:
                                    _pagingController.itemList!.sort(
                                      ((a, b) {
                                        return isDescending
                                            ? b.symbol.compareTo(a.symbol)
                                            : a.symbol.compareTo(b.symbol);
                                      }),
                                    );

                                    break;

                                  case sortLtp:
                                    _pagingController.itemList!.sort(
                                      ((a, b) {
                                        return isDescending
                                            ? double.parse(b.lastTradePrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  a.lastTradePrice
                                                      .replaceAll(",", ""),
                                                ),
                                              )
                                            : double.parse(a.lastTradePrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  b.lastTradePrice
                                                      .replaceAll(",", ""),
                                                ),
                                              );
                                      }),
                                    );
                                    break;
                                  case sortHigh:
                                    _pagingController.itemList!.sort(
                                      ((a, b) {
                                        return isDescending
                                            ? double.parse(b.highestPrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  a.highestPrice
                                                      .replaceAll(",", ""),
                                                ),
                                              )
                                            : double.parse(a.highestPrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  b.highestPrice
                                                      .replaceAll(",", ""),
                                                ),
                                              );
                                      }),
                                    );
                                    break;
                                  case sortLow:
                                    _pagingController.itemList!.sort(
                                      ((a, b) {
                                        return isDescending
                                            ? double.parse(b.lowestPrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  a.lowestPrice
                                                      .replaceAll(",", ""),
                                                ),
                                              )
                                            : double.parse(a.lowestPrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  b.lowestPrice
                                                      .replaceAll(",", ""),
                                                ),
                                              );
                                      }),
                                    );
                                    break;
                                  case sortChangePercent:
                                    _pagingController.itemList!.sort(
                                      ((a, b) {
                                        return isDescending
                                            ? double.parse(b
                                                    .percentageChangeInPrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  a.percentageChangeInPrice
                                                      .replaceAll(",", ""),
                                                ),
                                              )
                                            : double.parse(a
                                                    .percentageChangeInPrice
                                                    .replaceAll(",", ""))
                                                .compareTo(
                                                double.parse(
                                                  b.percentageChangeInPrice
                                                      .replaceAll(",", ""),
                                                ),
                                              );
                                      }),
                                    );
                                    break;

                                  default:
                                    _pagingController.itemList!.sort(
                                      ((a, b) {
                                        return a.symbol.compareTo(b.symbol);
                                      }),
                                    );
                                }
                              },
                            );
                            return _singleItem(context, item, index);
                          }),
                        )
                      : item.symbol.contains(searchSymbol)
                          ? _singleItem(context, item, index)
                          : Container();
                },
                firstPageErrorIndicatorBuilder: (context) => ErrorScreen(
                  errorMessage: _pagingController.error,
                  callback: () {
                    _pagingController.refresh();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _pageFetch(int pageKey) async {
    try {
      share_price.GetTodaysSharePriceResponseModel? newPage =
          await DioLiveMarketTrading().viewTodaySharePrice(pageNumber: pageKey);

      // final isLastPage = newPage!.dataCollection.isEmpty;
      List<share_price.DataCollection> newItems = newPage!.dataCollection;

      // Checking whether the item from api is less than 100 or not so that I can now only append the data for last time and stop calling the api with next page number
      noMoreItems = newItems.length < 100;

      if (noMoreItems) {
        // 3
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // 4
      _pagingController.error = error;
    }
  }

  // Future<void> _pageSort(int pageKey) async {
  //   try {
  //     share_price.GetTodaysSharePriceResponseModel? newPage =
  //         await DioLiveMarketTrading().viewTodaySharePrice(pageNumber: pageKey);

  //     // final isLastPage = newPage!.dataCollection.isEmpty;
  //     List<share_price.DataCollection> newItems = newPage!.dataCollection;

  //     // Checking whether the item from api is less than 100 or not so that I can now only append the data for last time and stop calling the api with next page number
  //     noMoreItems = newItems.length < 100;

  //     if (noMoreItems) {
  //       // 3
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //       log(_pagingController.itemList!.last.symbol);
  //     }
  //   } catch (error) {
  //     // 4
  //     _pagingController.error = error;
  //   }
  // }

  Widget _getTitleWidget(BuildContext context) {
    return Container(
      // width: 75.w,
      height: 35.h,
      color: Colors.transparent.withAlpha(10),
      child: Row(children: [
        InkWell(
            onTap: () async {
              setState(() {
                isDescending = !isDescending;
                sortType = sortSymbol;
              });
              // log(_pagingController.itemList!.last.companyName);
            },
            child: _singleLabelTextView("SYM", Icons.unfold_more)),
        InkWell(
            onTap: () {
              setState(() {
                isDescending = !isDescending;
                sortType = sortLtp;
              });
            },
            child: _singleLabelTextView("LTP", Icons.unfold_more)),
        InkWell(
            onTap: () {
              setState(() {
                isDescending = !isDescending;
                sortType = sortHigh;
              });
            },
            child: _singleLabelTextView("High", Icons.unfold_more)),
        InkWell(
            onTap: () {
              setState(() {
                isDescending = !isDescending;
                sortType = sortLow;
              });
            },
            child: _singleLabelTextView("Low", Icons.unfold_more)),
        // _singleLabelTextView("CH"),
        InkWell(
            onTap: () {
              setState(() {
                isDescending = !isDescending;
                sortType = sortChangePercent;
              });
            },
            child: _singleLabelTextView("CH%", Icons.unfold_more)),
        // _singleLabelTextView("PClose"),
      ]),
    );
  }

  Widget _singleItem(
      BuildContext context, share_price.DataCollection dataCollection, index) {
    var color = double.parse(dataCollection.percentageChangeInPrice) > 0
        ? Colors.green
        : double.parse(dataCollection.percentageChangeInPrice) < 0
            ? Colors.red
            : Colors.blue;
    // var change = double.parse(dataCollection.perviousClose) -
    //     double.parse(dataCollection.lastTradePrice);
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                arguments: dataCollection.symbol);
          },
          child: Row(
            children: [
              _singleItemTextView(dataCollection.symbol),
              _singleItemTextView(dataCollection.lastTradePrice),
              _singleItemTextView(dataCollection.highestPrice),
              _singleItemTextView(dataCollection.lowestPrice),
              // _singleItemTextView(change.toString()),
              _singleItemTextView(
                  "${dataCollection.percentageChangeInPrice} %"),
              // _singleItemTextView(dataCollection.perviousClose),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singleLabelTextView(String text, IconData ic) {
    return SizedBox(
      width: size / 5.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: [
            Text(text,
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
        ),
      ),
    );
  }

  Widget _singleItemTextView(String text) {
    return SizedBox(
      width: size / 5.5,
      child: Text(text,
          style: tableRowStyle.copyWith(
              fontSize: 10.sp,
              color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.white
                  : Colors.black),
          // Theme.of(context).textTheme.bodyText2?.apply(color: Colors.black),
          // TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.w500,
          //     fontSize: 15.sp),
          textAlign: TextAlign.center),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchSector;
    searchSymbol;
    sector_drop;
    symbol_drop;
    _pagingController.dispose();
    // Hive.box(companyIdSymbol).compact();
    // Hive.close();
  }
}
