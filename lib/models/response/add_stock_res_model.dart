// // To parse this JSON data, do
// //
// //     final addStockResponseModel = addStockResponseModelFromJson(jsonString);

// import 'dart:convert';

// AddStockResponseModel addStockResponseModelFromJson(String str) =>
//     AddStockResponseModel.fromJson(json.decode(str));

// String addStockResponseModelToJson(AddStockResponseModel data) =>
//     json.encode(data.toJson());

// class AddStockResponseModel {
//   AddStockResponseModel({
//     required this.status,
//     required this.message,
//     required this.dataCollection,
//   });

//   final String status;
//   final String message;
//   final DataCollection dataCollection;

//   factory AddStockResponseModel.fromJson(Map<String, dynamic> json) =>
//       AddStockResponseModel(
//         status: json["status"],
//         message: json["message"],
//         dataCollection: DataCollection.fromJson(json["dataCollection"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "dataCollection": dataCollection.toJson(),
//       };
// }

// class DataCollection {
//   DataCollection({
//     required this.d,
//   });

//   final D d;

//   factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
//         d: D.fromJson(json["d"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "d": d.toJson(),
//       };
// }

// class D {
//   D({
//     required this.purchaseValue,
//     required this.brokerCommission,
//     required this.seboCommission,
//     required this.dpCharge,
//     required this.purchaseCost,
//     required this.totalQuantity,
//     required this.averageRate,
//   });

//   final int purchaseValue;
//   final int brokerCommission;
//   final double seboCommission;
//   final int dpCharge;
//   final double purchaseCost;
//   final int totalQuantity;
//   final int averageRate;

//   factory D.fromJson(Map<String, dynamic> json) => D(
//         purchaseValue: json["purchaseValue"],
//         brokerCommission: json["brokerCommission"],
//         seboCommission: json["seboCommission"].toDouble(),
//         dpCharge: json["dpCharge"],
//         purchaseCost: json["purchaseCost"].toDouble(),
//         totalQuantity: json["totalQuantity"],
//         averageRate: json["averageRate"],
//       );

//   Map<String, dynamic> toJson() => {
//         "purchaseValue": purchaseValue,
//         "brokerCommission": brokerCommission,
//         "seboCommission": seboCommission,
//         "dpCharge": dpCharge,
//         "purchaseCost": purchaseCost,
//         "totalQuantity": totalQuantity,
//         "averageRate": averageRate,
//       };
// }

/// status : "Success"
/// message : ""
/// dataCollection : {"d":{"brokerCommission":89.6,"seboCommission":3.36,"dpCharge":25,"purchaseCost":22517.96,"totalQty":40,"AverageRate":560}}

class AddStockResponseModel {
  String? _status;
  String? _message;
  DataCollection? _dataCollection;

  String? get status => _status;
  String? get message => _message;
  DataCollection? get dataCollection => _dataCollection;

  AddStockResponseModel(
      {String? status, String? message, DataCollection? dataCollection}) {
    _status = status;
    _message = message;
    _dataCollection = dataCollection;
  }

  AddStockResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _dataCollection = json['dataCollection'] != null
        ? DataCollection.fromJson(json['dataCollection'])
        : null;
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_dataCollection != null) {
      map['dataCollection'] = _dataCollection?.toJson();
    }
    return map;
  }
}

/// d : {"brokerCommission":89.6,"seboCommission":3.36,"dpCharge":25,"purchaseCost":22517.96,"totalQty":40,"AverageRate":560}

class DataCollection {
  D? _d;

  D? get d => _d;

  DataCollection({D? d}) {
    _d = d;
  }

  DataCollection.fromJson(dynamic json) {
    _d = json['d'] != null ? D.fromJson(json['d']) : null;
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    if (_d != null) {
      map['d'] = _d?.toJson();
    }
    return map;
  }
}

/// brokerCommission : 89.6
/// seboCommission : 3.36
/// dpCharge : 25
/// purchaseCost : 22517.96
/// totalQty : 40
/// AverageRate : 560
/// {

class D {
  dynamic _purchaseValue;
  dynamic _brokerCommission;
  dynamic _seboCommission;
  dynamic _dpCharge;
  dynamic _purchaseCost;
  dynamic _totalQty;
  dynamic _averageRate;

  dynamic get purchaseValue => _purchaseValue;
  dynamic get brokerCommission => _brokerCommission;
  dynamic get seboCommission => _seboCommission;
  dynamic get dpCharge => _dpCharge;
  dynamic get purchaseCost => _purchaseCost;
  dynamic get totalQuantity => _totalQty;
  dynamic get averageRate => _averageRate;

  D(
      {dynamic purchaseValue,
      dynamic brokerCommission,
      dynamic seboCommission,
      dynamic dpCharge,
      dynamic purchaseCost,
      dynamic totalQuantity,
      dynamic averageRate}) {
    _purchaseValue = purchaseValue;
    _brokerCommission = brokerCommission;
    _seboCommission = seboCommission;
    _dpCharge = dpCharge;
    _purchaseCost = purchaseCost;
    _totalQty = totalQuantity;
    _averageRate = averageRate;
  }

  D.fromJson(dynamic json) {
    _purchaseValue = json['purchaseValue'];
    _brokerCommission = json['brokerCommission'];
    _seboCommission = json['seboCommission'];
    _dpCharge = json['dpCharge'];
    _purchaseCost = json['purchaseCost'];
    _totalQty = json['totalQuantity'];
    _averageRate = json['averageRate'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['purchaseValue'] = _purchaseValue;
    map['brokerCommission'] = _brokerCommission;
    map['seboCommission'] = _seboCommission;
    map['dpCharge'] = _dpCharge;
    map['purchaseCost'] = _purchaseCost;
    map['totalQuantity'] = _totalQty;
    map['averageRate'] = _averageRate;
    return map;
  }
}
