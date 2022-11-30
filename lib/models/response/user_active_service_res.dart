// To parse this JSON data, do
//
//     final userActiveServiceResponseModel = userActiveServiceResponseModelFromJson(jsonString);

import 'dart:convert';

UserActiveServiceResponseModel userActiveServiceResponseModelFromJson(
        String str) =>
    UserActiveServiceResponseModel.fromJson(json.decode(str));

String userActiveServiceResponseModelToJson(
        UserActiveServiceResponseModel data) =>
    json.encode(data.toJson());

class UserActiveServiceResponseModel {
  UserActiveServiceResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory UserActiveServiceResponseModel.fromJson(Map<String, dynamic> json) =>
      UserActiveServiceResponseModel(
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
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.isRecurriing,
    required this.packageCode,
    required this.serviceTypeId,
    required this.packageName,
    required this.serviceExpirationDate,
    required this.isExpired,
    required this.subscriptionMessage,
  });

  final bool isRecurriing;
  final int packageCode;
  final int serviceTypeId;
  final String packageName;
  final String serviceExpirationDate;
  final int isExpired;
  final String subscriptionMessage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isRecurriing: json["IsRecurriing"],
        packageCode: json["PackageCode"],
        serviceTypeId: json["ServiceTypeId"],
        packageName: json["PackageName"],
        serviceExpirationDate: json["ServiceExpirationDate"],
        isExpired: json["IsExpired"],
        subscriptionMessage: json["SubscriptionMessage"],
      );

  Map<String, dynamic> toJson() => {
        "IsRecurriing": isRecurriing,
        "PackageCode": packageCode,
        "ServiceTypeId": serviceTypeId,
        "PackageName": packageName,
        "ServiceExpirationDate": serviceExpirationDate,
        "IsExpired": isExpired,
        "SubscriptionMessage": subscriptionMessage,
      };
}
