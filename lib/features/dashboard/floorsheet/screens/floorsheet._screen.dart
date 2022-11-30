import 'package:biz_alert/common/services/hivemodel.dart';
import 'package:biz_alert/common/widgets/custom_app_bar.dart';
import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:biz_alert/features/dashboard/floorsheet/services/dio_floorsheet.dart';
import 'package:biz_alert/features/dashboard/live_market/widgets/error_screen.dart';
import 'package:biz_alert/models/response/floorsheet_res_model.dart';
import 'package:biz_alert/providers/theme_notifier_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class FloorSheetScreen extends StatefulWidget {
  static const String routeName = "/floor-sheet";
  const FloorSheetScreen({Key? key}) : super(key: key);

  @override
  State<FloorSheetScreen> createState() => _FloorSheetScreenState();
}

class _FloorSheetScreenState extends State<FloorSheetScreen> {
// Calling the floorsheet api
  int pageNumber = 1;
  Future<FloorsheetResModel?>? floorsheet;

  Future<FloorsheetResModel?>? getFloorSheet() async {
    FloorsheetResModel? floorsheetResModel =
        await DioFloorSheet().viewFloorSheet(pageNumber: pageNumber);
    return floorsheetResModel;
  }

  final PagingController<int, BrokerFloorsheetDatum> _pagingController =
      PagingController(firstPageKey: 1);
  double get size => MediaQuery.of(context).size.width;
  bool noMoreItems = false;

  //For Getting Buyer and Seller Broker Number
  String takeLetters(String name) {
    var first = name.split(" ");
    var result = first[0].substring(0, 2).contains("(")
        ? first[0].substring(0, 1)
        : first[0].substring(0, 2);

    return result;
  }

  // For Hive Local Database to get stock Info {used for stock symbol}
  StockDbModel stockSymbol = Hive.box(companyIdSymbol).get("stockInfo");
// For searching --
  bool isSymbolSearch = false;
  bool isBuyerSearch = false;
  bool isSellerSearch = false;
  final TextEditingController dropDownController = TextEditingController();
  final TextEditingController buyerController = TextEditingController();
  final TextEditingController sellerController = TextEditingController();
  // For DropDown
  var symbol_drop;
  // For Search
  String searchSymbol = "";
  String searchBuyer = "";
  String searchSeller = "";
// -- For searching

