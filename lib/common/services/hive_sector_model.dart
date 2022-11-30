// To parse this JSON data, do
//
//     final stockSectorDbModel = stockSectorDbModelFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'hive_sector_model.g.dart';

StockSectorDbModel stockSectorDbModelFromJson(String str) =>
    StockSectorDbModel.fromJson(json.decode(str));

String stockSectorDbModelToJson(StockSectorDbModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: 3, adapterName: "SectorAdapter")
class StockSectorDbModel {
  StockSectorDbModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  @HiveField(6)
  final String status;

  @HiveField(7)
  final String message;

  @HiveField(8)
  final List<DataCollection> dataCollection;

  factory StockSectorDbModel.fromJson(Map<String, dynamic> json) =>
      StockSectorDbModel(
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

@HiveType(typeId: 4, adapterName: "SectorAdapter1")
class DataCollection {
  DataCollection({
    required this.sectorName,
    required this.sectorId,
  });
  @HiveField(9)
  final String sectorName;

  @HiveField(10)
  final int sectorId;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        sectorName: json["SectorName"],
        sectorId: json["SectorID"],
      );

  Map<String, dynamic> toJson() => {
        "SectorName": sectorName,
        "SectorID": sectorId,
      };
}
