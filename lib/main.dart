import 'dart:io';
import 'package:biz_alert/bloc/authentication_bloc.dart';
import 'package:biz_alert/bloc/authentication_repository.dart';
import 'package:biz_alert/common/services/hive_sector_model.dart';
import 'package:biz_alert/common/services/hivemodel.dart';
import 'package:biz_alert/common/services/notification_hive.dart';
import 'package:biz_alert/common/services/notification_service.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/firebase_options.dart';
import 'package:biz_alert/providers/company_detail_provider.dart';
import 'package:biz_alert/providers/gainers_losers_detail_provider.dart';
import 'package:biz_alert/providers/theme_notifier_provider.dart';
import 'package:biz_alert/providers/top_brokers_provider.dart';
import 'package:biz_alert/providers/user_active_service_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:biz_alert/providers/dashboard_provider.dart';
import 'package:biz_alert/providers/get_indices_provider.dart';
import 'package:biz_alert/providers/get_portfolio_provider.dart';
import 'package:biz_alert/providers/get_shareholder_provider.dart';
import 'package:biz_alert/providers/get_user_detail_provider.dart';
import 'package:biz_alert/providers/live_index_graph_provider.dart';
import 'package:biz_alert/providers/live_market_trading_provider.dart';
import 'package:biz_alert/providers/market_summary_provider.dart';
import 'package:biz_alert/providers/portfolio_chart_provider.dart';
import 'package:biz_alert/providers/top_gainers_provider.dart';
import 'package:biz_alert/providers/top_losers_provider.dart';
import 'package:biz_alert/providers/top_sector_provider.dart';
import 'package:biz_alert/providers/top_turnover_provider.dart';
import 'package:biz_alert/router.dart';
import 'package:biz_alert/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/cubit/theme_cubit.dart';

List<String> testDeviceIds = ["3BCAAB428364AA648CE4B8F544217579"];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MobileAds.instance.initialize();

  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);

  // For Hive Local Database
  await Hive.initFlutter();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ServiceAdapter());
  Hive.registerAdapter(ServiceAdapter1());
  Hive.registerAdapter(SectorAdapter());
  Hive.registerAdapter(SectorAdapter1());
  Hive.registerAdapter(NotificationHiveAdapter());
  await Hive.openBox(companyIdSymbol);
  await Hive.openBox(sectorCompany);
  await Hive.openBox(notificationBox);

  //For Google SignIn
  // For facebook login from web
  // if (!kIsWeb) {
  //   await FacebookAuth.i.webInitialize(
  //     appId: "748623246344229",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v13.0",
  //   );
  // }

  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyDqutNLZgWNplKSpNRc4K32-5P_k-pUKRA",
  //         appId: "1:399558567478:android:b40267b6dbf1748c79da97",
  //         messagingSenderId: "399558567478",
  //         projectId: "bizalert-bc82e"));

  // For Notification
  // NotificationService().initNotification();
  await NotificationService().setupInteractedMessage();
  // await FirebaseMessaging.instance.subscribeToTopic("stockAlert");
  // await FirebaseMessaging.instance.subscribeToTopic("watchlist");
  // await FirebaseMessaging.instance.subscribeToTopic("Portfolio");
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    NotificationHive notificationHive = NotificationHive(
        id: initialMessage.messageId!,
        title: initialMessage.notification!.title!,
        body: initialMessage.notification!.body!,
        time: initialMessage.sentTime!);

    Hive.box(notificationBox).add(notificationHive);
  }
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  bool? isDark;

  await SharedPreferences.getInstance()
      .then((value) => isDark = value.getBool("darkMode") ?? false);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetIndicesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MarketSummaryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LiveIndexGraphProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LiveMarketTradingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopGainersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopLosersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopTurnoverProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopSectorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopBrokersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllGainersDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllLosersDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PortfolioChartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PortfolioProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShareHolderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserActiveServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompanyDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(
            isDark == true ? darkTheme : lightTheme,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(
                RepositoryProvider.of<AuthenticationRepository>(context)),
          ),
        ],
        child: StatefulBuilder(
          builder: (context, setState) => ScreenUtilInit(
            // designSize: const Size(393, 830),
            designSize: const Size(393, 786),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Biz Alert',
                theme: Provider.of<ThemeNotifier>(context).getTheme(),
                onGenerateRoute: (settings) => generateRoute(settings),
                home: child,
              );
            },
            child: const MySplashScreen(),
          ),
        ),
      ),
    );
  }
}
