import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:biz_alert/features/dashboard/floorsheet/screens/floorsheet._screen.dart';
import 'package:biz_alert/features/dashboard/ipo_result/ipo_result_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/live_market_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/share_price_screen.dart';
import 'package:biz_alert/features/dashboard/market_overview/screens/market_overview_screen.dart';
import 'package:biz_alert/features/dashboard/news/screens/news_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/portfolio_chart_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/saved_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/watchlist_screen.dart';
import 'package:biz_alert/features/logout_profile/screens/logout_profile_screen.dart';
import 'package:biz_alert/features/payment/screen/portfolio_pay.dart';
import 'package:biz_alert/models/response/user_active_service_res.dart';
import 'package:biz_alert/providers/theme_notifier_provider.dart';
import 'package:biz_alert/providers/user_active_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizServicesScreen extends StatefulWidget {
  static const String routeName = "/biz-service";
  const BizServicesScreen({Key? key}) : super(key: key);

  @override
  State<BizServicesScreen> createState() => _BizServicesScreenState();
}

class _BizServicesScreenState extends State<BizServicesScreen> {
  // For Authentication
  final SecureStorage secureStorage = SecureStorage();
  String? finalToken;
  bool? isDark;
  Future<UserActiveServiceResponseModel?>? userActiveServiceData;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    value
        ? await themeNotifier.setTheme(darkTheme)
        : await themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", value);
  }

  @override
  void initState() {
    secureStorage.readData(key: saveToken).then((value) => finalToken = value);

    final userActiveService =
        Provider.of<UserActiveServiceProvider>(context, listen: false);
    userActiveServiceData = userActiveService.getUserActiveService();
    super.initState();
  }

  List serviceList = [
    "Portfolio",
    "Watchlist",
    "NEPSE Live",
    "Market",
    "News",
    "Share Price",
    "Stock Alert",
    "Floorsheet",
    "IPO Result",
  ];

  List serviceTap = [
    PortfolioChartScreen.routeName,
    WatchlistScreen.routeName,
    LiveMarketScreen.routeName,
    MarketOverviewScreen.routeName,
    NewsScreen.routeName,
    SharePriceScreen.routeName,
    SavedStockAlertScreen.routeName,
    FloorSheetScreen.routeName,
    IpoResultScreen.routeName,
  ];

  List icon = [
    Icons.work,
    Icons.visibility,
    Icons.live_tv,
    Icons.search,
    Icons.newspaper,
    Icons.live_tv,
    Icons.notifications,
    Icons.feed_outlined,
    Icons.redeem_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    isDark = themeNotifier.getTheme() == darkTheme;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final userActiveService =
        Provider.of<UserActiveServiceProvider>(context).userActiveService;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Biz Services",
          child2: Switch(
              value: isDark ?? false,
              onChanged: (b) async {
                setState(() {
                  isDark = b;
                  onThemeChanged(b, themeNotifier);
                });

                setState(() {});
                // print()
              }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 00,
                mainAxisSpacing: 15),
            itemCount: serviceList.length,
            itemBuilder: (context, index) {
              return FutureBuilder<UserActiveServiceResponseModel?>(
                  future: userActiveServiceData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          // checking whether the user is logged in or not
                          if (serviceTap[index] == serviceTap[1] ||
                              serviceTap[index] == serviceTap[6]) {
                            if (finalToken == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                    "Login to use the Feature!!",
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
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LogOutProfileScreen(),
                                                ),
                                              );
                                            },
                                            bgColor:
                                                GlobalVariablesColor.mainColor,
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
                            } else {
                              Navigator.pushNamed(context, serviceTap[index]);
                            }
                          }
                          // Condition for Portfolio
                          else if (serviceTap[index] == serviceTap[0]) {
                            if (finalToken == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                    "Login to use the Feature!!",
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
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LogOutProfileScreen(),
                                                ),
                                              );
                                            },
                                            bgColor:
                                                GlobalVariablesColor.mainColor,
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
                            } else if (finalToken != null) {
                              args["ncellPayment"] == false
                                  ? Navigator.pushNamed(
                                      context, PortfolioChartScreen.routeName)
                                  : userActiveService!.dataCollection.data[0]
                                              .isExpired ==
                                          0
                                      ? Navigator.pushNamed(
                                          context,
                                          PortfolioChartScreen.routeName,
                                        )
                                      : Navigator.pushNamed(
                                          context, PortfolioPayment.routeName);
                            } else {
                              Navigator.pushNamed(
                                context, serviceTap[index],
                                // arguments: serviceTap[index] == serviceTap[0]
                                //     ? await SecureStorage()
                                //         .readData(key: saveUserID)
                                //     : ''
                              );
                            }
                          } else {
                            Navigator.pushNamed(context, serviceTap[index]);
                          }
                        },
                        //IconNameCard
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.w,
                          ),
                          // padding: EdgeInsets.only(
                          //   left: 15.w,
                          //   top: 25.h,
                          //   bottom: 25.h,
                          // ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: GlobalVariablesColor.mainColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon[index],
                                color: GlobalVariablesColor.mainColor,
                                size: 35,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                serviceList[index],
                                // style: serviceTitleStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  });
            }),
      ),
    );
  }
}
