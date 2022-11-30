import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/saved_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/watchlist_screen.dart';
import 'package:biz_alert/models/request/watchlist_settings_req_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';
import '../services/dio_watchlist.dart';

class AddStockAlertScreen extends StatefulWidget {
  static const String routeName = '/stock-alerts';
  const AddStockAlertScreen({Key? key}) : super(key: key);

  @override
  State<AddStockAlertScreen> createState() => _AddStockAlertScreenState();
}

class _AddStockAlertScreenState extends State<AddStockAlertScreen> {
  late DioWatchList _watchList;
  int? emailIncrease;
  int? emailDecrease;
  bool isGreater = false;
  bool isLesser = false;

  final addStockAlertKey = GlobalKey<FormState>();
  final TextEditingController increasePriceController = TextEditingController();
  final TextEditingController decreasePriceController = TextEditingController();

  var args;

  // For DropDown
  var symbolDrop;
  var whenPrice;

  // For switch button
  bool _toogleButton = false;
  int isAlertEnabled = 0;

  // Send alert when price
  List priceAlert = [
    "is greater than",
    "is less than",
    "equal to",
  ];

  @override
  void initState() {
    super.initState();
    _watchList = DioWatchList();
    // increasePriceController =
    //     TextEditingController.fromValue(const TextEditingValue(text: '0'));
    // decreasePriceController =
    //     TextEditingController.fromValue(const TextEditingValue(text: '0'));
    // increasePriceController.text = args["increasePrice"];
    // decreasePriceController.text = args["decreasePrice"];
  }

  @override
  void didChangeDependencies() {
    get123();
    // increasePriceController = TextEditingController.fromValue(
    //   TextEditingValue(
    //     text: args["increase_price"].toString(),
    //   ),
    // );
    // decreasePriceController = TextEditingController.fromValue(
    //   TextEditingValue(
    //     text: args["decrease_price"].toString(),
    //   ),
    // );

    super.didChangeDependencies();
  }

  get123() {
    args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return args;
  }

  // Calling Firebase messaging
  void main() async {
    await FirebaseMessaging.instance.subscribeToTopic("stockAlert");
  }

