import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/portfolio_chart_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/models/response/delete_purchase_api_res_model.dart';
import 'package:biz_alert/models/response/delete_purchase_stock_res_model.dart'
    as dps;
import 'package:biz_alert/models/response/delete_sell_stock_res_model.dart'
    as dss;
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class DeletePortfolioScreen extends StatefulWidget {
  static const String routeName = "/delete-portfolio-screen";
  final String portfolioID;
  final String shareHolderID;
  final String companyID;
  const DeletePortfolioScreen(
      {Key? key,
      required this.portfolioID,
      required this.shareHolderID,
      required this.companyID})
      : super(key: key);

  @override
  State<DeletePortfolioScreen> createState() => _DeletePortfolioScreenState();
}

class _DeletePortfolioScreenState extends State<DeletePortfolioScreen> {
  // Navigator for deletedSuccessfully
  void deletedSuccessfully() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Deleted Successfully"),
      ),
    );
    Navigator.pop(context);
  }

  // Navigator for not deletedSuccessfully
  void notDeleted() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            "Could not delete transaction. This transaction has a sales history"),
      ),
    );
    Navigator.pop(context);
  }

  //Delete Purchased Share Api
  Future<DeletePurchaseApiResponseModel?>? deletePurchaseApi(
      String userTransactionID) async {
    DeletePurchaseApiResponseModel? deletePurchaseApiResponseModel =
        await DioPortfolioChart()
            .deletePurchaseStockApi(userTransactionID: userTransactionID);
    if (deletePurchaseApiResponseModel!.message ==
        "Transaction deleted successfully") {
      deletedSuccessfully();
      // For reloading the api after deleting
      setState(() {
        deletePurchaseApiResponseModel;
      });
    } else {
      notDeleted();
    }
    return deletePurchaseApiResponseModel;
  }

  //Delete Sell Share Api
  Future<DeletePurchaseApiResponseModel?>? deleteSellApi(
      String userTransactionID) async {
    DeletePurchaseApiResponseModel? deleteSellApiResponseModel =
        await DioPortfolioChart()
            .deleteSellStockApi(userTransactionID: userTransactionID);
    if (deleteSellApiResponseModel!.message ==
        "Transaction deleted successfully") {
      deletedSuccessfully();
      // For reloading the api after deleting
      setState(() {
        deleteSellApiResponseModel;
      });
    } else {
      notDeleted();
    }
    return deleteSellApiResponseModel;
  }

  int purchasedPageNumber = 1;
  int soldPageNumber = 1;
  bool onRightClick = true;
  bool onLeftClick = true;
  // Purchased Data List
  Future<dps.DeletePurchaseStockResponseModel?>? getPurchased() async {
    dps.DeletePurchaseStockResponseModel? deletePurchaseStockResponseModel =
        await DioPortfolioChart().deletePurchaseStockList(
            portfolioID: widget.portfolioID,
            shareHolderID: widget.shareHolderID,
            symbolNumber: widget.companyID,
            pageNumber: purchasedPageNumber);
    return deletePurchaseStockResponseModel;
  }

  // Purchased Data List
  Future<dss.DeleteSellStockResponseModel?>? getSold() async {
    dss.DeleteSellStockResponseModel? deleteSellStockResponseModel =
        await DioPortfolioChart().deleteSellStockList(
            symbolNumber: widget.companyID, pageNumber: soldPageNumber);
    return deleteSellStockResponseModel;
  }

  @override
  void initState() {
    super.initState();
    getPurchased();
    getSold();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: GlobalVariablesColor.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomAppBar1(
            onPressed: () {
              Navigator.popAndPushNamed(
                  context, PortfolioChartScreen.routeName);
            },
            text: "Biz Protfolio",
            // Search Icon
            // icon1: Icons.search,
            // onPressed1: () {},

            tabs: TabBar(
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    // width: 400.w,
                    // height: 45.h,
                    child: Text(
                      'Purchase Share',
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
                      'Sell Share',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[700],
              indicator: const BubbleTabIndicator(
                indicatorHeight: 40,
                indicatorColor: GlobalVariablesColor.mainColor2,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                indicatorRadius: 2,
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Purchase List
            FutureBuilder<dps.DeletePurchaseStockResponseModel?>(
              future: getPurchased(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text(
                    "No any Data.",
                    style: TextStyle(
                        fontSize: 30, color: GlobalVariablesColor.mainColor1),
                  ));
                } else {
                  return purchaseList(snapshot.data!.dataCollection);
                }
              }),
            ),
            // Sell List
            FutureBuilder<dss.DeleteSellStockResponseModel?>(
              future: getSold(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text(
                    "No any Data.",
                    style: TextStyle(
                        fontSize: 30, color: GlobalVariablesColor.mainColor1),
                  ));
                } else {
                  return sellList(snapshot.data!.dataCollection!);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  // List of Purchased share Using HorizontalDataTable
  purchaseList(dps.DataCollection purchasedDataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table
        Expanded(
          flex: 3,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: HorizontalDataTable(
              leftHandSideColumnWidth: 80.w,
              rightHandSideColumnWidth: 360.w,
              isFixedHeader: true,
              // enablePullToRefresh: true,
              headerWidgets: _getPurchasedHeaderWidget(),
              rowSeparatorWidget: const Divider(
                color: Colors.white,
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
              itemCount: purchasedDataList.purchaseShare.length,
              // Symbol Name
              leftSideItemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 80.w,
                  height: 45.h,
                  color: index % 2 == 0
                      ? GlobalVariablesColor.mainColor1.withOpacity(0.5)
                      : GlobalVariablesColor.mainColor2.withOpacity(0.5),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    purchasedDataList.purchaseShare[index].stockSymbol,
                    style: stockAlertSyle,
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, int index) {
                return Container(
                  color: index % 2 == 0
                      ? GlobalVariablesColor.mainColor1.withOpacity(0.5)
                      : GlobalVariablesColor.mainColor2.withOpacity(0.5),
                  child: Row(
                    children: [
                      // Quantity
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 100.w,
                        height: 45.h,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          purchasedDataList.purchaseShare[index].quantity,
                          style: stockAlertSyle,
                        ),
                      ),
                      // Rem Quantity
                      Container(
                        width: 120.w,
                        height: 45.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          purchasedDataList.purchaseShare[index].remQuantity,
                          style: stockAlertSyle,
                        ),
                      ),
                      // Rate
                      Container(
                        width: 80.w,
                        height: 45.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          purchasedDataList.purchaseShare[index].rate,
                          style: stockAlertSyle,
                        ),
                      ),
                      // Delete Icon
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Text(
                                "Are you sure?",
                                style: styleTextFormField.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.sp),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                        onPressed: () {
                                          deletePurchaseApi(purchasedDataList
                                              .purchaseShare[index]
                                              .userTransactionId);
                                        },
                                        bgColor: GlobalVariablesColor.mainColor,
                                        borderColor:
                                            GlobalVariablesColor.mainColor,
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
                          width: 60.w,
                          height: 45.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 5.w),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        // Pagination Function
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Arrow
              GestureDetector(
                onTap: () {
                  if (purchasedPageNumber == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No More Going Back."),
                      ),
                    );
                    setState(() {
                      onLeftClick = false;
                    });
                  } else {
                    setState(() {
                      purchasedPageNumber = purchasedPageNumber - 1;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariablesColor.mainColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),

              // Page Number
              Text(
                purchasedPageNumber.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),

              const SizedBox(
                width: 40,
              ),
              // Forward Arrow
              GestureDetector(
                onTap: () {
                  if (purchasedPageNumber == purchasedDataList.totalPage) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All Data Fetched."),
                      ),
                    );
                    setState(() {
                      onRightClick = false;
                    });
                  } else {
                    setState(() {
                      purchasedPageNumber = purchasedPageNumber + 1;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariablesColor.mainColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Get Header Widget for Purchased Share
  List<Widget> _getPurchasedHeaderWidget() {
    return [
      _getPurchasedHeaderItemWidget('Symbol'),
      _getPurchasedHeaderItemWidget('Quantity'),
      _getPurchasedHeaderItemWidget('Rem Quantity'),
      _getPurchasedHeaderItemWidget('Rate'),
      _getPurchasedHeaderItemWidget(''),
    ];
  }

  _getPurchasedHeaderItemWidget(String label) {
    return Container(
      width: label == ""
          ? 60.w
          : label == "Symbol"
              ? 100.w
              : label == "Quantity"
                  ? 100.w
                  : label == "Rem Quantity"
                      ? 120.w
                      : 80.w,
      height: 45.h,
      padding: EdgeInsets.only(left: 5.w),
      alignment: Alignment.centerLeft,
      color: Colors.blue[300],
      child: Text(label,
          style: tableStyle.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center),
    );
  }

  // List of sold share
  sellList(dss.DataCollection soldDataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table
        Expanded(
          flex: 3,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: HorizontalDataTable(
              leftHandSideColumnWidth: 80.w,
              rightHandSideColumnWidth: 317.w,
              isFixedHeader: true,
              // enablePullToRefresh: true,
              headerWidgets: _getSoldHeaderWidget(),
              rowSeparatorWidget: const Divider(
                color: Colors.white,
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
              itemCount: soldDataList.soldShare!.length,
              // Symbol Name
              leftSideItemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 80.w,
                  height: 45.h,
                  color: index % 2 == 0
                      ? GlobalVariablesColor.mainColor1.withOpacity(0.5)
                      : GlobalVariablesColor.mainColor2.withOpacity(0.5),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    soldDataList.soldShare![index].stockSymbol!,
                    style: stockAlertSyle,
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, int index) {
                return Container(
                  color: index % 2 == 0
                      ? GlobalVariablesColor.mainColor1.withOpacity(0.5)
                      : GlobalVariablesColor.mainColor2.withOpacity(0.5),
                  child: Row(
                    children: [
                      // Quantity
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 130.w,
                        height: 45.h,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          soldDataList.soldShare![index].quantity!,
                          style: stockAlertSyle,
                        ),
                      ),

                      // Rate
                      Container(
                        width: 125.w,
                        height: 45.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          soldDataList.soldShare![index].rate!,
                          style: stockAlertSyle,
                        ),
                      ),
                      // Delete Icon
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Text(
                                "Are you sure?",
                                style: styleTextFormField.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.sp),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                        onPressed: () {
                                          deleteSellApi(soldDataList
                                              .soldShare![index]
                                              .userTransactionId!);
                                        },
                                        bgColor: GlobalVariablesColor.mainColor,
                                        borderColor:
                                            GlobalVariablesColor.mainColor,
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
                          width: 60.w,
                          height: 45.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 5.w),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        // Pagination Function
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Arrow
              GestureDetector(
                onTap: () {
                  if (soldPageNumber == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No More Going Back."),
                      ),
                    );
                    setState(() {
                      onLeftClick = false;
                    });
                  } else {
                    setState(() {
                      soldPageNumber = soldPageNumber - 1;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariablesColor.mainColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              // Page Number
              Text(
                soldPageNumber.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 40,
              ),
              // Forward Arrow
              GestureDetector(
                onTap: () {
                  if (soldPageNumber == soldDataList.totalPage) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All Data Fetched."),
                      ),
                    );
                    setState(() {
                      onRightClick = false;
                    });
                  } else {
                    setState(() {
                      soldPageNumber = soldPageNumber + 1;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariablesColor.mainColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Get Header Widget for Sold Share
  List<Widget> _getSoldHeaderWidget() {
    return [
      _getSoldHeaderItemWidget('Symbol'),
      _getSoldHeaderItemWidget('Quantity'),
      _getSoldHeaderItemWidget('Rate'),
      _getSoldHeaderItemWidget(''),
    ];
  }

  _getSoldHeaderItemWidget(String label) {
    return Container(
      width: label == ""
          ? 60.w
          : label == "Symbol"
              ? 80.w
              : label == "Quantity"
                  ? 130.w
                  : 125.w,
      height: 45.h,
      padding: EdgeInsets.only(left: 5.w),
      alignment: Alignment.centerLeft,
      color: Colors.blue[300],
      child: Text(label,
          style: tableStyle.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center),
    );
  }
}
