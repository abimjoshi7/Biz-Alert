// To parse this JSON data, do
//
//     final verifyPinOtpCodeResponseModel = verifyPinOtpCodeResponseModelFromJson(jsonString);

import 'dart:convert';

VerifyPinOtpCodeResponseModel verifyPinOtpCodeResponseModelFromJson(
        String str) =>
    VerifyPinOtpCodeResponseModel.fromJson(json.decode(str));

String verifyPinOtpCodeResponseModelToJson(
        VerifyPinOtpCodeResponseModel data) =>
    json.encode(data.toJson());

class VerifyPinOtpCodeResponseModel {
  VerifyPinOtpCodeResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory VerifyPinOtpCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyPinOtpCodeResponseModel(
        status: json["status"],
        message: json["message"],
        dataCollection: DataCollection.fromJson(json["dataCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection.toJson(),
      };
}

class DataCollection {
  DataCollection({
    required this.d,
  });

  final D d;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        d: D.fromJson(json["d"]),
      );

  Map<String, dynamic> toJson() => {
        "d": d.toJson(),
      };
}

class D {
  D({
    required this.type,
    required this.status,
    required this.message,
  });

  final String type;
  final String status;
  final String message;

  factory D.fromJson(Map<String, dynamic> json) => D(
        type: json["__type"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "status": status,
        "message": message,
      };
}
