// To parse this JSON data, do
//
//     final getOtpResModel = getOtpResModelFromMap(jsonString);

import 'dart:convert';

GetOtpResModel getOtpResModelFromMap(String str) =>
    GetOtpResModel.fromMap(json.decode(str));

String getOtpResModelToMap(GetOtpResModel data) => json.encode(data.toMap());

class GetOtpResModel {
  GetOtpResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  GetOtpResModel copyWith({
    String? status,
    String? message,
    DataCollection? dataCollection,
  }) =>
      GetOtpResModel(
        status: status ?? this.status,
        message: message ?? this.message,
        dataCollection: dataCollection ?? this.dataCollection,
      );

  factory GetOtpResModel.fromMap(Map<String, dynamic> json) => GetOtpResModel(
        status: json["status"],
        message: json["message"],
        dataCollection: DataCollection.fromMap(json["dataCollection"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection.toMap(),
      };
}

class DataCollection {
  DataCollection({
    required this.msg,
  });

  final String msg;

  DataCollection copyWith({
    String? msg,
  }) =>
      DataCollection(
        msg: msg ?? this.msg,
      );

  factory DataCollection.fromMap(Map<String, dynamic> json) => DataCollection(
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
      };
}
