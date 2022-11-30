import 'package:biz_alert/features/dashboard/otp/services/dio_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../constants/global_variables.dart';
import '../../../../constants/style.dart';
import '../../../../models/request/signup_login_req_model.dart';
import '../../../../models/request/verify_pin_otp_req_model.dart';
import '../../../../models/response/resend_otp_res_model.dart';
import '../../../../models/response/verify_pin_otp_res_model.dart';
import '../../../logout_profile/screens/logout_profile_screen.dart';
import '../../../signup_page/services/dio_signup.dart';

class GetOtpScreen extends StatefulWidget {
  static const routeName = "get-otp";
  const GetOtpScreen({Key? key}) : super(key: key);

  @override
  State<GetOtpScreen> createState() => _GetOtpScreenState();
}

class _GetOtpScreenState extends State<GetOtpScreen> {
  late TextEditingController pinController = TextEditingController();
  late TextEditingController verifyPinController = TextEditingController();
  late TextEditingController numberController = TextEditingController();
  late TextEditingController numberController1 = TextEditingController();
  late TextEditingController otpController = TextEditingController();
  late TextEditingController pinContrverifyPinControlleroller =
      TextEditingController();

  final otpPinCodeKey = GlobalKey<FormState>();
  bool _isHidden = false;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController.fromValue(TextEditingValue.empty);
    verifyPinController =
        TextEditingController.fromValue(TextEditingValue.empty);
    numberController = TextEditingController.fromValue(TextEditingValue.empty);
    numberController1 = TextEditingController.fromValue(TextEditingValue.empty);
    otpController = TextEditingController.fromValue(TextEditingValue.empty);
    pinContrverifyPinControlleroller =
        TextEditingController.fromValue(TextEditingValue.empty);
  }

  @override
  Widget build(BuildContext context) {
    final messageSnack = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 200.h,
              width: 200.w,
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              width: 320.w,
              child: TextField(
                onChanged: ((newValue) {
                  setState(() {
                    numberController.text = newValue;
                  });
                }),
                decoration: const InputDecoration().copyWith(
                  labelText: 'Mobile number',
                ),
                keyboardType: TextInputType.number,
                style: styleTextFormField.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              width: 320.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await DioOtp().getOtp(numberController.text);
                  if (result!.status == "Success") {
                    messageSnack.showSnackBar(
                      SnackBar(
                        content: Text(result.dataCollection.msg),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          otpPinCode(context, numberController.text),
                    );
                  } else {
                    messageSnack.showSnackBar(
                      const SnackBar(
                        content: Text("Something went wrong. Try again."),
                      ),
                    );
                  }
                },
                style: styleMainButton,
                child: Text(
                  "Get OTP",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 12.h,
              ),

              // Number
              CustomTextField(
                readonly: true,
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
                  style:
                      styleTextFormField.copyWith(fontWeight: FontWeight.w400),
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
                  style:
                      styleTextFormField.copyWith(fontWeight: FontWeight.w400),
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
                  style:
                      styleTextFormField.copyWith(fontWeight: FontWeight.w400),
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
                        "6 digits of Pin Code required or pin code doesn't match."),
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
                      content: Text("Password changed successfully"),
                    ),
                  );
                  Navigator.popAndPushNamed(
                      context, LogOutProfileScreen.routeName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(res.dataCollection.d.message),
                    ),
                  );
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

  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
    verifyPinController.dispose();
    numberController.dispose();
    numberController1.dispose();
    otpController.dispose();
    pinContrverifyPinControlleroller.dispose();
  }
}
