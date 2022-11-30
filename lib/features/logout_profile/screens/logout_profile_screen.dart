import 'package:biz_alert/common/widgets/custom_text_field.dart';
import 'package:biz_alert/common/widgets/facebook_sign_in.dart';
import 'package:biz_alert/common/widgets/google_sign_in.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:biz_alert/features/dashboard/otp/screens/get_otp_screen.dart';
import 'package:biz_alert/features/logout_profile/services/dio_logout_profile.dart';
import 'package:biz_alert/features/signup_page/screens/signup_page.dart';
import 'package:biz_alert/models/response/login_user_new1_res_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogOutProfileScreen extends StatefulWidget {
  static const String routeName = "/logout-profile";
  const LogOutProfileScreen({Key? key}) : super(key: key);

  @override
  State<LogOutProfileScreen> createState() => _LogOutProfileScreenState();
}

class _LogOutProfileScreenState extends State<LogOutProfileScreen> {
  final logoutProfileKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int socialStatus = 0;

  bool _isHidden = true;

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: logoutProfileKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Login to your Account
                  Container(
                    margin: EdgeInsets.only(right: 80.w),
                    child: Text(
                      "Login to your Account",
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w700),
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  //Number
                  CustomTextField(
                    width: 320.w,
                    controller: numberController,
                    hintText: 'Ncell Number',
                    type: TextInputType.number,
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                  // Password
                  SizedBox(
                    width: 320.w,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration().copyWith(
                        labelText: 'Password',
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                          child: _isHidden
                              ? const Icon(
                                  Icons.visibility_off,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  size: 18,
                                ),
                        ),
                      ),
                      style: styleTextFormField.copyWith(
                          fontWeight: FontWeight.w400),
                      keyboardType: TextInputType.number,
                      obscureText: _isHidden,
                    ),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                  // Login Button
                  SizedBox(
                    width: 320.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (logoutProfileKey.currentState!.validate()) {
                          if (numberController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please Enter the Number."),
                              ),
                            );
                            return;
                          }
                          if (passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter the password."),
                              ),
                            );
                            return;
                          }

                          // Getting and Saving the data
                          var res = await DioLogoutProfile().viewLoginUserNew1(
                              numberController.text,
                              passwordController.text,
                              socialStatus);
                          if (res is LoginUserNew1Model) {
                            SecureStorage().writeData(
                                key: saveNumber,
                                value: res.dataCollection.data[0].mobileNumber);
                            SecureStorage().writeData(
                                key: saveUserID,
                                value: res.dataCollection.data[0].userId);
                            SecureStorage().writeData(
                                key: saveToken,
                                value: res.dataCollection.data[0].sessionToken);

                            if (!mounted) return;
                            Navigator.popAndPushNamed(
                                context, DashboardScreen.routeName);
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Enter Valid number"),
                              ),
                            );
                          }
                        }
                      },
                      style: styleMainButton,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  // Skip for now or Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, DashboardScreen.routeName);
                        },
                        child: Text(
                          "SKIP ?",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        width: 140.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, GetOtpScreen.routeName);
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                  // - Or sign in with -
                  Text(
                    "- - - - - - - - - - - - - - - Or Sign in with - - - - - - - - - - - - - - -",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                  // Social Media
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      GoogleSignInButton(),
                      FacebookSignInButton(),
                    ],
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                  // Don't have an account? Sign Up
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                          fontSize: 13.sp,
                          // fontWeight: FontWeight.w400,
                          color: Colors.black),
                      children: [
                        TextSpan(
                            text: "  SIGN UP",
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, SignUpPageScreen.routeName);
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
