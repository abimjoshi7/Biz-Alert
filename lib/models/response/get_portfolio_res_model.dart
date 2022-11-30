// To parse this JSON data, do
//
//     final getPortfolioResponseModel = getPortfolioResponseModelFromJson(jsonString);

import 'dart:convert';

GetPortfolioResponseModel getPortfolioResponseModelFromJson(String str) =>
    GetPortfolioResponseModel.fromJson(json.decode(str));

String getPortfolioResponseModelToJson(GetPortfolioResponseModel data) =>
    json.encode(data.toJson());

class GetPortfolioResponseModel {
  GetPortfolioResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory GetPortfolioResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPortfolioResponseModel(
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
    required this.portfolioName,
    required this.portfolioId,
  });

  final String portfolioName;
  final int portfolioId;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        portfolioName: json["portfolioName"],
        portfolioId: json["portfolioID"],
      );

  Map<String, dynamic> toJson() => {
        "portfolioName": portfolioName,
        "portfolioID": portfolioId,
      };
}
