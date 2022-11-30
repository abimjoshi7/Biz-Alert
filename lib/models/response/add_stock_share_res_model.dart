// To parse this JSON data, do
//
//     final addStockShareResponseModel = addStockShareResponseModelFromJson(jsonString);

import 'dart:convert';

AddStockShareResponseModel addStockShareResponseModelFromJson(String str) =>
    AddStockShareResponseModel.fromJson(json.decode(str));

String addStockShareResponseModelToJson(AddStockShareResponseModel data) =>
    json.encode(data.toJson());

class AddStockShareResponseModel {
  AddStockShareResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final dynamic dataCollection;

  factory AddStockShareResponseModel.fromJson(Map<String, dynamic> json) =>
      AddStockShareResponseModel(
        status: json["status"],
        message: json["message"],
        dataCollection: json["dataCollection"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection,
      };
}
