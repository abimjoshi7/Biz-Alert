import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/watchlist_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/services/dio_watchlist.dart';
import 'package:biz_alert/models/request/add_req_watchlist.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../../../common/services/hivemodel.dart';

class AddStockWatchlistScreen extends StatefulWidget {
  static const String routeName = "/add-stock-watchlist";
  const AddStockWatchlistScreen({Key? key}) : super(key: key);

  @override
  State<AddStockWatchlistScreen> createState() =>
      _AddStockWatchlistScreenState();
}

class _AddStockWatchlistScreenState extends State<AddStockWatchlistScreen> {
  late DioWatchList _watchList;
  int? companyID;

  // For DropDown
  var symbol_drop;
  // For searching --
  final TextEditingController dropDownController = TextEditingController();
// -- For searching

  // For Search
  // String searchSymbol = "";

  // For Hive Local Database to get stock Info {used for stock symbol}
  StockDbModel stockSymbol = Hive.box(companyIdSymbol).get("stockInfo");

  @override
  void initState() {
    super.initState();
    _watchList = DioWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.popAndPushNamed(context, WatchlistScreen.routeName);
          },
          text: "Watchlist",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50.0.w, 50.0.w, 5.0.w, 5.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stock Symbol
            Text(
              "Stock Symbol",
              style: styleTextFormField.copyWith(
                  fontSize: 20.sp, color: GlobalVariablesColor.mainColor),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w),
              height: 35.h,
              width: 200.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius2)),
                // color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    isExpanded: false,
                    hint: const Text("Select stock symbol"),
                    items: stockSymbol.dataCollection.map((symbolName) {
                      return DropdownMenuItem(
                        value: symbolName.stockSymbol,
                        child: Text(
                          symbolName.stockSymbol,
                          style: dropDownStyle.copyWith(fontSize: 15.sp),
                        ),
                      );
                    }).toList(),
                    value: symbol_drop,
                    onChanged: (newVal) async {
                      setState(() {
                        symbol_drop = newVal;
                        final x = stockSymbol.dataCollection.firstWhere(
                            (element) => element.stockSymbol == symbol_drop);
                        companyID = x.companyId;
                      });

                      await _watchList
                          .addRequestWatchList(
                        AddRequestWatchList(
                            userId:
                                await SecureStorage().readData(key: saveUserID),
                            companyId: companyID!),
                      )
                          .then((value) {
                        if (value.status == "Success") {
                          Navigator.popAndPushNamed(
                            context,
                            WatchlistScreen.routeName,
                          );
                        }
                      });
                    },
                    itemHeight: 40,
                    dropdownMaxHeight: 400,
                    dropdownWidth: 200.w,
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
          ],
        ),
      ),
    );
  }
}
