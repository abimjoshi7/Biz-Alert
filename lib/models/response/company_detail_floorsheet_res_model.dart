// To parse this JSON data, do
//
//     final companyDetailFloorsheetResModel = companyDetailFloorsheetResModelFromMap(jsonString);

import 'dart:convert';

CompanyDetailFloorsheetResModel companyDetailFloorsheetResModelFromMap(
        String str) =>
    CompanyDetailFloorsheetResModel.fromMap(json.decode(str));

String companyDetailFloorsheetResModelToMap(
        CompanyDetailFloorsheetResModel data) =>
    json.encode(data.toMap());

class CompanyDetailFloorsheetResModel {
  CompanyDetailFloorsheetResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final List<DataCollection> dataCollection;

  CompanyDetailFloorsheetResModel copyWith({
    String? status,
    String? message,
    List<DataCollection>? dataCollection,
  }) =>
      CompanyDetailFloorsheetResModel(
        status: status ?? this.status,
        message: message ?? this.message,
        dataCollection: dataCollection ?? this.dataCollection,
      );

  factory CompanyDetailFloorsheetResModel.fromMap(Map<String, dynamic> json) =>
      CompanyDetailFloorsheetResModel(
        status: json["status"],
        message: json["message"],
        dataCollection: List<DataCollection>.from(
            json["dataCollection"].map((x) => DataCollection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "dataCollection":
            List<dynamic>.from(dataCollection.map((x) => x.toMap())),
      };
}

class DataCollection {
  DataCollection({
    required this.id,
    required this.floorsheetDate,
    required this.transactionNumber,
    required this.buyerBrokerCode,
    required this.sellerBrokerCode,
    required this.quantity,
    required this.rate,
    required this.amount,
  });

  final int id;
  final String floorsheetDate;
  final String transactionNumber;
  final String buyerBrokerCode;
  final String sellerBrokerCode;
  final String quantity;
  final String rate;
  final String amount;

  DataCollection copyWith({
    int? id,
    String? floorsheetDate,
    String? transactionNumber,
    String? buyerBrokerCode,
    String? sellerBrokerCode,
    String? quantity,
    String? rate,
    String? amount,
  }) =>
      DataCollection(
        id: id ?? this.id,
        floorsheetDate: floorsheetDate ?? this.floorsheetDate,
        transactionNumber: transactionNumber ?? this.transactionNumber,
        buyerBrokerCode: buyerBrokerCode ?? this.buyerBrokerCode,
        sellerBrokerCode: sellerBrokerCode ?? this.sellerBrokerCode,
        quantity: quantity ?? this.quantity,
        rate: rate ?? this.rate,
        amount: amount ?? this.amount,
      );

  factory DataCollection.fromMap(Map<String, dynamic> json) => DataCollection(
        id: json["ID"],
        floorsheetDate: json["floorsheetDate"],
        transactionNumber: json["TransactionNumber"],
        buyerBrokerCode: json["BuyerBrokerCode"],
        sellerBrokerCode: json["SellerBrokerCode"],
        quantity: json["Quantity"],
        rate: json["Rate"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "floorsheetDate": floorsheetDate,
        "TransactionNumber": transactionNumber,
        "BuyerBrokerCode": buyerBrokerCode,
        "SellerBrokerCode": sellerBrokerCode,
        "Quantity": quantity,
        "Rate": rate,
        "Amount": amount,
      };
}
