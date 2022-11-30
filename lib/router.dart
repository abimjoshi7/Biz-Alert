import 'package:biz_alert/features/dashboard/biz_services/screens/biz_services_screen.dart';
import 'package:biz_alert/features/dashboard/companyDetail/screens/company_detail_screen.dart';
import 'package:biz_alert/features/dashboard/floorsheet/screens/floorsheet._screen.dart';
import 'package:biz_alert/features/dashboard/ipo_result/ipo_result_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/live_market_screen.dart';
import 'package:biz_alert/features/dashboard/live_market/screens/share_price_screen.dart';
import 'package:biz_alert/features/dashboard/login_profile/screens/login_profile_screen.dart';
import 'package:biz_alert/features/dashboard/market_overview/screens/market_overview_screen.dart';
import 'package:biz_alert/features/dashboard/news/screens/news_screen.dart';
import 'package:biz_alert/features/dashboard/notification/screens/notification_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/add_portfolio_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/add_stock_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/delete_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/portfolio_chart_screen.dart';
import 'package:biz_alert/features/dashboard/protfolio/screens/sell_stock_screen.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_watchlist_screen.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/add_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/saved_stock_alert.dart';
import 'package:biz_alert/features/dashboard/watchlist/screens/watchlist_screen.dart';
import 'package:biz_alert/features/dashboard/otp/screens/get_otp_screen.dart';
import 'package:biz_alert/features/logout_profile/screens/logout_profile_screen.dart';
import 'package:biz_alert/features/payment/screen/portfolio_pay.dart';
import 'package:biz_alert/features/signup_page/screens/signup_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // SignUp Page Screen
    case SignUpPageScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            const SignUpPageScreen(),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        ),
        settings: routeSettings,
      );

    // Logout Profile Screen
    case LogOutProfileScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LogOutProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Dashboard Screen
    case DashboardScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Live Market Screen
    case LiveMarketScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LiveMarketScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Share Price Screen
    // case SharePriceScreen.routeName:
    //   return MaterialPageRoute(
    //     builder: (_) => const SharePriceScreen(),
    //     settings: routeSettings,
    //   );

    // Share Price Screen
    case SharePriceScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SharePriceScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // BizServices Screen
    case BizServicesScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const BizServicesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // LoginProfileScreen
    case LoginProfileScreen.routeName:
      var userID = routeSettings.arguments as String;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoginProfileScreen(userID: userID),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // WatchlistScreen
    case WatchlistScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            // const WatchlistScreen(symbolDrop= routeSettings.arguments),
            const WatchlistScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // PortfolioChartScreen
    case PortfolioChartScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const PortfolioChartScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // NewsScreen
    case NewsScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NewsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Market Overview Screen
    case MarketOverviewScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MarketOverviewScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    //Add Stock Alert Screen
    case AddStockAlertScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddStockAlertScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Add Portfolio Screen
    case AddPortfolioScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddPortfolioScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Add Stock Screen
    case AddStockScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddStockScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Sell Stock Screen
    case SellStockScreen.routeName:
      List<dynamic> args = routeSettings.arguments as List<String?>;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SellStockScreen(stockSymbol: args[0], companyId: args[1]),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Delete Portfolio Screen
    case DeletePortfolioScreen.routeName:
      List<dynamic> args = routeSettings.arguments as List<String?>;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DeletePortfolioScreen(
                portfolioID: args[0],
                shareHolderID: args[1],
                companyID: args[2]),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Add Stock Watchlist Screen
    case AddStockWatchlistScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddStockWatchlistScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Saved Stock Alert Screen
    case SavedStockAlertScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SavedStockAlertScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Portfolio Payment
    case PortfolioPayment.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const PortfolioPayment(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // Company Detail
    case CompanyDetailScreen.routeName:
      var companySym = routeSettings.arguments as String;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CompanyDetailScreen(companySym: companySym),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    // FloorSheet
    case FloorSheetScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const FloorSheetScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    //Ipo Result Screen
    case IpoResultScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const IpoResultScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    //Get Otp Screen
    case GetOtpScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const GetOtpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );
    case NotificationScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NotificationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );

    default:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist!"),
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: routeSettings,
      );
  }
}
