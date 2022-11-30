// To parse this JSON data, do
//
//     final getResponseWatchList = getResponseWatchListFromJson(jsonString);

import 'dart:convert';

GetResponseWatchList getResponseWatchListFromJson(Map<String, dynamic> json) =>
    GetResponseWatchList.fromJson(json);

String getResponseWatchListToJson(GetResponseWatchList data) =>
    json.encode(data.toJson());

class GetResponseWatchList {
  GetResponseWatchList({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory GetResponseWatchList.fromJson(Map<String, dynamic> json) =>
      GetResponseWatchList(
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
    required this.data,
  });

  final String msg;
  final List<Datum> data;

  factory D.fromJson(Map<String, dynamic> json) => D(
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.companyId,
    required this.symbol,
    required this.companyName,
    required this.ltp,
    required this.percentChange,
    required this.open,
    required this.high,
    required this.low,
    required this.qty,
    required this.turnover,
    required this.pltp,
    required this.order,
  });

  final int companyId;
  final String symbol;
  final String companyName;
  final double ltp;
  final double percentChange;
  final double open;
  final double high;
  final double low;
  final int qty;
  final double turnover;
  final double pltp;
  final int order;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        companyId: json["CompanyID"],
        symbol: json["Symbol"],
        companyName: json["CompanyName"],
        ltp: json["LTP"].toDouble(),
        percentChange: json["PercentChange"].toDouble(),
        open: json["Open"].toDouble(),
        high: json["High"].toDouble(),
        low: json["Low"].toDouble(),
        qty: json["Qty"],
        turnover: json["Turnover"].toDouble(),
        pltp: json["PLTP"].toDouble(),
        order: json["Order"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyID": companyId,
        "Symbol": symbol,
        "CompanyName": companyName,
        "LTP": ltp,
        "PercentChange": percentChange,
        "Open": open,
        "High": high,
        "Low": low,
        "Qty": qty,
        "Turnover": turnover,
        "PLTP": pltp,
        "Order": order,
      };
}
