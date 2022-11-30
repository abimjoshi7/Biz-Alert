import 'dart:developer';

import 'package:biz_alert/models/response/get_otp_res_model.dart';
import 'package:dio/dio.dart';

import '../../../../constants/helper.dart';

class DioOtp {
  Future<GetOtpResModel?> getOtp(String phoneNumber) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/UserRegistration/GetVerificationCode?mobileno=$phoneNumber",
      );
      log(response.data!);
      return getOtpResModelFromMap(response.data!);
    } catch (e) {
      log('Error getting OTP: $e');
      rethrow;
    }
  }
}
