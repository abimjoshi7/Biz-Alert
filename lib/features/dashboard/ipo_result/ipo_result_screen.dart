import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/widgets/custom_app_bar1.dart';
import '../screens/dashboard_screen.dart';

class IpoResultScreen extends StatelessWidget {
  static const routeName = "/ipo-result";
  const IpoResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context, DashboardScreen.routeName);
          },
          text: "IPO Result",
          // Search Icon
        ),
      ),
      body: const WebView(
        initialUrl: 'https://iporesult.cdsc.com.np/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
      ),
    );
  }
}
