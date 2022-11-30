import 'package:biz_alert/common/services/dio_hive.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:biz_alert/features/logout_profile/screens/logout_profile_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  var isLoading = false;

  // Splash time
  int splashtime = 3;

  // For Token and SecureStorage
  final SecureStorage secureStorage = SecureStorage();
  String? finalToken;

  // Navigator for going to next screen
  void goHome() {
    // Pushing to the home page after splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        //pushReplacement = replacing the route so that
        //splash screen won't show on back button press
        //navigation to Home page.
        builder: (context) => finalToken == null
            ? const LogOutProfileScreen()
            : const DashboardScreen(),
      ),
    );
  }

  @override
  void initState() {
    // Checking the token
    secureStorage.readData(key: saveToken).then((value) => finalToken = value);

    Future.delayed(
      Duration(seconds: splashtime),
      () async {
        // For calling an api to load when splash screen is shown so that the data can be stored locally
        await DioHiveDB().viewStockInfo().then((value) => goHome());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //vertically align center
          children: <Widget>[
            SizedBox(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/images/logo.png")),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              //margin top 30
              child: const Text(
                "Biz Alert",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Text("Enjoy",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
