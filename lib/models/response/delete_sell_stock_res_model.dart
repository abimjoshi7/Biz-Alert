// To parse this JSON data, do
//
//     final deleteSellStockResponseModel = deleteSellStockResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteSellStockResponseModel deleteSellStockResponseModelFromJson(String str) =>
    DeleteSellStockResponseModel.fromJson(json.decode(str));

String deleteSellStockResponseModelToJson(DeleteSellStockResponseModel data) =>
    json.encode(data.toJson());

class DeleteSellStockResponseModel {
  DeleteSellStockResponseModel({
    this.status,
    this.message,
    this.dataCollection,
  });

  final String? status;
  final String? message;
  final DataCollection? dataCollection;

  factory DeleteSellStockResponseModel.fromJson(Map<String, dynamic> json) =>
      DeleteSellStockResponseModel(
        status: json["status"],
        message: json["message"],
        dataCollection: DataCollection.fromJson(json["dataCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection?.toJson(),
      };
}

class DataCollection {
  DataCollection({
    this.soldShare,
    this.totalPage,
  });

  final List<SoldShare>? soldShare;
  final int? totalPage;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        soldShare: List<SoldShare>.from(
            json["soldShare"].map((x) => SoldShare.fromJson(x))),
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "soldShare": List<dynamic>.from(soldShare!.map((x) => x.toJson())),
        "totalPage": totalPage,
      };
}

class SoldShare {
  SoldShare({
    this.transactionDateAd,
    this.transactionDateBs,
    this.transactionNo,
    this.companyName,
    this.stockSymbol,
    this.quantity,
    this.rate,
    this.broker,
    this.userTransactionId,
    this.lastTradePrice,
  });

  final String? transactionDateAd;
  final String? transactionDateBs;
  final String? transactionNo;
  final String? companyName;
  final String? stockSymbol;
  final String? quantity;
  final String? rate;
  final String? broker;
  final String? userTransactionId;
  final double? lastTradePrice;

  factory SoldShare.fromJson(Map<String, dynamic> json) => SoldShare(
        transactionDateAd: json["transactionDateAD"],
        transactionDateBs: json["transactionDateBS"],
        transactionNo: json["transactionNo"],
        companyName: json["companyName"],
        stockSymbol: json["stockSymbol"],
        quantity: json["quantity"],
        rate: json["rate"],
        broker: json["broker"],
        userTransactionId: json["userTransactionId"],
        lastTradePrice: json["LastTradePrice"],
      );

  Map<String, dynamic> toJson() => {
        "transactionDateAD": transactionDateAd,
        "transactionDateBS": transactionDateBs,
        "transactionNo": transactionNo,
        "companyName": companyName,
        "stockSymbol": stockSymbol,
        "quantity": quantity,
        "rate": rate,
        "broker": broker,
        "userTransactionId": userTransactionId,
        "LastTradePrice": lastTradePrice,
      };
}
