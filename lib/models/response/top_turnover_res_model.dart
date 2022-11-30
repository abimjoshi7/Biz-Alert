// To parse this JSON data, do
//
//     final topTurnoverModel = topTurnoverModelFromJson(jsonString);

import 'dart:convert';

TopTurnoverModel topTurnoverModelFromJson(String str) =>
    TopTurnoverModel.fromJson(json.decode(str));

String topTurnoverModelToJson(TopTurnoverModel data) =>
    json.encode(data.toJson());

class TopTurnoverModel {
  TopTurnoverModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory TopTurnoverModel.fromJson(Map<String, dynamic> json) =>
      TopTurnoverModel(
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
    required this.stockSymbol,
    required this.companyName,
    required this.lastTradePrice,
    required this.turnover,
    required this.percentageChangeInPrice,
    required this.highestPrice,
    required this.lowestPrice,
    required this.totalTradedVolume,
    required this.openingPrice,
    required this.date,
  });

  final String stockSymbol;
  final String companyName;
  final double lastTradePrice;
  final String turnover;
  final double percentageChangeInPrice;
  final double highestPrice;
  final double lowestPrice;
  final int totalTradedVolume;
  final double openingPrice;
  // final Date? date;
  final String? date;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        stockSymbol: json["StockSymbol"],
        companyName: json["CompanyName"],
        lastTradePrice: json["LastTradePrice"].toDouble(),
        turnover: json["Turnover"],
        percentageChangeInPrice: json["PercentageChangeInPrice"].toDouble(),
        highestPrice: json["HighestPrice"].toDouble(),
        lowestPrice: json["LowestPrice"].toDouble(),
        totalTradedVolume: json["TotalTradedVolume"],
        openingPrice: json["OpeningPrice"].toDouble(),
        // date: dateValues.map[json["date"]],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "StockSymbol": stockSymbol,
        "CompanyName": companyName,
        "LastTradePrice": lastTradePrice,
        "Turnover": turnover,
        "PercentageChangeInPrice": percentageChangeInPrice,
        "HighestPrice": highestPrice,
        "LowestPrice": lowestPrice,
        "TotalTradedVolume": totalTradedVolume,
        "OpeningPrice": openingPrice,
        // "date": dateValues.reverse[date],
        "date": date,
      };
}

// enum Date { THE_20211214123200 }

// final dateValues = EnumValues({"2021/12/14 12:32:00": Date.THE_20211214123200});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap ??= map.map((k, v) => MapEntry(v, k));
//     return reverseMap!;
//   }
// }
