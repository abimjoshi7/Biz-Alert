// To parse this JSON data, do
//
//     final sellStockResponseModel = sellStockResponseModelFromJson(jsonString);

import 'dart:convert';

SellStockResponseModel sellStockResponseModelFromJson(String str) =>
    SellStockResponseModel.fromJson(json.decode(str));

String sellStockResponseModelToJson(SellStockResponseModel data) =>
    json.encode(data.toJson());

class SellStockResponseModel {
  SellStockResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory SellStockResponseModel.fromJson(Map<String, dynamic> json) =>
      SellStockResponseModel(
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
    required this.d,
  });

  final D d;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        d: D.fromJson(json["d"]),
      );

  Map<String, dynamic> toJson() => {
        "d": d.toJson(),
      };
}

class D {
  D({
    required this.quantity,
    required this.purchaseCost,
    required this.salesAmount,
    required this.brokerCommission,
    required this.seboCommission,
    required this.dpCharge,
    required this.averageRate,
    required this.totalReceivableBeforeCgt,
    required this.profitBeforeCgt,
    required this.cgtAmount,
    required this.netReceivable,
    required this.netProfit,
  });

  final dynamic quantity;
  final dynamic purchaseCost;
  final dynamic salesAmount;
  final dynamic brokerCommission;
  final dynamic seboCommission;
  final dynamic dpCharge;
  final dynamic averageRate;
  final dynamic totalReceivableBeforeCgt;
  final dynamic profitBeforeCgt;
  final dynamic cgtAmount;
  final dynamic netReceivable;
  final dynamic netProfit;

  factory D.fromJson(Map<String, dynamic> json) => D(
        quantity: json["quantity"],
        purchaseCost: json["purchaseCost"],
        salesAmount: json["salesAmount"],
        brokerCommission: json["brokerCommission"],
        seboCommission: json["seboCommission"],
        dpCharge: json["dpCharge"],
        averageRate: json["averageRate"],
        totalReceivableBeforeCgt: json["totalReceivableBeforeCgt"],
        profitBeforeCgt: json["profitBeforeCgt"],
        cgtAmount: json["cgtAmount"],
        netReceivable: json["netReceivable"],
        netProfit: json["netProfit"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "purchaseCost": purchaseCost,
        "salesAmount": salesAmount,
        "brokerCommission": brokerCommission,
        "seboCommission": seboCommission,
        "dpCharge": dpCharge,
        "averageRate": averageRate,
        "totalReceivableBeforeCgt": totalReceivableBeforeCgt,
        "profitBeforeCgt": profitBeforeCgt,
        "cgtAmount": cgtAmount,
        "netReceivable": netReceivable,
        "netProfit": netProfit,
      };
}
