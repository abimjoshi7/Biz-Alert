// To check whether the mobile number already exists or not in the system

// To parse this JSON data, do
//
//     final checkUserExistsResponseModel = checkUserExistsResponseModelFromJson(jsonString);

import 'dart:convert';

CheckUserExistsResponseModel checkUserExistsResponseModelFromJson(String str) =>
    CheckUserExistsResponseModel.fromJson(json.decode(str));

String checkUserExistsResponseModelToJson(CheckUserExistsResponseModel data) =>
    json.encode(data.toJson());

class CheckUserExistsResponseModel {
  CheckUserExistsResponseModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory CheckUserExistsResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckUserExistsResponseModel(
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
    required this.exists,
  });

  final bool exists;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        exists: json["exists"],
      );

  Map<String, dynamic> toJson() => {
        "exists": exists,
      };
}
