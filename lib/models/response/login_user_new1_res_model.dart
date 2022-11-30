// To parse this JSON data, do
//
//     final loginUserNew1Model = loginUserNew1ModelFromJson(jsonString);

import 'dart:convert';

LoginUserNew1Model loginUserNew1ModelFromJson(String str) =>
    LoginUserNew1Model.fromJson(json.decode(str));

String loginUserNew1ModelToJson(LoginUserNew1Model data) =>
    json.encode(data.toJson());

class LoginUserNew1Model {
  LoginUserNew1Model({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory LoginUserNew1Model.fromJson(Map<String, dynamic> json) =>
      LoginUserNew1Model(
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
    required this.msgType,
    required this.msg,
    required this.data,
  });

  final String msgType;
  final String msg;
  final List<Datum> data;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        msgType: json["msgType"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msgType": msgType,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.userId,
    required this.userEmail,
    required this.sessionToken,
    required this.userTypeId,
    required this.userTypeCode,
    required this.userTypeDescription,
    required this.allowAdminLogin,
    required this.isFirstLogin,
    required this.mobileNumber,
    this.landLine,
    this.firstName,
    this.lastName,
  });

  final String userId;
  final String userEmail;
  final String sessionToken;
  final String userTypeId;
  final String userTypeCode;
  final String userTypeDescription;
  final String allowAdminLogin;
  final String isFirstLogin;
  final String mobileNumber;
  final String? landLine;
  final String? firstName;
  final String? lastName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["UserID"],
        userEmail: json["UserEmail"],
        sessionToken: json["SessionToken"],
        userTypeId: json["UserTypeID"],
        userTypeCode: json["UserTypeCode"],
        userTypeDescription: json["UserTypeDescription"],
        allowAdminLogin: json["AllowAdminLogin"],
        isFirstLogin: json["IsFirstLogin"],
        mobileNumber: json["MobileNumber"],
        landLine: json["LandLine"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "UserEmail": userEmail,
        "SessionToken": sessionToken,
        "UserTypeID": userTypeId,
        "UserTypeCode": userTypeCode,
        "UserTypeDescription": userTypeDescription,
        "AllowAdminLogin": allowAdminLogin,
        "IsFirstLogin": isFirstLogin,
        "MobileNumber": mobileNumber,
        "LandLine": landLine,
        "FirstName": firstName,
        "LastName": lastName,
      };
}