  @override
  void initState() {
    floorsheet = getFloorSheet();
    _pagingController.addPageRequestListener((pageKey) {
      _pageFetch(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: FutureBuilder<FloorsheetResModel?>(
            future: floorsheet,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CustomAppBar1(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Floorsheet",
                );
              } else {
                return CustomAppBar(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Floorsheet",
                  text1: snapshot.data!.dataCollection.data.floorsheetDate,
                );
              }
            }),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              // Search Fields
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),

                  // Searching via Symbol
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w),
                      height: 40.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        // color: GlobalVariablesColor.greyBackgroundCOlor,
                        border: Border.all(
                          color: GlobalVariablesColor.mainColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                            isExpanded: false,
                            hint: const Text(
                              'Select Symbol',
                              style: TextStyle(
                                fontSize: 14,
                                // color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: stockSymbol.dataCollection.map((e) {
                              return DropdownMenuItem(
                                value: e.stockSymbol,
                                child: Text(
                                  e.stockSymbol,
                                  style: dropDownStyle.copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
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
                            dropdownWidth: 160.w,
                            searchController: dropDownController,
                            searchInnerWidget: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
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
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Search via Buyer Broker
                  //Buyer Broker
                  SizedBox(
                    width: 80.w,
                    height: 40.h,
                    child: TextFormField(
                      controller: buyerController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.solid,
                              color: GlobalVariablesColor.mainColor),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: GlobalVariablesColor.mainColor)),
                        // fillColor: GlobalVariablesColor.greyBackgroundCOlor,
                        filled: true,
                        hintText: 'BB Code',
                        hintStyle: TextStyle(fontSize: 14.sp),
                        labelStyle: dropDownStyle.copyWith(
                            fontSize: 13.sp, fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //Seller Broker
                  SizedBox(
                    width: 80.w,
                    height: 40.h,
                    child: TextFormField(
                      controller: sellerController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.solid,
                              color: GlobalVariablesColor.mainColor),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: GlobalVariablesColor.mainColor)),
                        // fillColor: GlobalVariablesColor.greyBackgroundCOlor,
                        filled: true,
                        hintText: 'SB Code',
                        hintStyle: TextStyle(fontSize: 14.sp),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  // Filter Search Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (searchSymbol.isNotEmpty) {
                          isSymbolSearch = true;
                        } else {
                          isSymbolSearch == false;
                        }
                        if (buyerController.text.trim().isNotEmpty) {
                          searchBuyer = buyerController.text.trim();
                          isBuyerSearch = true;
                        } else {
                          searchBuyer = "";
                          isBuyerSearch = false;
                        }
                        if (sellerController.text.trim().isNotEmpty) {
                          searchSeller = sellerController.text.trim();
                          isSellerSearch = true;
                        } else {
                          searchSeller = "";
                          isSellerSearch = false;
                        }
                      });
                    },
                    child: Container(
                      width: 80.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: GlobalVariablesColor.mainColor),
                        // color: GlobalVariablesColor.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp),
                          ),
                          Icon(
                            Icons.search,
                            color: Provider.of<ThemeNotifier>(context)
                                        .getTheme() ==
                                    darkTheme
                                ? Colors.white
                                : Colors.black,
                            size: 17.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Reset Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSymbolSearch = false;
                        isBuyerSearch = false;
                        isSellerSearch = false;
                        searchSymbol = "";
                        searchBuyer = "";
                        searchSeller = "";
                        symbol_drop = null;
                        buyerController.clear();
                        sellerController.clear();
                      });
                    },
                    child: Container(
                      width: 80.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: GlobalVariablesColor.mainColor),
                        // color: GlobalVariablesColor.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Reset",
                            style: TextStyle(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp),
                          ),
                          Icon(
                            Icons.restart_alt_sharp,
                            color: Provider.of<ThemeNotifier>(context)
                                        .getTheme() ==
                                    darkTheme
                                ? Colors.white
                                : Colors.black,
                            size: 17.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // Full Table of Floorsheet
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => _pagingController.refresh(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _getTitleWidget(context),
                        Expanded(
                          child: PagedListView<int, BrokerFloorsheetDatum>(
                            pagingController: _pagingController,
                            shrinkWrap: true,
                            builderDelegate: PagedChildBuilderDelegate<
                                BrokerFloorsheetDatum>(
                              itemBuilder: (context, item, index) => isSymbolSearch == false &&
                                      isBuyerSearch == false &&
                                      isSellerSearch == false
                                  ? _singleItem(context, item, index)
                                  : isSymbolSearch == true &&
                                          isBuyerSearch == false &&
                                          isSellerSearch == false &&
                                          item.companyName
                                              .contains(searchSymbol)
                                      ? _singleItem(context, item, index)
                                      : isSymbolSearch == false &&
                                              isBuyerSearch == true &&
                                              isSellerSearch == false &&
                                              item.buyerBrokerNo
                                                  .contains(searchBuyer)
                                          ? _singleItem(context, item, index)
                                          : isSymbolSearch == false &&
                                                  isBuyerSearch == false &&
                                                  isSellerSearch == true &&
                                                  item.sellerBrokerNo
                                                      .contains(searchSeller)
                                              ? _singleItem(
                                                  context, item, index)
                                              : isSymbolSearch == true &&
                                                      isBuyerSearch == true &&
                                                      isSellerSearch == false &&
                                                      item.companyName.contains(
                                                          searchSymbol) &&
                                                      item.buyerBrokerNo
                                                          .contains(searchBuyer)
                                                  ? _singleItem(
                                                      context, item, index)
                                                  : isSymbolSearch == true &&
                                                          isBuyerSearch ==
                                                              false &&
                                                          isSellerSearch ==
                                                              true &&
                                                          item.companyName.contains(
                                                              searchSymbol) &&
                                                          item.sellerBrokerNo
                                                              .contains(
                                                                  searchSeller)
                                                      ? _singleItem(
                                                          context, item, index)
                                                      : isSymbolSearch == false &&
                                                              isBuyerSearch ==
                                                                  true &&
                                                              isSellerSearch ==
                                                                  true &&
                                                              item.buyerBrokerNo.contains(
                                                                  searchBuyer) &&
                                                              item.sellerBrokerNo
                                                                  .contains(searchSeller)
                                                          ? _singleItem(context, item, index)
                                                          : isSymbolSearch == true && isBuyerSearch == true && isSellerSearch == true && item.companyName.contains(searchSymbol) && item.buyerBrokerNo.contains(searchBuyer) && item.sellerBrokerNo.contains(searchSeller)
                                                              ? _singleItem(context, item, index)
                                                              : Container(),

                              firstPageErrorIndicatorBuilder: (context) =>
                                  ErrorScreen(
                                errorMessage: _pagingController.error,
                                callback: () {
                                  _pagingController.refresh();
                                },
                              ),
                              // firstPageProgressIndicatorBuilder: (context) =>
                              //     const CircularProgressIndicator(),
                              // newPageProgressIndicatorBuilder: (context) =>
                              //     const CircularProgressIndicator(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom Container to show total amount and total quantity
          Container(
            color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Colors.black
                : Colors.white,
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<FloorsheetResModel?>(
                future: floorsheet,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       margin: const EdgeInsets.only(left: 10),
                    //       height: 62,
                    //       width: MediaQuery.of(context).size.width / 2.3,
                    //       decoration: BoxDecoration(
                    //         color: GlobalVariablesColor.greyBackgroundCOlor,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Text(
                    //         "Total Quantity",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //             fontSize: 18.sp,
                    //             color: GlobalVariablesColor.mainColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: const EdgeInsets.only(right: 10),
                    //       height: 62,
                    //       width: MediaQuery.of(context).size.width / 2.3,
                    //       decoration: BoxDecoration(
                    //         color: GlobalVariablesColor.greyBackgroundCOlor,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Text(
                    //         "Total Amount",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //             fontSize: 18.sp,
                    //             color: GlobalVariablesColor.mainColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ],
                    // );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 62,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: GlobalVariablesColor.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Quantity",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.dataCollection.data
                                    .brokerFloorsheetPage[0].totalQuantity
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
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
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 62,
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: GlobalVariablesColor.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "Rs. ${snapshot.data!.dataCollection.data.brokerFloorsheetPage[0].totalAmount.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
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
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _pageFetch(int pageKey) async {
    try {
      FloorsheetResModel? newPage =
          await DioFloorSheet().viewFloorSheet(pageNumber: pageKey);

      // final isLastPage = newPage!.dataCollection.isEmpty;
      List<BrokerFloorsheetDatum> newItems =
          newPage!.dataCollection.data.brokerFloorsheetData;

      // Checking whether the item from api is less than 100 or not so that I can now only append the data for last time and stop calling the api with next page number
      noMoreItems = newItems.length < 20;

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

  Widget _getTitleWidget(BuildContext context) {
    return Container(
      color: Colors.transparent.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(children: [
          // _singleLabelTextView("SN"),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: _singleLabelTextView("SYM"),
          ),
          _singleLabelTextView("BB"),
          _singleLabelTextView("SB"),
          _singleLabelTextView("QTY"),
          _singleLabelTextView("Rate"),
          _singleLabelTextView("Amount"),
        ]),
      ),
    );
  }

  Widget _singleItem(BuildContext context,
      BrokerFloorsheetDatum brokerFloorsheetDatum, index) {
    var color = index % 2 == 0
        ? GlobalVariablesColor.mainColor.withOpacity(0.2)
        : GlobalVariablesColor.mainColor.withOpacity(0.5);
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CompanyDetailScreen.routeName,
                arguments: brokerFloorsheetDatum.companyName);
          },
          child: Row(
            children: [
              // _singleItemTextView(brokerFloorsheetDatum.symbol),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: _singleItemTextView(brokerFloorsheetDatum.companyName),
              ),
              _singleItemTextView(
                  takeLetters(brokerFloorsheetDatum.buyerBrokerNo)),
              _singleItemTextView(
                  takeLetters(brokerFloorsheetDatum.sellerBrokerNo)),
              _singleItemTextView(brokerFloorsheetDatum.quantity.toString()),
              _singleItemTextView(brokerFloorsheetDatum.rate.toString()),
              _singleItemTextView(brokerFloorsheetDatum.amount.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singleLabelTextView(String text) {
    return SizedBox(
      width: size / 6.5,
      child: Text(text,
          style: TextStyle(
              color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),
          textAlign: TextAlign.start),
    );
  }

  Widget _singleItemTextView(String text) {
    return SizedBox(
      width: size / 6.5,
      child: Text(text,
          style:
              // Theme.of(context).textTheme.bodyText2?.apply(color: Colors.black),
              TextStyle(
                  color: Provider.of<ThemeNotifier>(context).getTheme() ==
                          darkTheme
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
          textAlign: TextAlign.start),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
