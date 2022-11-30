import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_loader.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/logout_profile/screens/logout_profile_screen.dart';
import 'package:biz_alert/models/response/get_user_detail_res_model.dart';
import 'package:biz_alert/providers/get_user_detail_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_notifier_provider.dart';

class LoginProfileScreen extends StatefulWidget {
  static const String routeName = "/login-profile";
  final String userID;
  const LoginProfileScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  Future<UserDetailsResponseModel>? userDetailData;

  List profileThings = [
    "Subscription",
    "Message Us",
    "Terms and Conditions",
    "Privacy Policy",
    "Like Us",
    "Rate Us",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDetail =
        Provider.of<UserDetailProvider>(context).userDetailsModel;
    return Scaffold(
      // backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Profile",
          icon2: Icons.logout_rounded,
          onPressed2: () async {
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: const Text("Do you want to logout?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.currentUser!.delete();
                              // snapshotUser.data?.delete;
                              await SecureStorage().deleteAll();
                              if (!mounted) return;
                              Navigator.popAndPushNamed(
                                  context, LogOutProfileScreen.routeName);
                            },
                            child: const Text("Confirm")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                      ],
                    ));
          },
        ),
      ),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshotUser) {
            switch (snapshotUser.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CustomLoader(),
                );
              case ConnectionState.active:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(
                        //     color: GlobalVariablesColor.mainColor,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: GlobalVariablesColor.mainColor
                        //             .withOpacity(0.5),
                        //         spreadRadius: 1,
                        //         blurRadius: 7,
                        //         offset: const Offset(0.5, 0.5),
                        //       ),
                        //     ]),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            // Profile Image
                            Image.asset(
                              "assets/images/logo.png",
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            // Profile Name
                            RichText(
                                text: TextSpan(
                                    text: snapshotUser.data?.displayName ?? "",
                                    // userDetail!
                                    //         .dataCollection.data[0].firstName ??
                                    //     '',
                                    style: profileStyle.copyWith(
                                      color: Provider.of<ThemeNotifier>(context)
                                                  .getTheme() ==
                                              darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    children: const [
                                  TextSpan(
                                    text: ' ',
                                  ),
                                  // TextSpan(
                                  //   text: userDetail
                                  //           .dataCollection.data[0].lastName ??
                                  //       '',
                                  //   style: profileStyle.copyWith(
                                  //     color: Provider.of<ThemeNotifier>(context)
                                  //                 .getTheme() ==
                                  //             darkTheme
                                  //         ? Colors.white
                                  //         : Colors.black,
                                  //   ),
                                  // ),
                                ])),

                            const SizedBox(
                              height: 5,
                            ),
                            // Profile Email
                            Text(
                              snapshotUser.data?.email ?? "",
                              // userDetail.dataCollection.data[0].email!,
                              style: profileStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),
                            // Profile Email
                            Text(
                              snapshotUser.data?.phoneNumber ?? "",
                              // userDetail.dataCollection.data[0].mobileNumber!,
                              style: profileStyle.copyWith(
                                color: Provider.of<ThemeNotifier>(context)
                                            .getTheme() ==
                                        darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            // Logout Button
                            // SizedBox(
                            //   width: 120.w,
                            //   height: 45.h,
                            //   child: ElevatedButton(
                            //     onPressed: () async {
                            //       snapshotUser.data?.delete;
                            //       await SecureStorage().deleteAll();
                            //       if (!mounted) return;
                            //       Navigator.popAndPushNamed(
                            //           context, LogOutProfileScreen.routeName);
                            //     },
                            //     style: styleMainButton,
                            //     child: Text(
                            //       "Log Out",
                            //       style: TextStyle(
                            //         fontSize: 20.sp,
                            //         color: Provider.of<ThemeNotifier>(context)
                            //                     .getTheme() ==
                            //                 darkTheme
                            //             ? Colors.white
                            //             : Colors.black,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 30.h,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 30.h,
                              thickness: 0,
                              color: Provider.of<ThemeNotifier>(context)
                                          .getTheme() ==
                                      darkTheme
                                  ? Colors.white
                                  : Colors.black,
                            );
                          },
                          itemCount: profileThings.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 90.w),
                              child: Row(
                                children: [
                                  index == 0
                                      ? Icon(
                                          Icons.abc,
                                          size: 30.h,
                                          color: Provider.of<ThemeNotifier>(
                                                          context)
                                                      .getTheme() ==
                                                  darkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        )
                                      : index == 1
                                          ? Icon(
                                              Icons.message,
                                              size: 30.h,
                                              color: Provider.of<ThemeNotifier>(
                                                              context)
                                                          .getTheme() ==
                                                      darkTheme
                                                  ? Colors.white
                                                  : Colors.black,
                                            )
                                          : index == 2
                                              ? Image.asset(
                                                  "assets/images/terms.png",
                                                  width: 28.h,
                                                  color:
                                                      Provider.of<ThemeNotifier>(
                                                                      context)
                                                                  .getTheme() ==
                                                              darkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                )
                                              : index == 3
                                                  ? Image.asset(
                                                      "assets/images/policy.png",
                                                      width: 28.h,
                                                      color: Provider.of<ThemeNotifier>(
                                                                      context)
                                                                  .getTheme() ==
                                                              darkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )
                                                  : index == 4
                                                      ? Icon(
                                                          Icons.facebook,
                                                          size: 30.h,
                                                          color: Provider.of<ThemeNotifier>(
                                                                          context)
                                                                      .getTheme() ==
                                                                  darkTheme
                                                              ? Colors.white
                                                              : Colors.black,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/playstore.png",
                                                          width: 28.h,
                                                          color: Provider.of<ThemeNotifier>(
                                                                          context)
                                                                      .getTheme() ==
                                                                  darkTheme
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      profileThings[index],
                                      style: profileStyle.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .getTheme() ==
                                                    darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          }),
    );
  }
}
