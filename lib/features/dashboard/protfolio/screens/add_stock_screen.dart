import 'package:biz_alert/common/services/hivemodel.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/portfolio_chart_screen.dart';
import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/common/widgets/custom_text_field.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/models/request/add_stock_req_model.dart';
import 'package:biz_alert/models/response/add_stock_res_model.dart';
import 'package:biz_alert/models/response/add_stock_res_model.dart'
    as share_calculation;
import 'package:biz_alert/providers/get_portfolio_provider.dart';
import 'package:biz_alert/providers/get_shareholder_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';

class AddStockScreen extends StatefulWidget {
  static const String routeName = '/add-stock';
  const AddStockScreen({Key? key}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final addStockKey = GlobalKey<FormState>();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dropDownController = TextEditingController();

  List<String> transactionTypeList = [
    "Select Share Type",
    "Secondary",
    "IPO",
    "Right",
    "Bonus",
    // "Auction",
    // "Dividend",
  ];
  int transactionTypePosition = 0;
  var transaction_type_drop;

  // Retrieving data from Hive Database
  String? stockSymbolDrop;
  String? companyId;
  String? companySymbol;
  StockDbModel stockSymbol = Hive.box(companyIdSymbol).get("stockInfo");

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: GlobalVariablesColor.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar1(
            onPressed: () {
              Navigator.popAndPushNamed(
                  context, PortfolioChartScreen.routeName);
            },
            text: "Add Stock",
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: addStockKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Transaction Type
                  Container(
                    margin: EdgeInsets.only(right: 210.w),
                    child: Text(
                      "Transaction Type",
                      style: styleTextFormField.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.w),
                    height: 45.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius2)),
                        color: Colors.white),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text("Select Share Type"),
                        items: transactionTypeList.map((transactionType) {
                          return DropdownMenuItem<String>(
                            value: transactionType,
                            child: Text(
                              transactionType,
                              style: dropDownStyle.copyWith(fontSize: 15.sp),
                            ),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          for (var i = 0; i < transactionTypeList.length; i++) {
                            if (transactionTypeList[i] == newVal) {
                              setState(() {
                                transactionTypePosition = i;
                                transaction_type_drop = transactionTypeList[i];
                              });
                            }
                          }
                        },
                        value: transaction_type_drop,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),
                  // Stock Symbol
                  Container(
                    margin: EdgeInsets.only(right: 230.w),
                    child: Text(
                      "Stock Symbol",
                      style: styleTextFormField.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 10.w),
                    width: 320.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius2)),
                        color: Colors.white),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          isExpanded: false,
                          hint: Text(
                            'Select Symbol',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: stockSymbol.dataCollection
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e.stockSymbol,
                                  child: Text(
                                    e.stockSymbol,
                                    style:
                                        dropDownStyle.copyWith(fontSize: 15.sp),
                                  ),
                                ),
                              )
                              .toList(),
                          value: stockSymbolDrop,
                          onChanged: (value) {
                            setState(() {
                              stockSymbolDrop = value as String;
                            });
                            final sym = stockSymbol.dataCollection.firstWhere(
                                (element) =>
                                    element.stockSymbol == stockSymbolDrop);
                            companyId = sym.companyId.toString();
                            companySymbol = sym.stockSymbol;
                          },
                          // buttonHeight: 45,
                          // buttonWidth: 320.w,
                          itemHeight: 40,
                          dropdownMaxHeight: 300,
                          dropdownWidth: 320.w,
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

                  SizedBox(
                    height: 25.h,
                  ),
                  // Quantity
                  Container(
                    margin: EdgeInsets.only(right: 265.w),
                    child: Text(
                      "Quantity",
                      style: styleTextFormField.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextField(
                    width: 320.w,
                    controller: quantityController,
                    hintText: '',
                    type: TextInputType.number,
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // Price
                  Container(
                    margin: EdgeInsets.only(right: 280.w),
                    child: Text(
                      "Price",
                      style: styleTextFormField.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
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
                    margin: EdgeInsets.only(right: 205.w),
                    child: Text(
                      "Transaction Date",
                      style: styleTextFormField.copyWith(
                        color: Provider.of<ThemeNotifier>(context).getTheme() ==
                                darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: _pickDateDialog,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w),
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
                    height: 35.h,
                  ),

                  // Save Button
                  addStockSaveButton(),

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

  // Add Stock Save Button
  addStockSaveButton() {
    return CustomButton(
      onPressed: () async {
        if (addStockKey.currentState!.validate()) {
          if (transaction_type_drop == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please Select the transaction type."),
              ),
            );
            return;
          }
          if (stockSymbolDrop == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please Select the stock symbol."),
              ),
            );
            return;
          }

          if (quantityController.text.isEmpty) {
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
          var res = await DioPortfolioChart().addStock(
              addStockRequestModel: AddStockRequestModel(
            transactionDate: DateFormat('M/d/y').format(
                DateFormat("yyyy-MM-dd HH:mm:ss")
                    .parse(selectedTransactionDate!.toString())),
            shareType: transactionTypePosition,
            stockSymbol: companySymbol!,
            rate: double.parse(priceController.text),
            quantity: int.parse(quantityController.text),
          ));

          if (res is AddStockResponseModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  addStockPopUp(context, res.dataCollection!),
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

  // Design inside Add Stock PopUp
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

  // Add Stock Pop Up after clicking save button
  addStockPopUp(context, share_calculation.DataCollection? calculateShare) {
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
                "Total Quantity", calculateShare!.d!.totalQuantity.toString()),
            singleCalculateWidget(
                "Cost per Unit", calculateShare.d!.averageRate.toString()),
            singleCalculateWidget("Broker Commission",
                calculateShare.d!.brokerCommission.toString()),
            singleCalculateWidget("SEBON Commission",
                calculateShare.d!.seboCommission.toString()),
            singleCalculateWidget(
                "DP Fee", calculateShare.d!.dpCharge.toString()),
            singleCalculateWidget(
                "Share Amount", calculateShare.d!.purchaseValue.toString()),
            singleCalculateWidget(
                "Total Amount", calculateShare.d!.purchaseCost.toString()),
          ],
        ),
      ),
      actions: [
        addStockPopUpSaveButton(),
      ],
    );
  }

  // Add Stock PopUp Save Button
  addStockPopUpSaveButton() {
    final portfolioId =
        Provider.of<PortfolioProvider>(context).getPortfolioModel;
    final shareHolderId =
        Provider.of<ShareHolderProvider>(context).getShareHolderModel;

    return CustomButton(
      onPressed: () async {
        // Converting to Nepali Date
        var dateTime = await DioPortfolioChart().convertToMiti(
            date: DateFormat('M/d/y').format(DateFormat("yyyy-MM-dd HH:mm:ss")
                .parse(selectedTransactionDate!.toString())));

        // Calling add stock api
        var res = await DioPortfolioChart().addNewStockShare(
          shareType: transactionTypePosition,
          transactionDateAD: DateFormat('M/d/y').format(
              DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(selectedTransactionDate!.toString())),
          transactionDateBS: dateTime!.dataCollection.dateBs.toString(),
          quantity: quantityController.text,
          rate: priceController.text,
          shareHolderId: shareHolderId!.dataCollection[0].shareholderId,
          portfolioId: portfolioId!.dataCollection[0].portfolioId,
          companyId: companyId!,
          userTransactionID: "0",
          brokerId: 0,
          transactionNo: "0",
        );
        if (!mounted) return;
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
          quantityController.clear();
          priceController.clear();
          selectedTransactionDate == null;
          stockSymbolDrop == null;
          transactionTypeList.clear();
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

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    dropDownController.clear();
    super.dispose();
  }
}
