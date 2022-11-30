// To parse this JSON data, do
//
//     final getSavedWatchlistAlertResponse = getSavedWatchlistAlertResponseFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetSavedWatchlistAlertResponse getSavedWatchlistAlertResponseFromJson(
        Map<String, dynamic> json) =>
    GetSavedWatchlistAlertResponse.fromJson(json);

String getSavedWatchlistAlertResponseToJson(
        GetSavedWatchlistAlertResponse data) =>
    json.encode(data.toJson());

class GetSavedWatchlistAlertResponse {
  GetSavedWatchlistAlertResponse({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory GetSavedWatchlistAlertResponse.fromJson(Map<String, dynamic> json) =>
      GetSavedWatchlistAlertResponse(
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
    required this.msg,
    required this.alert,
  });

  final String msg;
  final List<Alert> alert;

  factory D.fromJson(Map<String, dynamic> json) => D(
        msg: json["msg"],
        alert: List<Alert>.from(json["alert"].map((x) => Alert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "alert": List<dynamic>.from(alert.map((x) => x.toJson())),
      };
}

class Alert {
  Alert({
    required this.userId,
    required this.companyId,
    required this.stockSymbol,
    required this.companyName,
    required this.isAlertEnabled,
    required this.sendEmailOnIncrease,
    required this.sendSmsOnIncrease,
    required this.sendEmailOnDecrease,
    required this.sendSmsOnDecrease,
    required this.increasePrice,
    required this.decreasePrice,
  });

  final int userId;
  final int companyId;
  final String stockSymbol;
  final String companyName;
  final int isAlertEnabled;
  final int sendEmailOnIncrease;
  final int sendSmsOnIncrease;
  final int sendEmailOnDecrease;
  final int sendSmsOnDecrease;
  final int increasePrice;
  final int decreasePrice;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        userId: json["UserID"],
        companyId: json["CompanyID"],
        stockSymbol: json["StockSymbol"],
        companyName: json["CompanyName"],
        isAlertEnabled: json["IsAlertEnabled"],
        sendEmailOnIncrease: json["SendEmailOnIncrease"],
        sendSmsOnIncrease: json["SendSmsOnIncrease"],
        sendEmailOnDecrease: json["SendEmailOnDecrease"],
        sendSmsOnDecrease: json["SendSmsOnDecrease"],
        increasePrice: json["IncreasePrice"],
        decreasePrice: json["DecreasePrice"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "CompanyID": companyId,
        "StockSymbol": stockSymbol,
        "CompanyName": companyName,
        "IsAlertEnabled": isAlertEnabled,
        "SendEmailOnIncrease": sendEmailOnIncrease,
        "SendSmsOnIncrease": sendSmsOnIncrease,
        "SendEmailOnDecrease": sendEmailOnDecrease,
        "SendSmsOnDecrease": sendSmsOnDecrease,
        "IncreasePrice": increasePrice,
        "DecreasePrice": decreasePrice,
      };
}
