// To parse this JSON data, do
//
//     final getTodaysSharePriceResponseModel = getTodaysSharePriceResponseModelFromJson(jsonString);

import 'dart:convert';

GetTodaysSharePriceResponseModel getTodaysSharePriceResponseModelFromJson(
        String str) =>
    GetTodaysSharePriceResponseModel.fromJson(json.decode(str));

String getTodaysSharePriceResponseModelToJson(
        GetTodaysSharePriceResponseModel data) =>
    json.encode(data.toJson());

class GetTodaysSharePriceResponseModel {
  GetTodaysSharePriceResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory GetTodaysSharePriceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetTodaysSharePriceResponseModel(
        status: json["status"],
        message: json["message"],
        dataCollection: List<DataCollection>.from(
            json["dataCollection"].map((x) => DataCollection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection":
            List<dynamic>.from(dataCollection.map((x) => x.toJson())),
      };
}

class DataCollection {
  DataCollection({
    required this.id,
    required this.companyName,
    required this.symbol,
    required this.lastTradePrice,
    required this.percentageChangeInPrice,
    required this.highestPrice,
    required this.lowestPrice,
    required this.totalTradedVolume,
    required this.openingPrice,
    required this.turnover,
    required this.date,
    required this.perviousClose,
  });

  final int id;
  final String companyName;
  final String symbol;
  final String lastTradePrice;
  final String percentageChangeInPrice;
  final String highestPrice;
  final String lowestPrice;
  final String totalTradedVolume;
  final String openingPrice;
  final String turnover;
  final String date;
  final String perviousClose;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        id: json["ID"],
        companyName: json["CompanyName"],
        symbol: json["Symbol"],
        lastTradePrice: json["LastTradePrice"],
        percentageChangeInPrice: json["PercentageChangeInPrice"],
        highestPrice: json["HighestPrice"],
        lowestPrice: json["LowestPrice"],
        totalTradedVolume: json["TotalTradedVolume"],
        openingPrice: json["OpeningPrice"],
        turnover: json["Turnover"],
        date: json["Date"],
        perviousClose: json["PerviousClose"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CompanyName": companyName,
        "Symbol": symbol,
        "LastTradePrice": lastTradePrice,
        "PercentageChangeInPrice": percentageChangeInPrice,
        "HighestPrice": highestPrice,
        "LowestPrice": lowestPrice,
        "TotalTradedVolume": totalTradedVolume,
        "OpeningPrice": openingPrice,
        "Turnover": turnover,
        "Date": date,
        "PerviousClose": perviousClose,
      };
}
