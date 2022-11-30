// To parse this JSON data, do
//
//     final getIndicesModel = getIndicesModelFromJson(jsonString);

import 'dart:convert';

GetIndicesModel getIndicesModelFromJson(String str) =>
    GetIndicesModel.fromJson(json.decode(str));

String getIndicesModelToJson(GetIndicesModel data) =>
    json.encode(data.toJson());

class GetIndicesModel {
  GetIndicesModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  factory GetIndicesModel.fromJson(Map<String, dynamic> json) =>
      GetIndicesModel(
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
    required this.name,
    required this.value,
    required this.percentageChange,
    required this.isSubindex,
    required this.datetime,
    required this.order,
    required this.pointChange,
  });

  final String name;
  final double value;
  final double percentageChange;
  final int isSubindex;
  final String datetime;
  final int order;
  final double pointChange;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        name: json["Name"],
        value: json["Value"].toDouble(),
        percentageChange: json["PercentageChange"].toDouble(),
        isSubindex: json["IsSubindex"],
        datetime: json["datetime"],
        order: json["order"],
        pointChange: json["pointChange"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Value": value,
        "PercentageChange": percentageChange,
        "IsSubindex": isSubindex,
        "datetime": datetime,
        "order": order,
        "pointChange": pointChange,
      };
}
