// To parse this JSON data, do
//
//     final stockDbModel = stockDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'hivemodel.g.dart';

StockDbModel stockDbModelFromJson(String str) =>
    StockDbModel.fromJson(json.decode(str));

String stockDbModelToJson(StockDbModel data) => json.encode(data.toJson());

@HiveType(typeId: 0, adapterName: "ServiceAdapter")
class StockDbModel {
  StockDbModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  @HiveField(0)
  final String status;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final List<DataCollection> dataCollection;

  factory StockDbModel.fromJson(Map<String, dynamic> json) => StockDbModel(
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

@HiveType(typeId: 1, adapterName: "ServiceAdapter1")
class DataCollection {
  DataCollection({
    this.companyId,
    required this.companyName,
    required this.stockSymbol,
  });

  @HiveField(3)
  final int? companyId;

  @HiveField(4)
  final String companyName;

  @HiveField(5)
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
