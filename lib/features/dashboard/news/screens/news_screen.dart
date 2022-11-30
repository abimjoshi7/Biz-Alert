import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/features/dashboard/news/services/dio_news.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  static const String routeName = "/news";
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> offset;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..forward();
    // ..forward()
    // ..reverse();
    offset = Tween<Offset>(
      begin: const Offset(0.0, 15.0),
      end: const Offset(1.5, 15.0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.slowMiddle));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context, DashboardScreen.routeName);
          },
          text: "News",
          // Search Icon
          icon2: Icons.search,

          onPressed2: () async {
            final x = await DioNews().getNews();
            if (kDebugMode) {
              print(x.data!.first.description);
            }
            controller.forward();
          },
        ),
      ),

      body: Builder(builder: (context) {
        return SlideTransition(
            position: offset, child: const Text("Coming Soon..."));
      }),
    );
  }
}
