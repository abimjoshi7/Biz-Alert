// To parse this JSON data, do
//
//     final deletePurchaseApiResponseModel = deletePurchaseApiResponseModelFromJson(jsonString);

import 'dart:convert';

DeletePurchaseApiResponseModel deletePurchaseApiResponseModelFromJson(
        String str) =>
    DeletePurchaseApiResponseModel.fromJson(json.decode(str));

String deletePurchaseApiResponseModelToJson(
        DeletePurchaseApiResponseModel data) =>
    json.encode(data.toJson());

class DeletePurchaseApiResponseModel {
  DeletePurchaseApiResponseModel({
    this.status,
    this.message,
    this.dataCollection,
  });

  final String? status;
  final String? message;
  final dynamic dataCollection;

  factory DeletePurchaseApiResponseModel.fromJson(Map<String, dynamic> json) =>
      DeletePurchaseApiResponseModel(
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
