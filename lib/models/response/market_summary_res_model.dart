// To parse this JSON data, do
//
//     final marketSummaryModel = marketSummaryModelFromJson(jsonString);

import 'dart:convert';

MarketSummaryModel marketSummaryModelFromJson(String str) =>
    MarketSummaryModel.fromJson(json.decode(str));

String marketSummaryModelToJson(MarketSummaryModel data) =>
    json.encode(data.toJson());

class MarketSummaryModel {
  MarketSummaryModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory MarketSummaryModel.fromJson(Map<String, dynamic> json) =>
      MarketSummaryModel(
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
    required this.asofDate,
    required this.totalTurnover,
    required this.tradeshares,
    required this.totalTransactions,
    required this.totalScriptsTraded,
    required this.totalMarketCapitalization,
    required this.floatedMarketCapitalization,
  });

  final String asofDate;
  final String totalTurnover;
  final String tradeshares;
  final String totalTransactions;
  final String totalScriptsTraded;
  final String totalMarketCapitalization;
  final String floatedMarketCapitalization;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        asofDate: json["AsofDate"],
        totalTurnover: json["TotalTurnover"],
        tradeshares: json["Tradeshares"],
        totalTransactions: json["TotalTransactions"],
        totalScriptsTraded: json["TotalScriptsTraded"],
        totalMarketCapitalization: json["TotalMarketCapitalization"],
        floatedMarketCapitalization: json["FloatedMarketCapitalization"],
      );

  Map<String, dynamic> toJson() => {
        "AsofDate": asofDate,
        "TotalTurnover": totalTurnover,
        "Tradeshares": tradeshares,
        "TotalTransactions": totalTransactions,
        "TotalScriptsTraded": totalScriptsTraded,
        "TotalMarketCapitalization": totalMarketCapitalization,
        "FloatedMarketCapitalization": floatedMarketCapitalization,
      };
}
