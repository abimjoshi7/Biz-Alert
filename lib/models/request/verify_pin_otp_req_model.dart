// To parse this JSON data, do
//
//     final verifyPinOtpCodeRequestModel = verifyPinOtpCodeRequestModelFromJson(jsonString);

import 'dart:convert';

VerifyPinOtpCodeRequestModel verifyPinOtpCodeRequestModelFromJson(String str) =>
    VerifyPinOtpCodeRequestModel.fromJson(json.decode(str));

String verifyPinOtpCodeRequestModelToJson(VerifyPinOtpCodeRequestModel data) =>
    json.encode(data.toJson());

class VerifyPinOtpCodeRequestModel {
  VerifyPinOtpCodeRequestModel({
    required this.mobileNumber,
    required this.otpCode,
    required this.pinCode,
  });

  final String mobileNumber;
  final String otpCode;
  final String pinCode;

  factory VerifyPinOtpCodeRequestModel.fromJson(Map<String, dynamic> json) =>
      VerifyPinOtpCodeRequestModel(
        mobileNumber: json["mobileNumber"],
        otpCode: json["otpCode"],
        pinCode: json["pinCode"],
      );

  Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNumber,
        "otpCode": otpCode,
        "pinCode": pinCode,
      };
}
