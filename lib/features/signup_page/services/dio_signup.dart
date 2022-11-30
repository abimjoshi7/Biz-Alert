import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/request/signup_login_req_model.dart';
import 'package:biz_alert/models/request/verify_pin_otp_req_model.dart';
import 'package:biz_alert/models/response/check_user_exists_res_model.dart';
import 'package:biz_alert/models/response/register_new_social_user_model.dart';
import 'package:biz_alert/models/response/resend_otp_res_model.dart';
import 'package:biz_alert/models/response/signup_login_res_model.dart';
import 'package:biz_alert/models/response/verify_pin_otp_res_model.dart';
import 'package:dio/dio.dart';

class DioSocialSignUp {
  // Get User Signup from Social Media
  Future<RegisterNewSocialUserResponse?> registerNewSocialUser(
      {String? mobileNumber,
      String? firstName,
      String? lastName,
      String? email,
      String? password,
      int? socialStatus,
      String? sexType}) async {
    // var userId = await SecureStorage().readData(key: saveUserID);
    var userId = 0;
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/UserRegistration/RegisterUserNew?hdnUserID=$userId&FName=$firstName&LName=$lastName&SexType=$sexType&Email=$email&Password=$password&Phone=$mobileNumber&Landline=''&Address=''&City=''&CountryType=0&hdnUserType=''&UserHostAddress=''&hdnRegistrationType=''&SmsAmount=''&RegistrationPeriod=''&chkSms=''&chkPortfolio=''&socialToken=''&socialStatus=$socialStatus",
      );
      return RegisterNewSocialUserResponse.fromJson(response.data!);
    } catch (e) {
      return null;
    }
  }
}

class DioRegister {
  // Checking whether the number is already registered or not
  Future<CheckUserExistsResponseModel?> checkUser(String number) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/LoginRegistration/CheckUserExists?mobileNUmber=$number",
      );
      return checkUserExistsResponseModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Register with Mobile Number
  Future<SignUpLoginResponseModel?> registerUser(
      {required SignUpLoginRequestModel signUpLoginRequestModel}) async {
    try {
      Dio dio = await postClient();
      Response<String> response = await dio.post(
        "/api/LoginRegistration/UserRegistration?userAuth.id=1",
        data: signUpLoginRequestModel.toJson(),
      );
      return signUpLoginResponseModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Sending the OPT Code
  Future<VerifyPinOtpCodeResponseModel?> verifyPinOtpCode(
      {required VerifyPinOtpCodeRequestModel
          verifyPinOtpCodeRequestModel}) async {
    try {
      Dio dio = await postClient();
      Response<String> response = await dio.post(
        "/api/LoginRegistration/CreatePinCode?userAuth.id=1",
        data: verifyPinOtpCodeRequestModel.toJson(),
      );
      return verifyPinOtpCodeResponseModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Resending the OTP Code
  Future<ResendOtpResponseModel?> resendOtpCode(
      {required SignUpLoginRequestModel signUpLoginRequestModel}) async {
    try {
      Dio dio = await postClient();
      Response<String> response = await dio.post(
        "/api/LoginRegistration/ReSendOTPCode?userAuth.id=1",
        data: signUpLoginRequestModel.toJson(),
      );
      return resendOtpResponseModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }
}
