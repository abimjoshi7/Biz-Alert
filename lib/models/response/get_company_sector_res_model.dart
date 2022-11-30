// To parse this JSON data, do
//
//     final getCompanyBySectorResponseModel = getCompanyBySectorResponseModelFromJson(jsonString);

import 'dart:convert';

GetCompanyBySectorResponseModel getCompanyBySectorResponseModelFromJson(
        String str) =>
    GetCompanyBySectorResponseModel.fromJson(json.decode(str));

String getCompanyBySectorResponseModelToJson(
        GetCompanyBySectorResponseModel data) =>
    json.encode(data.toJson());

class GetCompanyBySectorResponseModel {
  GetCompanyBySectorResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory GetCompanyBySectorResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyBySectorResponseModel(
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
    required this.companyId,
    required this.companyName,
    required this.stockSymbol,
  });

  final int companyId;
  final String companyName;
  final String stockSymbol;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        companyId: json["CompanyID"],
        companyName: json["CompanyName"],
        stockSymbol: json["StockSymbol"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyID": companyId,
        "CompanyName": companyName,
        "StockSymbol": stockSymbol,
      };
}
