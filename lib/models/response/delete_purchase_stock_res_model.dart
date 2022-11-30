// To parse this JSON data, do
//
//     final deletePurchaseStockResponseModel = deletePurchaseStockResponseModelFromJson(jsonString);

import 'dart:convert';

DeletePurchaseStockResponseModel deletePurchaseStockResponseModelFromJson(
        String str) =>
    DeletePurchaseStockResponseModel.fromJson(json.decode(str));

String deletePurchaseStockResponseModelToJson(
        DeletePurchaseStockResponseModel data) =>
    json.encode(data.toJson());

class DeletePurchaseStockResponseModel {
  DeletePurchaseStockResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory DeletePurchaseStockResponseModel.fromJson(
          Map<String, dynamic> json) =>
      DeletePurchaseStockResponseModel(
        status: json["status"],
        message: json["message"],
        dataCollection: DataCollection.fromJson(json["dataCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dataCollection": dataCollection.toJson(),
      };
}

class DataCollection {
  DataCollection({
    required this.purchaseShare,
    required this.totalPage,
  });

  final List<PurchaseShare> purchaseShare;
  final int totalPage;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        purchaseShare: List<PurchaseShare>.from(
            json["purchaseShare"].map((x) => PurchaseShare.fromJson(x))),
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "purchaseShare":
            List<dynamic>.from(purchaseShare.map((x) => x.toJson())),
        "totalPage": totalPage,
      };
}

class PurchaseShare {
  PurchaseShare({
    required this.shareType,
    required this.shareTypeCode,
    required this.transactionDateAd,
    required this.transactionDateBs,
    required this.transactionNo,
    required this.companyName,
    required this.stockSymbol,
    required this.quantity,
    required this.remQuantity,
    required this.rate,
    required this.broker,
    required this.portfolio,
    required this.shareholder,
    required this.userTransactionId,
    required this.lastTradePrice,
  });

  final String shareType;
  final String shareTypeCode;
  final String transactionDateAd;
  final String transactionDateBs;
  final String transactionNo;
  final String companyName;
  final String stockSymbol;
  final String quantity;
  final String remQuantity;
  final String rate;
  final String broker;
  final String portfolio;
  final String shareholder;
  final String userTransactionId;
  final double lastTradePrice;

  factory PurchaseShare.fromJson(Map<String, dynamic> json) => PurchaseShare(
        shareType: json["shareType"],
        shareTypeCode: json["shareTypeCode"],
        transactionDateAd: json["transactionDateAD"],
        transactionDateBs: json["transactionDateBS"],
        transactionNo: json["transactionNo"],
        companyName: json["companyName"],
        stockSymbol: json["stockSymbol"],
        quantity: json["quantity"],
        remQuantity: json["remQuantity"],
        rate: json["rate"],
        broker: json["broker"],
        portfolio: json["portfolio"],
        shareholder: json["shareholder"],
        userTransactionId: json["userTransactionId"],
        lastTradePrice: json["LastTradePrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "shareType": shareType,
        "shareTypeCode": shareTypeCode,
        "transactionDateAD": transactionDateAd,
        "transactionDateBS": transactionDateBs,
        "transactionNo": transactionNo,
        "companyName": companyName,
        "stockSymbol": stockSymbol,
        "quantity": quantity,
        "remQuantity": remQuantity,
        "rate": rate,
        "broker": broker,
        "portfolio": portfolio,
        "shareholder": shareholder,
        "userTransactionId": userTransactionId,
        "LastTradePrice": lastTradePrice,
      };
}
