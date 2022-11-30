// To parse this JSON data, do
//
//     final addStockRequestModel = addStockRequestModelFromJson(jsonString);

import 'dart:convert';

AddStockRequestModel addStockRequestModelFromJson(String str) =>
    AddStockRequestModel.fromJson(json.decode(str));

String addStockRequestModelToJson(AddStockRequestModel data) =>
    json.encode(data.toJson());

class AddStockRequestModel {
  AddStockRequestModel({
    required this.transactionDate,
    required this.shareType,
    required this.stockSymbol,
    required this.quantity,
    required this.rate,
  });

  final String transactionDate;
  final int shareType;
  final String stockSymbol;
  final int quantity;
  final double rate;

  factory AddStockRequestModel.fromJson(Map<String, dynamic> json) =>
      AddStockRequestModel(
        transactionDate: json["transactionDate"],
        shareType: json["shareType"],
        stockSymbol: json["stockSymbol"],
        quantity: json["quantity"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "transactionDate": transactionDate,
        "shareType": shareType,
        "stockSymbol": stockSymbol,
        "quantity": quantity,
        "rate": rate,
      };
}
