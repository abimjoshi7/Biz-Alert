// Mobile Number Registration and Mobile Number Login and ReSend OTP Code

// To parse this JSON data, do
//
//     final signUpLoginRequestModel = signUpLoginRequestModelFromJson(jsonString);

import 'dart:convert';

SignUpLoginRequestModel signUpLoginRequestModelFromJson(String str) =>
    SignUpLoginRequestModel.fromJson(json.decode(str));

String signUpLoginRequestModelToJson(SignUpLoginRequestModel data) =>
    json.encode(data.toJson());

class SignUpLoginRequestModel {
  SignUpLoginRequestModel({
    required this.mobileNumber,
  });

  final String mobileNumber;

  factory SignUpLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      SignUpLoginRequestModel(
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNumber,
      };
}