  @override
  Widget build(BuildContext context) {
    // providing increase and decrease value in respective text editing controller--
    increasePriceController.text = args["increasePrice"].toString();
    decreasePriceController.text = args["decreasePrice"].toString();
    args["emailIncrease"] == 1 ? isGreater = true : isGreater = false;
    args["emailDecrease"] == 1 ? isLesser = true : isLesser = false;
    //--.

    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.popAndPushNamed(context, WatchlistScreen.routeName);
          },
          text: "Add Stock Alert",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.width15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              // Stock Symbol
              Text(
                "Stock Symbol",
                style: styleTextFormField.copyWith(
                  fontSize: 15.sp,
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
                padding: const EdgeInsets.only(left: 10, top: 11),
                height: 45,
                width: 190,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.radius2)),
                    color: Colors.white),
                // child: FutureBuilder<StockDbModel?>(
                //     future: _watchList.viewShareInfo(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Container();
                //       } else {
                //         return DropdownButtonHideUnderline(
                //           child: DropdownButton(
                //             hint: Text(
                //               args["symbol"],
                //               style: const TextStyle(fontSize: 12),
                //             ),
                //             items:
                //                 snapshot.data!.dataCollection.map((symbolName) {
                //               return DropdownMenuItem(
                //                 value: symbolName.stockSymbol,
                //                 child: Text(
                //                   symbolName.stockSymbol,
                //                   style:
                //                       dropDownStyle.copyWith(fontSize: 13.sp),
                //                 ),
                //               );
                //             }).toList(),
                //             onChanged: (newVal) async {
                //               setState(() {
                //                 symbolDrop = newVal;
                //                 final x = snapshot.data!.dataCollection
                //                     .firstWhere((element) =>
                //                         element.stockSymbol == symbolDrop);
                //                 companyID = x.companyId;
                //               });
                //             },
                //             value: symbolDrop,
                //           ),
                //         );
                //       }
                //     }),

                child: Text(
                  args["symbol"],
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),

              SizedBox(
                height: 40.h,
              ),

              Form(
                key: addStockAlertKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Send alert when price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send alert when price",
                          style: styleTextFormField.copyWith(
                            fontSize: 15.sp,
                            color: Provider.of<ThemeNotifier>(context)
                                        .getTheme() ==
                                    darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.w),
                              height: 45.h,
                              width: 140.w,
                              child: TextFormField(
                                enabled: false,
                                initialValue: "is greater than:",
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.w,
                              ),
                              height: 45.h,
                              width: 140.w,
                              child: TextFormField(
                                enabled: false,
                                initialValue: "is less than:",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 18.w,
                    ),

                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Price
                            Text(
                              "Price",
                              style: styleTextFormField.copyWith(
                                fontSize: 15.sp,
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),

                            SizedBox(
                              height: 5.h,
                            ),

                            SizedBox(
                              height: 45.h,
                              width: 100.w,
                              child: TextFormField(
                                controller: increasePriceController,
                                decoration: const InputDecoration().copyWith(
                                  labelText: "",
                                ),
                                style: styleTextFormField.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.number,

                                // onFieldSubmitted: ((value) {
                                //   priceController
                                // },
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              width: 100.w,
                              child: TextFormField(
                                controller: decreasePriceController,
                                decoration: const InputDecoration().copyWith(
                                  labelText: "",
                                ),
                                style: styleTextFormField.copyWith(
                                    color: Provider.of<ThemeNotifier>(context)
                                                .getTheme() ==
                                            darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18.w,
                    ),

                    // Notify
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Price
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                "Notify?",
                                style: styleTextFormField.copyWith(
                                  fontSize: 15.sp,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .getTheme() ==
                                          darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),

                            StatefulBuilder(
                              builder: ((context, setState) {
                                return Checkbox(
                                    value: isGreater,
                                    onChanged: (v) {
                                      setState(
                                        () {
                                          isGreater = v!;
                                          if (isGreater == true) {
                                            setState(() {
                                              emailIncrease = 1;
                                            });
                                          } else {
                                            setState(
                                              (() => emailIncrease = 0),
                                            );
                                          }
                                          // print(v);
                                        },
                                      );
                                    });
                              }),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            StatefulBuilder(
                              builder: ((context, setState) {
                                return Checkbox(
                                    value: isLesser,
                                    onChanged: (v) {
                                      setState(
                                        () {
                                          isLesser = v!;

                                          if (isLesser == true) {
                                            setState(() {
                                              emailDecrease = 1;
                                            });
                                          } else {
                                            setState(
                                              (() => emailDecrease = 0),
                                            );
                                          }
                                        },
                                      );
                                    });
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),

              SizedBox(
                height: 50.h,
              ),
              // Buttons
              Row(
                children: [
                  // Save Button
                  CustomButton(
                    onPressed: () async {
                      if (addStockAlertKey.currentState!.validate()) {
                        if (increasePriceController.text.isEmpty ||
                            increasePriceController.text == 0.toString()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please Enter the Price greater than 0."),
                            ),
                          );
                          return;
                        }
                        if (decreasePriceController.text.isEmpty ||
                            decreasePriceController.text == 0.toString()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please Enter the Price greater than 0."),
                            ),
                          );
                          return;
                        }
                        final response = await _watchList
                            .configWatchlistAlert(
                          WatchlistAlertSettingsRequest(
                              userId: await SecureStorage()
                                  .readData(key: saveUserID),
                              alertWatchlistSettings: [
                                // AlertWatchlistSetting(
                                //   companyId: 1,
                                //   isAlertEnabled: 0,
                                //   sendEmailOnIncrease: 0,
                                //   sendEmailOnDecrease: 0,
                                //   sendSmsOnIncrease: 0,
                                //   sendSmsOnDecrease: 0,
                                //   increasePrice: 200,
                                //   decreasePrice: 150,
                                // )
                                AlertWatchlistSetting(
                                  companyId: args["companyID"],
                                  isAlertEnabled: isAlertEnabled,
                                  sendEmailOnIncrease: emailIncrease ?? 0,
                                  sendEmailOnDecrease: emailDecrease ?? 0,
                                  sendSmsOnIncrease: 0,
                                  sendSmsOnDecrease: 0,
                                  increasePrice:
                                      int.parse(increasePriceController.text),
                                  decreasePrice:
                                      int.parse(decreasePriceController.text),
                                )
                              ]),
                        )
                            .then((value) {
                          if (value.status == "Success") {
                            Navigator.popAndPushNamed(
                                context, SavedStockAlertScreen.routeName);
                          }
                        });
                      }
                    },
                    bgColor: Colors.blue[300],
                    borderColor: Colors.greenAccent.shade700,
                    textSize: 20.sp,
                    textColor: Colors.white,
                    text: "Save",
                    width: 100.w,
                    height: 50.h,
                  ),

                  SizedBox(
                    width: 10.h,
                  ),

                  // Cancel Button
                  CustomButton(
                    onPressed: () {
                      // final x = get123();
                      // print(x.toJson());
                      // Navigator.of(context).pop();
                    },
                    bgColor: Colors.grey[350],
                    borderColor: Colors.grey.shade300,
                    textSize: 20.sp,
                    textColor: Colors.black,
                    text: "Cancel",
                    width: 100.w,
                    height: 50.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    increasePriceController.dispose();
    decreasePriceController.dispose();
  }
}
