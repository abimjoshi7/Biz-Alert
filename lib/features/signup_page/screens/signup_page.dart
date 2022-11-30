import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/common/widgets/custom_text_field.dart';
import 'package:biz_alert/common/widgets/facebook_sign_in.dart';
import 'package:biz_alert/common/widgets/google_sign_in.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/constants/style.dart';
import 'package:biz_alert/features/logout_profile/screens/logout_profile_screen.dart';
import 'package:biz_alert/features/signup_page/services/dio_signup.dart';
import 'package:biz_alert/models/request/signup_login_req_model.dart';
import 'package:biz_alert/models/request/verify_pin_otp_req_model.dart';
import 'package:biz_alert/models/response/resend_otp_res_model.dart';
import 'package:biz_alert/models/response/signup_login_res_model.dart';
import 'package:biz_alert/models/response/verify_pin_otp_res_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPageScreen extends StatefulWidget {
  static const String routeName = "/signup-page";
  const SignUpPageScreen({Key? key}) : super(key: key);

  @override
  State<SignUpPageScreen> createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {
  final signupPageKey = GlobalKey<FormState>();

  final otpPinCodeKey = GlobalKey<FormState>();

  final TextEditingController numberController = TextEditingController();
  final TextEditingController numberController1 = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController verifyPinController = TextEditingController();
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _isHidden = true;

  @override
  void dispose() {
    numberController.dispose();
    numberController1.dispose();
    otpController.dispose();
    pinController.dispose();
    verifyPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Banner(
          message: "Beta",
          location: BannerLocation.topEnd,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: signupPageKey,
                child: Column(
                  children: [
                    // Create your Account
                    Container(
                      margin: EdgeInsets.only(right: 100.w),
                      child: Text(
                        "Create your Account",
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

                    // Sign Up Button
                    SizedBox(
                      width: 320.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (signupPageKey.currentState!.validate()) {
                            if (numberController.text.isEmpty ||
                                numberController.text.length < 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please Enter Your Ncell Number with 10 digits"),
                                ),
                              );
                              return;
                            }

                            var res = await DioRegister().checkUser(
                              numberController.text.trim(),
                            );
                            if (!mounted) return;
                            if (res!.dataCollection.exists == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "The number already exists. Please Login."),
                                ),
                              );
                            } else {
                              var res = await DioRegister().registerUser(
                                signUpLoginRequestModel:
                                    SignUpLoginRequestModel(
                                  mobileNumber: numberController.text.trim(),
                                ),
                              );

                              if (!mounted) return;
                              if (res is SignUpLoginResponseModel) {
                                if (res.dataCollection.d.status == "success") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please enter the OTP Code sent in your mobile number"),
                                    ),
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        otpPinCode(
                                            context, numberController.text),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please enter valid mobile number"),
                                    ),
                                  );
                                }
                              }
                            }
                          }
                        },
                        style: styleMainButton,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 25.h,
                    ),

                    // - Or sign in with -
                    Text(
                      "- - - - - - - - - - - - - - - Or Sign in with - - - - - - - - - - - - - - -",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w400),
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
                      height: 45.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // OTP Code AlertDialog Box
  Widget otpPinCode(context, String number) {
    numberController1.text = number;
    return AlertDialog(
      title: Form(
        key: otpPinCodeKey,
        child: Center(
          child: Text(
            "Confirm",
            style: styleTextFormField.copyWith(
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 293.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 12.h,
            ),

            // Number
            CustomTextField(
              width: 320.w,
              controller: numberController1,
              hintText: "Ncell Number",
              type: TextInputType.number,
            ),

            SizedBox(
              height: 12.h,
            ),

            // OTP
            SizedBox(
              width: 320.w,
              child: TextFormField(
                controller: otpController,
                decoration: const InputDecoration().copyWith(
                  labelText: 'OTP Code',
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
                style: styleTextFormField.copyWith(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.number,
                obscureText: _isHidden,
              ),
            ),

            SizedBox(
              height: 12.h,
            ),

            // Pin code
            SizedBox(
              width: 320.w,
              child: TextFormField(
                controller: pinController,
                decoration: const InputDecoration().copyWith(
                  labelText: '6 digits Pin Code',
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
                style: styleTextFormField.copyWith(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.number,
                obscureText: _isHidden,
              ),
            ),

            SizedBox(
              height: 12.h,
            ),

            // Verify Pin code
            SizedBox(
              width: 320.w,
              child: TextFormField(
                controller: verifyPinController,
                decoration: const InputDecoration().copyWith(
                  labelText: '6 digits Pin Code',
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
                style: styleTextFormField.copyWith(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.number,
                obscureText: _isHidden,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),

            // ReSend OTP
            InkWell(
              onTap: () async {
                var res = await DioRegister().resendOtpCode(
                  signUpLoginRequestModel: SignUpLoginRequestModel(
                    mobileNumber: numberController.text.trim(),
                  ),
                );
                if (!mounted) return;
                if (res is ResendOtpResponseModel) {
                  if (res.dataCollection.d.status == "success") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("OTP Code Resend"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Server Error"),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                "Resend OTP Code",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: GlobalVariablesColor.mainColor2),
              ),
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          onPressed: () async {
            if (otpPinCodeKey.currentState!.validate()) {
              if (numberController1.text.isEmpty ||
                  numberController1.text.length < 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Please Enter Your Ncell Number with 10 digits"),
                  ),
                );
                return;
              }

              if (otpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("OTP Code is required"),
                  ),
                );
                return;
              }

              if (pinController.text.isEmpty || pinController.text.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("6 digits of Pin Code required"),
                  ),
                );
                return;
              }

              if (verifyPinController.text.isEmpty ||
                  verifyPinController.text.length < 6 ||
                  pinController.text != verifyPinController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "6 digits of Pin Code required or pin code doesnot match."),
                  ),
                );
                return;
              }

              var res = await DioRegister().verifyPinOtpCode(
                verifyPinOtpCodeRequestModel: VerifyPinOtpCodeRequestModel(
                  mobileNumber: numberController1.text.trim(),
                  otpCode: otpController.text.trim(),
                  pinCode: pinController.text.trim(),
                ),
              );

              if (res is VerifyPinOtpCodeResponseModel) {
                if (res.dataCollection.d.status == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User Created Successful"),
                    ),
                  );
                  Navigator.popAndPushNamed(
                      context, LogOutProfileScreen.routeName);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Server Error"),
                  ),
                );
              }
            }
          },
          bgColor: GlobalVariablesColor.mainColor1,
          borderColor: GlobalVariablesColor.mainColor2,
          textSize: 22.sp,
          textColor: Colors.white,
          text: "Submit",
          width: 320.w,
          height: 50.h,
        ),
      ],
    );
  }
}
