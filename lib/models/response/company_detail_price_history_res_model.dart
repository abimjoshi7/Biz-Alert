// To parse this JSON data, do
//
//     final companyDetailPriceHistoryResModel = companyDetailPriceHistoryResModelFromMap(jsonString);

import 'dart:convert';

CompanyDetailPriceHistoryResModel companyDetailPriceHistoryResModelFromMap(
        String str) =>
    CompanyDetailPriceHistoryResModel.fromMap(json.decode(str));

String companyDetailPriceHistoryResModelToMap(
        CompanyDetailPriceHistoryResModel data) =>
    json.encode(data.toMap());

class CompanyDetailPriceHistoryResModel {
  CompanyDetailPriceHistoryResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  CompanyDetailPriceHistoryResModel copyWith({
    String? status,
    String? message,
    List<DataCollection>? dataCollection,
  }) =>
      CompanyDetailPriceHistoryResModel(
        status: status ?? this.status,
        message: message ?? this.message,
        dataCollection: dataCollection ?? this.dataCollection,
      );

  factory CompanyDetailPriceHistoryResModel.fromMap(
          Map<String, dynamic> json) =>
      CompanyDetailPriceHistoryResModel(
        status: json["status"],
        message: json["message"],
        dataCollection: List<DataCollection>.from(
            json["dataCollection"].map((x) => DataCollection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "dataCollection":
            List<dynamic>.from(dataCollection.map((x) => x.toMap())),
      };
}

class DataCollection {
  DataCollection({
    required this.id,
    required this.dateTime,
    required this.ltp,
    required this.percentageChange,
    required this.high,
    required this.low,
    required this.open,
    required this.qty,
    required this.turnover,
  });

  final int id;
  final String dateTime;
  final String ltp;
  final String percentageChange;
  final String high;
  final String low;
  final String open;
  final String qty;
  final String turnover;

  DataCollection copyWith({
    int? id,
    String? dateTime,
    String? ltp,
    String? percentageChange,
    String? high,
    String? low,
    String? open,
    String? qty,
    String? turnover,
  }) =>
      DataCollection(
        id: id ?? this.id,
        dateTime: dateTime ?? this.dateTime,
        ltp: ltp ?? this.ltp,
        percentageChange: percentageChange ?? this.percentageChange,
        high: high ?? this.high,
        low: low ?? this.low,
        open: open ?? this.open,
        qty: qty ?? this.qty,
        turnover: turnover ?? this.turnover,
      );

  factory DataCollection.fromMap(Map<String, dynamic> json) => DataCollection(
        id: json["ID"],
        dateTime: json["DateTime"],
        ltp: json["LTP"],
        percentageChange: json["PercentageChange"],
        high: json["High"],
        low: json["Low"],
        open: json["Open"],
        qty: json["Qty"],
        turnover: json["Turnover"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "DateTime": dateTime,
        "LTP": ltp,
        "PercentageChange": percentageChange,
        "High": high,
        "Low": low,
        "Open": open,
        "Qty": qty,
        "Turnover": turnover,
      };
}
