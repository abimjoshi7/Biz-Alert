// To parse this JSON data, do
//
//     final floorsheetResModel = floorsheetResModelFromJson(jsonString);

import 'dart:convert';

FloorsheetResModel floorsheetResModelFromJson(String str) =>
    FloorsheetResModel.fromJson(json.decode(str));

String floorsheetResModelToJson(FloorsheetResModel data) =>
    json.encode(data.toJson());

class FloorsheetResModel {
  FloorsheetResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory FloorsheetResModel.fromJson(Map<String, dynamic> json) =>
      FloorsheetResModel(
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
    required this.msgtype,
    required this.msg,
    required this.data,
  });

  final String msgtype;
  final String msg;
  final Data data;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        msgtype: json["msgtype"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msgtype": msgtype,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.floorsheetDate,
    required this.brokerName,
    required this.brokerFloorsheetPage,
    required this.brokerFloorsheetData,
  });

  final String floorsheetDate;
  final List<BrokerName> brokerName;
  final List<BrokerFloorsheetPage> brokerFloorsheetPage;
  final List<BrokerFloorsheetDatum> brokerFloorsheetData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        floorsheetDate: json["FloorsheetDate"],
        brokerName: List<BrokerName>.from(
            json["BrokerName"].map((x) => BrokerName.fromJson(x))),
        brokerFloorsheetPage: List<BrokerFloorsheetPage>.from(
            json["BrokerFloorsheetPage"]
                .map((x) => BrokerFloorsheetPage.fromJson(x))),
        brokerFloorsheetData: List<BrokerFloorsheetDatum>.from(
            json["BrokerFloorsheetData"]
                .map((x) => BrokerFloorsheetDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "FloorsheetDate": floorsheetDate,
        "BrokerName": List<dynamic>.from(brokerName.map((x) => x.toJson())),
        "BrokerFloorsheetPage":
            List<dynamic>.from(brokerFloorsheetPage.map((x) => x.toJson())),
        "BrokerFloorsheetData":
            List<dynamic>.from(brokerFloorsheetData.map((x) => x.toJson())),
      };
}

class BrokerFloorsheetDatum {
  BrokerFloorsheetDatum({
    required this.transactionNumber,
    required this.companyName,
    required this.buyerBrokerNo,
    required this.sellerBrokerNo,
    required this.quantity,
    required this.rate,
    required this.amount,
  });

  final String transactionNumber;
  final String companyName;
  final String buyerBrokerNo;
  final String sellerBrokerNo;
  final int quantity;
  final double rate;
  final double amount;

  factory BrokerFloorsheetDatum.fromJson(Map<String, dynamic> json) =>
      BrokerFloorsheetDatum(
        transactionNumber: json["TransactionNumber"],
        companyName: json["CompanyName"],
        buyerBrokerNo: json["BuyerBrokerNo"],
        sellerBrokerNo: json["SellerBrokerNo"],
        quantity: json["Quantity"],
        rate: json["Rate"].toDouble(),
        amount: json["Amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "TransactionNumber": transactionNumber,
        "CompanyName": companyName,
        "BuyerBrokerNo": buyerBrokerNo,
        "SellerBrokerNo": sellerBrokerNo,
        "Quantity": quantity,
        "Rate": rate,
        "Amount": amount,
      };
}

class BrokerFloorsheetPage {
  BrokerFloorsheetPage({
    required this.pageNumber,
    required this.pageSize,
    required this.totalRecords,
    required this.totalPages,
    required this.totalQuantity,
    required this.totalAmount,
    required this.purchaseAmount,
    required this.salesAmount,
    required this.matchingAmount,
    required this.averageRate,
  });

  final int pageNumber;
  final int pageSize;
  final int totalRecords;
  final int totalPages;
  final int totalQuantity;
  final double totalAmount;
  final double purchaseAmount;
  final double salesAmount;
  final double matchingAmount;
  final double averageRate;

  factory BrokerFloorsheetPage.fromJson(Map<String, dynamic> json) =>
      BrokerFloorsheetPage(
        pageNumber: json["PageNumber"],
        pageSize: json["PageSize"],
        totalRecords: json["TotalRecords"],
        totalPages: json["TotalPages"],
        totalQuantity: json["TotalQuantity"],
        totalAmount: json["TotalAmount"].toDouble(),
        purchaseAmount: json["PurchaseAmount"].toDouble(),
        salesAmount: json["SalesAmount"].toDouble(),
        matchingAmount: json["MatchingAmount"].toDouble(),
        averageRate: json["AverageRate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "PageNumber": pageNumber,
        "PageSize": pageSize,
        "TotalRecords": totalRecords,
        "TotalPages": totalPages,
        "TotalQuantity": totalQuantity,
        "TotalAmount": totalAmount,
        "PurchaseAmount": purchaseAmount,
        "SalesAmount": salesAmount,
        "MatchingAmount": matchingAmount,
        "AverageRate": averageRate,
      };
}

class BrokerName {
  BrokerName({
    required this.brokerCode,
    required this.brokerName,
  });

  final String brokerCode;
  final String brokerName;

  factory BrokerName.fromJson(Map<String, dynamic> json) => BrokerName(
        brokerCode: json["BrokerCode"],
        brokerName: json["BrokerName"],
      );

  Map<String, dynamic> toJson() => {
        "BrokerCode": brokerCode,
        "BrokerName": brokerName,
      };
}
