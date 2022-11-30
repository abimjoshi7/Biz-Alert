import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/common/widgets/custom_text_field.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/portfolio_chart_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/models/request/purchase_transaction_req.dart';
import 'package:biz_alert/models/request/sell_stock_req_model.dart';
import 'package:biz_alert/models/response/get_portfolio_res_model.dart';
import 'package:biz_alert/models/response/get_shareholder_res.dart';
import 'package:biz_alert/models/response/sell_stock_res_model.dart';
import 'package:biz_alert/models/response/sell_stock_res_model.dart'
    as share_calculation;
import 'package:biz_alert/models/response/show_balance_shares_res_model.dart';
import 'package:biz_alert/providers/get_portfolio_provider.dart';
import 'package:biz_alert/providers/get_shareholder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SellStockScreen extends StatefulWidget {
  static const String routeName = 'sell-stock';
  final String stockSymbol;
  final String companyId;

  const SellStockScreen(
      {Key? key, required this.stockSymbol, required this.companyId})
      : super(key: key);

  @override
  State<SellStockScreen> createState() => _SellStockScreenState();
}

class _SellStockScreenState extends State<SellStockScreen> {
  final sellStockKey = GlobalKey<FormState>();
  final sellStock = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); //Used for multiple of same textformfield
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<TextEditingController> yourQuantityController = [];

  Future<GetPortfolioResponseModel>? portfolioData;
  Future<GetShareHolderResponseModel>? shareHolderData;

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

  // For Radio Button
  int val = 1;

  // To store the list of array after user selects the quantity to sell
  List userTransID = [];

  @override
  void initState() {
    super.initState();

    final portofolioId = Provider.of<PortfolioProvider>(context, listen: false);
    portfolioData = portofolioId.getPortfolio();

    final shareHolderId =
        Provider.of<ShareHolderProvider>(context, listen: false);
    shareHolderData = shareHolderId.getShareHolder();
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final portfolioId =
        Provider.of<PortfolioProvider>(context).getPortfolioModel;
    final shareHolderId =
        Provider.of<ShareHolderProvider>(context).getShareHolderModel;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: GlobalVariablesColor.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar1(
            onPressed: () {
              Navigator.popAndPushNamed(
                  context, PortfolioChartScreen.routeName);
            },
            text: "Sell Stock",
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: sellStockKey,
              child: Column(
                children: [
                  // Stock Symbol
                  Container(
                    margin: EdgeInsets.only(right: 230.w),
                    child: Text(
                      "Stock Symbol",
                      style: styleTextFormField,
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    height: 45.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius2)),
                        color: Colors.white),
                    child: Text(
                      widget.stockSymbol,
                      style: styleTextFormField.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 18.sp),
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),
                  // Quantity
                  Container(
                    margin: EdgeInsets.only(right: 260.w),
                    child: Text(
                      "Quantity",
                      style: styleTextFormField,
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  InkWell(
                    onTap: () async {
                      var res = await DioPortfolioChart().getBalanceShares(
                        companyId: widget.companyId,
                        shareHolderId:
                            shareHolderId!.dataCollection[0].shareholderId,
                        portfolioId: portfolioId!.dataCollection[0].portfolioId,
                      );
                      if (!mounted) return;
                      if (res is BalanceSharesResponseModel) {
                        selectQuantity(
                            context, res.dataCollection!.balanceShares);
                      }
                      userTransID.clear();
                      yourQuantityController.clear();
                    },
                    child: IgnorePointer(
                      child: CustomTextField(
                        width: 320.w,
                        controller: quantityController,
                        hintText: '',
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // Price
                  Container(
                    margin: EdgeInsets.only(right: 280.w),
                    child: Text(
                      "Price",
                      style: styleTextFormField,
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  CustomTextField(
                    width: 320.w,
                    controller: priceController,
                    hintText: '',
                    type: TextInputType.number,
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // Transaction Date
                  Container(
                    margin: EdgeInsets.only(right: 210.w),
                    child: Text(
                      "Transaction Date",
                      style: styleTextFormField,
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  GestureDetector(
                    onTap: _pickDateDialog,
                    child: Container(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      height: 45.h,
                      width: 320.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius2)),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedTransactionDate ==
                                    null //ternary expression to check if date is null
                                ? ''
                                : ' ${DateFormat.yMMMd().format(selectedTransactionDate!)}',
                            style: dropDownStyle.copyWith(fontSize: 15.sp),
                          ),
                          const Align(
                            // alignment: Alignment.centerRight,

                            child: Icon(
                              Icons.calendar_month,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // CGT Percent or Radio Button
                  Container(
                    margin: EdgeInsets.only(right: 230.w),
                    child: Text(
                      "CGT Percent",
                      style: styleTextFormField,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24.w,
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: val,
                              onChanged: <int>(value) {
                                setState(() {
                                  val = value;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            Text(
                              '7.5%',
                              style: styleTextFormField,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: val,
                              onChanged: <int>(value) {
                                setState(() {
                                  val = value;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            Text(
                              '5%',
                              style: styleTextFormField,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // Save Button
                  sellStockSaveButton(),

                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Select Quantity
  // selectQuantity(context, List<BalanceShare>? balanceShare) {
  //   // yourQuantityController.text = balanceShare.balanceQuantity.toString();
  //   return AlertDialog(
  //     title: Center(
  //       child: Text(
  //         "Select Quantity",
  //         style: styleTextFormField.copyWith(fontSize: 18.sp),
  //       ),
  //     ),
  //     content: SizedBox(
  //       width: double.maxFinite,
  //       height: 150,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Expanded(
  //             child: Form(
  //               key: quantityStockKey,
  //               child: Column(
  //                 children: [
  //                   // Remaining Quantity
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         "Remaining Quantity",
  //                         style: styleTextFormField.copyWith(fontSize: 14.h),
  //                       ),
  //                       Text(
  //                         balanceShare.balanceQuantity.toString(),
  //                         style: styleTextFormField.copyWith(fontSize: 14.h),
  //                       ),
  //                     ],
  //                   ),
  //                   const Divider(
  //                     thickness: 1,
  //                     color: Colors.black,
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   // Rate
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         "Rate",
  //                         style: styleTextFormField.copyWith(fontSize: 14.h),
  //                       ),
  //                       Text(
  //                         balanceShare.rate!,
  //                         style: styleTextFormField.copyWith(fontSize: 14.h),
  //                       ),
  //                     ],
  //                   ),
  //                   const Divider(
  //                     thickness: 1,
  //                     color: Colors.black,
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   // Write the sell quantity
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Text(
  //                         "Your sell Quantity?",
  //                         style: styleTextFormField.copyWith(fontSize: 14.h),
  //                       ),
  // CustomTextField(
  //   controller: yourQuantityController,
  //   hintText: '',
  //   width: 100,
  //   type: TextInputType.number,
  // ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //     actions: [
  //       selectQuantitySaveButton(balanceShare.balanceQuantity),
  //     ],
  //   );
  // }

  selectQuantity(context, List<BalanceShare>? balanceShares) {
    for (var element in balanceShares!) {
      element.isClick = false;
    }
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
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
                  .bottom), //To move bottomsheet along with keyboard
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Title
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: GlobalVariablesColor.mainColor),
                      color: Colors.white),
                  child: Text(
                    "Select Quantity you want to sale",
                    style: styleTextFormField.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                    thickness: 1, color: GlobalVariablesColor.mainColor),
                // Starting of the quantity, rate selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Quantity",
                        style: styleTextFormField.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.w500)),
                    Text(
                      "Rate",
                      style: styleTextFormField.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: GlobalVariablesColor.mainColor,
                ),

                Expanded(
                  child: Form(
                    key: sellStock,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: balanceShares.length,
                      itemBuilder: (context, index) {
                        var model = balanceShares[index];
                        yourQuantityController.add(TextEditingController());
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Checkbox to select the quantity {Use of statefulbuilder to make changes inside modalsheet}
                                StatefulBuilder(
                                  builder: (context, StateSetter state) {
                                    return Checkbox(
                                      activeColor:
                                          GlobalVariablesColor.mainColor,
                                      value: model.isClick,
                                      onChanged: (value) {
                                        state(() {
                                          model.isClick = value;
                                        });
                                        setState(
                                          () {
                                            model.isClick = value;
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                //Balance Quantity
                                Text(model.balanceQuantity.toString()),

                                // TextField to sell as person wish
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    decoration:
                                        const InputDecoration().copyWith(
                                      labelText: '',
                                    ),
                                    style: styleTextFormField.copyWith(
                                        fontWeight: FontWeight.w400),
                                    keyboardType: TextInputType.number,
                                    controller: yourQuantityController[index],
                                    // Validating or checking the textField
                                    onChanged: (value) {
                                      if (yourQuantityController[index]
                                          .text
                                          .isNotEmpty) {
                                        sellStock.currentState!.validate();
                                      }
                                    },
                                    validator: (value) {
                                      if (yourQuantityController[index]
                                          .text
                                          .isEmpty) {
                                        return null;
                                      }
                                      if (model.balanceQuantity != null) {
                                        if (model.balanceQuantity! <
                                            int.tryParse(
                                                yourQuantityController[index]
                                                    .text)) {
                                          model.userSalesQty = 0;
                                          return 'Invalid Sales Quantity';
                                        } else if (0 ==
                                            int.tryParse(
                                                yourQuantityController[index]
                                                    .text)) {
                                          model.userSalesQty = int.tryParse(
                                              yourQuantityController[index]
                                                  .text);
                                          model.userSalesQty = 0;
                                          return 'Invalid Sales Quantity';
                                        } else {
                                          model.userSalesQty = int.tryParse(
                                              yourQuantityController[index]
                                                  .text);
                                          return null;
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),

                                // Rate
                                Text(model.rate!),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Save Button
                selectQuantitySaveButton(context, balanceShares),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Select Quantity Save Button
  selectQuantitySaveButton(context, List<BalanceShare> balanceShare) {
    // yourQuantityController.text = quantityController.text.isEmpty
    //     ? balanceQuantity.toString()
    //     : yourQuantityController.text;

    return CustomButton(
      onPressed: () async {
        // if (quantityStockKey.currentState!.validate()) {
        //   if (yourQuantityController.text.isEmpty) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text("Please choose valid quantity."),
        //       ),
        //     );
        //     return;
        //   } else if (int.parse(yourQuantityController.text) > balanceQuantity) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content:
        //         Text("Please enter number less than remaning quantity."),
        //   ),
        // );
        //     return;
        //   } else if (int.parse(yourQuantityController.text) == 0) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text("Please enter number greater than 0."),
        //   ),
        // );
        //     return;
        //   } else {
        //     quantityController.text = yourQuantityController.text;
        //     Navigator.pop(context);
        //   }
        // }

        int typedQuantity = 0;
        int selectedQuantity = 0;

        if (balanceShare.isNotEmpty == true) {
          for (var element in balanceShare) {
            // print(1);
            if (element.isClick == true) {
              // print(2);
              if (element.userSalesQty != null) {
                // print(3);
                typedQuantity =
                    typedQuantity + int.parse(element.userSalesQty.toString());
                userTransID.add({
                  "hdnUserTransactionID":
                      element.hdnUserTransactionID.toString(),
                  "hdnShareTypeID": element.hdnShareTypeID.toString(),
                  "hdnGainTaxRate": element.hdnGainTaxRate.toString(),
                  "ShareTypeCode": element.shareTypeCode,
                  "ShareTypeName": element.shareTypeName,
                  "dateAD": element.dateAD,
                  "dateBS": element.dateBS,
                  "TransactionNumber": element.transactionNumber,
                  "Quantity": element.quantity.toString(),
                  "balanceQuantity": element.balanceQuantity.toString(),
                  "Rate": element.rate,
                  "Broker": "",
                  "Portfolio": element.portfolio,
                  "Shareholder": element.shareholder,
                  "SalesQty": element.salesQty,
                  "hdnBasePrice": element.hdnBasePrice.toString(),
                  "userSalesQty": element.userSalesQty.toString(),
                });
              } else {
                // print(4);
                selectedQuantity = selectedQuantity +
                    int.parse(element.balanceQuantity.toString());
                userTransID.add({
                  "hdnUserTransactionID":
                      element.hdnUserTransactionID.toString(),
                  "hdnShareTypeID": element.hdnShareTypeID.toString(),
                  "hdnGainTaxRate": element.hdnGainTaxRate.toString(),
                  "ShareTypeCode": element.shareTypeCode,
                  "ShareTypeName": element.shareTypeName,
                  "dateAD": element.dateAD,
                  "dateBS": element.dateBS,
                  "TransactionNumber": element.transactionNumber,
                  "Quantity": element.quantity.toString(),
                  "balanceQuantity": element.balanceQuantity.toString(),
                  "Rate": element.rate,
                  "Broker": "",
                  "Portfolio": element.portfolio,
                  "Shareholder": element.shareholder,
                  "SalesQty": element.salesQty,
                  "hdnBasePrice": element.hdnBasePrice.toString(),
                  "userSalesQty": "0",
                });
              }
            }
          }
          // print(userTransID);
          // print(userTransID.length);
          // print(selectedQuantity.toString());
          // print(typedQuantity.toString());
          quantityController.text =
              (selectedQuantity + typedQuantity).toString();
          Navigator.pop(context);
        } else {
          quantityController.clear();
        }
      },
      bgColor: Colors.blue[300],
      borderColor: Colors.greenAccent.shade700,
      textSize: 22.sp,
      textColor: Colors.white,
      text: "Save",
      width: 320.w,
      height: 50.h,
    );
  }

  // Sell Stock Save Button
  sellStockSaveButton() {
    List<PurchaseArray> purchaseArray = [];

    return CustomButton(
      onPressed: () async {
        if (sellStockKey.currentState!.validate()) {
          if (quantityController.text.isEmpty ||
              quantityController.text == 0.toString()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter share quantity."),
              ),
            );
            return;
          }

          if (priceController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter share price."),
              ),
            );
            return;
          }

          if (selectedTransactionDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please choose date."),
              ),
            );
            return;
          }

          for (var elementt in userTransID) {
            purchaseArray.add(PurchaseArray(
              quantity: elementt["userSalesQty"].toString() == "0"
                  ? elementt["balanceQuantity"].toString()
                  : elementt["userSalesQty"].toString(),
              basePrice: elementt["hdnBasePrice"].toString(),
              cgtRate: elementt["hdnGainTaxRate"].toString(),
              // // cgtRate: val.toString(),
              purchaseRate: elementt["Rate"].toString(),
              shareTypeId: elementt["hdnShareTypeID"].toString(),
              purchaseDate: elementt["dateAD"].toString(),
            ));
          }

          // Calling the SellStock
          var res = await DioPortfolioChart().sellStock(
            sellStockRequestModel: SellStockRequestModel(
                transactionDate: DateFormat('M/d/y').format(
                    DateFormat("yyyy-MM-dd HH:mm:ss")
                        .parse(selectedTransactionDate!.toString())),
                sellRate: priceController.text.toString(),
                stockSymbol: widget.stockSymbol,
                purchaseArray: purchaseArray),
          );

          if (res is SellStockResponseModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  sellStockPopUp(context, res.dataCollection),
            );
          }
        }
      },
      bgColor: Colors.blue[300],
      borderColor: Colors.greenAccent.shade700,
      textSize: 25.sp,
      textColor: Colors.white,
      text: "Save",
      width: 320.w,
      height: 60.h,
    );
  }

  // Design inside Sell Stock PopUp
  singleCalculateWidget(String title, String value) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
          color: Colors.black,
          height: 10,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: styleTextFormField.copyWith(fontSize: 14.h),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                value,
                style: styleTextFormField.copyWith(fontSize: 14.h),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Sell Stock PopUp
  sellStockPopUp(context, share_calculation.DataCollection calculateShare) {
    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(
          "Additional Charges",
          style: styleTextFormField.copyWith(
            fontSize: 18.sp,
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            singleCalculateWidget(
                "Share Amount", calculateShare.d.salesAmount.toString()),
            singleCalculateWidget(
                "Purchase Cost", calculateShare.d.purchaseCost.toString()),
            singleCalculateWidget(
                "SEBON Commission", calculateShare.d.seboCommission.toString()),
            singleCalculateWidget("Broker Commission",
                calculateShare.d.brokerCommission.toString()),
            singleCalculateWidget(
                "DP Fee", calculateShare.d.dpCharge.toString()),
            singleCalculateWidget(
                "Total Quantity", quantityController.text.trim().toString()),
            singleCalculateWidget(
                "CGT(10%)", calculateShare.d.cgtAmount.toString()),
            singleCalculateWidget(
                "Amount", calculateShare.d.netReceivable.toString()),
            singleCalculateWidget(
                "Profit/Loss", calculateShare.d.netProfit.toString()),
          ],
        ),
      ),
      actions: [
        sellStockPopUpSaveButton(context, calculateShare.d.cgtAmount),
      ],
    );
  }

  sellStockPopUpSaveButton(context, cal) {
    List<Purchase> purchase = [];

    return CustomButton(
      onPressed: () async {
        for (var element in userTransID) {
          purchase.add(
            Purchase(
              quantity: element["userSalesQty"].toString() == "0"
                  ? element["balanceQuantity"].toString()
                  : element["userSalesQty"].toString(),
              basePrice: element["hdnBasePrice"].toString(),
              rate: element["Rate"].toString(),
              purchaseTransactionID: element["hdnUserTransactionID"].toString(),
              shareTypeID: element["hdnShareTypeID"].toString(),
              gainTaxRate: element["hdnGainTaxRate"].toString(),
            ),
          );
        }

        PurchaseTransactionRequest purchaseTransactionRequest =
            PurchaseTransactionRequest(
          transactionNumber: '',
          companyID: widget.companyId,
          brokerID: '1',
          symbol: widget.stockSymbol,
          quantity: quantityController.text.trim().toString(),
          rate: priceController.text.trim().toString(),
          capitalGainTax: cal.toString(),
          purchase: purchase,
        );

        // Converting to Nepali Date
        var dateTime = await DioPortfolioChart().convertToMiti(
            date: DateFormat('M/d/y').format(DateFormat("yyyy-MM-dd HH:mm:ss")
                .parse(selectedTransactionDate!.toString())));

        // calling sell stock API
        var res = await DioPortfolioChart().saveSellStockShare(
            transactionDateAD: DateFormat('M/d/y').format(
                DateFormat("yyyy-MM-dd HH:mm:ss")
                    .parse(selectedTransactionDate!.toString())),
            transactionDateBS: dateTime!.dataCollection.dateBs.toString(),
            model: purchaseTransactionRequest);

        if (res!.message != "Transaction detail saved successfully") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Server Error, Please try again."),
            ),
          );

          return;
        } else {
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, PortfolioChartScreen.routeName);
        }
      },
      bgColor: Colors.blue[300],
      borderColor: Colors.greenAccent.shade700,
      textSize: 22.sp,
      textColor: Colors.white,
      text: "Save",
      width: 320.w,
      height: 50.h,
    );
  }
}
