// To parse this JSON data, do
//
//     final sellStockRequestModel = sellStockRequestModelFromJson(jsonString);

import 'dart:convert';

SellStockRequestModel sellStockRequestModelFromJson(String str) =>
    SellStockRequestModel.fromJson(json.decode(str));

String sellStockRequestModelToJson(SellStockRequestModel data) =>
    json.encode(data.toJson());

class SellStockRequestModel {
  SellStockRequestModel({
    required this.transactionDate,
    required this.sellRate,
    required this.stockSymbol,
    required this.purchaseArray,
  });

  final String transactionDate;
  final String sellRate;
  final String stockSymbol;
  final List<PurchaseArray> purchaseArray;

  factory SellStockRequestModel.fromJson(Map<String, dynamic> json) =>
      SellStockRequestModel(
        transactionDate: json["transactionDate"],
        sellRate: json["sellRate"],
        stockSymbol: json["stockSymbol"],
        purchaseArray: List<PurchaseArray>.from(
            json["purchaseArray"].map((x) => PurchaseArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactionDate": transactionDate,
        "sellRate": sellRate,
        "stockSymbol": stockSymbol,
        "purchaseArray":
            List<dynamic>.from(purchaseArray.map((x) => x.toJson())),
      };
}

class PurchaseArray {
  PurchaseArray({
    required this.quantity,
    required this.purchaseRate,
    required this.shareTypeId,
    required this.basePrice,
    required this.cgtRate,
    required this.purchaseDate,
  });

  final String quantity;
  final String purchaseRate;
  final String shareTypeId;
  final String basePrice;
  final String cgtRate;
  final String purchaseDate;

  factory PurchaseArray.fromJson(Map<String, dynamic> json) => PurchaseArray(
        quantity: json["quantity"],
        purchaseRate: json["purchaseRate"],
        shareTypeId: json["shareTypeId"],
        basePrice: json["basePrice"],
        cgtRate: json["cgtRate"],
        purchaseDate: json["purchaseDate"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "purchaseRate": purchaseRate,
        "shareTypeId": shareTypeId,
        "basePrice": basePrice,
        "cgtRate": cgtRate,
        "purchaseDate": purchaseDate,
      };
}
