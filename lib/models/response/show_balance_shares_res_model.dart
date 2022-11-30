// // To parse this JSON data, do
// //
// //     final balanceSharesResponseModel = balanceSharesResponseModelFromJson(jsonString);

// import 'dart:convert';

// BalanceSharesResponseModel balanceSharesResponseModelFromJson(String str) =>
//     BalanceSharesResponseModel.fromJson(json.decode(str));

// String balanceSharesResponseModelToJson(BalanceSharesResponseModel data) =>
//     json.encode(data.toJson());

// class BalanceSharesResponseModel {
//   BalanceSharesResponseModel({
//     required this.status,
//     required this.message,
//     required this.dataCollection,
//   });

//   final String status;
//   final String message;
//   final DataCollection dataCollection;

//   factory BalanceSharesResponseModel.fromJson(Map<String, dynamic> json) =>
//       BalanceSharesResponseModel(
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
//     required this.balanceShares,
//     required this.cwar,
//   });

//   final List<BalanceShare> balanceShares;
//   final List<dynamic> cwar;

//   factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
//         balanceShares: List<BalanceShare>.from(
//             json["balanceShares"].map((x) => BalanceShare.fromJson(x))),
//         cwar: List<dynamic>.from(json["cwar"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "balanceShares":
//             List<dynamic>.from(balanceShares.map((x) => x.toJson())),
//         "cwar": List<dynamic>.from(cwar.map((x) => x)),
//       };
// }

// class BalanceShare {
//   BalanceShare({
//     required this.hdnUserTransactionId,
//     required this.hdnShareTypeId,
//     required this.hdnGainTaxRate,
//     required this.shareTypeCode,
//     required this.shareTypeName,
//     required this.dateAd,
//     required this.dateBs,
//     required this.transactionNumber,
//     required this.quantity,
//     required this.balanceQuantity,
//     required this.rate,
//     required this.broker,
//     required this.portfolio,
//     required this.shareholder,
//     required this.salesQty,
//     required this.hdnBasePrice,
//   });

//   final dynamic hdnUserTransactionId;
//   final dynamic hdnShareTypeId;
//   final dynamic hdnGainTaxRate;
//   final String shareTypeCode;
//   final String shareTypeName;
//   final String dateAd;
//   final String dateBs;
//   final String transactionNumber;
//   final dynamic quantity;
//   final dynamic balanceQuantity;
//   final String rate;
//   final String broker;
//   final String portfolio;
//   final String shareholder;
//   final String salesQty;
//   final dynamic hdnBasePrice;

//   factory BalanceShare.fromJson(Map<String, dynamic> json) => BalanceShare(
//         hdnUserTransactionId: json["hdnUserTransactionID"],
//         hdnShareTypeId: json["hdnShareTypeID"],
//         hdnGainTaxRate: json["hdnGainTaxRate"].toDouble(),
//         shareTypeCode: json["ShareTypeCode"],
//         shareTypeName: json["ShareTypeName"],
//         dateAd: json["dateAD"],
//         dateBs: json["dateBS"],
//         transactionNumber: json["TransactionNumber"],
//         quantity: json["Quantity"],
//         balanceQuantity: json["balanceQuantity"],
//         rate: json["Rate"],
//         broker: json["Broker"],
//         portfolio: json["Portfolio"],
//         shareholder: json["Shareholder"],
//         salesQty: json["SalesQty"],
//         hdnBasePrice: json["hdnBasePrice"],
//       );

//   Map<String, dynamic> toJson() => {
//         "hdnUserTransactionID": hdnUserTransactionId,
//         "hdnShareTypeID": hdnShareTypeId,
//         "hdnGainTaxRate": hdnGainTaxRate,
//         "ShareTypeCode": shareTypeCode,
//         "ShareTypeName": shareTypeName,
//         "dateAD": dateAd,
//         "dateBS": dateBs,
//         "TransactionNumber": transactionNumber,
//         "Quantity": quantity,
//         "balanceQuantity": balanceQuantity,
//         "Rate": rate,
//         "Broker": broker,
//         "Portfolio": portfolio,
//         "Shareholder": shareholder,
//         "SalesQty": salesQty,
//         "hdnBasePrice": hdnBasePrice,
//       };
// }

/// status : "Success"
/// message : ""
/// dataCollection : {"balanceShares":[{"hdnUserTransactionID":990897,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"06/01/2021","dateBS":"2078/02/18","TransactionNumber":"1234","Quantity":550,"balanceQuantity":300,"Rate":"500.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245742,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245748,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245752,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245800,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245803,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245820,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1247804,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0}],"cwar":[]}

class BalanceSharesResponseModel {
  String? _status;
  String? _message;
  DataCollection? _dataCollection;

  String? get status => _status;

  String? get message => _message;

  DataCollection? get dataCollection => _dataCollection;

  BalanceSharesResponseModel(
      {String? status, String? message, DataCollection? dataCollection}) {
    _status = status;
    _message = message;
    _dataCollection = dataCollection;
  }

  BalanceSharesResponseModel.fromJson(dynamic json) {
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

/// balanceShares : [{"hdnUserTransactionID":990897,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"06/01/2021","dateBS":"2078/02/18","TransactionNumber":"1234","Quantity":550,"balanceQuantity":300,"Rate":"500.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245742,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245748,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245752,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245800,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245803,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1245820,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0},{"hdnUserTransactionID":1247804,"hdnShareTypeID":1,"hdnGainTaxRate":0.1,"ShareTypeCode":"S","ShareTypeName":"Secondary","dateAD":"09/07/2021","dateBS":"2078/05/22","TransactionNumber":"1234","Quantity":1234,"balanceQuantity":1234,"Rate":"345.00","Broker":"1","Portfolio":"My Portfolio","Shareholder":"9818126609","SalesQty":" ","hdnBasePrice":0}]
/// cwar : []

class DataCollection {
  List<BalanceShare>? _balanceShares;
  List<dynamic>? _cwar;

  List<BalanceShare>? get balanceShares => _balanceShares;

  List<dynamic>? get cwar => _cwar;

  DataCollection({List<BalanceShare>? balanceShares, List<dynamic>? cwar}) {
    _balanceShares = balanceShares;
    _cwar = cwar;
  }

  DataCollection.fromJson(dynamic json) {
    if (json['balanceShares'] != null) {
      _balanceShares = [];
      json['balanceShares'].forEach((v) {
        _balanceShares?.add(BalanceShare.fromJson(v));
      });
    }
    if (json['cwar'] != null) {
      _cwar = [];
      // json['cwar'].forEach((v) {
      //   _cwar.add(dynamic.fromJson(v));
      // });
    }
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    if (_balanceShares != null) {
      map['balanceShares'] = _balanceShares?.map((v) => v.toJson()).toList();
    }
    if (_cwar != null) {
      map['cwar'] = _cwar?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// hdnUserTransactionID : 990897
/// hdnShareTypeID : 1
/// hdnGainTaxRate : 0.1
/// ShareTypeCode : "S"
/// ShareTypeName : "Secondary"
/// dateAD : "06/01/2021"
/// dateBS : "2078/02/18"
/// TransactionNumber : "1234"
/// Quantity : 550
/// balanceQuantity : 300
/// Rate : "500.00"
/// Broker : "1"
/// Portfolio : "My Portfolio"
/// Shareholder : "9818126609"
/// SalesQty : " "
/// hdnBasePrice : 0

class BalanceShare {
  dynamic _hdnUserTransactionID;
  dynamic _hdnShareTypeID;
  dynamic _hdnGainTaxRate;
  String? _shareTypeCode;
  String? _shareTypeName;
  String? _dateAD;
  String? _dateBS;
  String? _transactionNumber;
  dynamic _quantity;
  dynamic _balanceQuantity;
  String? _rate;
  String? _broker;
  String? _portfolio;
  String? _shareholder;
  String? _salesQty;
  dynamic _hdnBasePrice;

  //user click checkbox
  bool? isClick;
  int? userSalesQty = 0;
  int? sumQuantity = 0;

  dynamic get hdnUserTransactionID => _hdnUserTransactionID;

  dynamic get hdnShareTypeID => _hdnShareTypeID;

  dynamic get hdnGainTaxRate => _hdnGainTaxRate;

  String? get shareTypeCode => _shareTypeCode;

  String? get shareTypeName => _shareTypeName;

  String? get dateAD => _dateAD;

  String? get dateBS => _dateBS;

  String? get transactionNumber => _transactionNumber;

  dynamic get quantity => _quantity;

  dynamic get balanceQuantity => _balanceQuantity;

  String? get rate => _rate;

  String? get broker => _broker;

  String? get portfolio => _portfolio;

  String? get shareholder => _shareholder;

  String? get salesQty => _salesQty;

  dynamic get hdnBasePrice => _hdnBasePrice;

  BalanceShare(
      {dynamic hdnUserTransactionID,
      dynamic hdnShareTypeID,
      dynamic hdnGainTaxRate,
      String? shareTypeCode,
      String? shareTypeName,
      String? dateAD,
      String? dateBS,
      String? transactionNumber,
      dynamic quantity,
      dynamic balanceQuantity,
      String? rate,
      String? broker,
      String? portfolio,
      String? shareholder,
      String? salesQty,
      dynamic hdnBasePrice,
      bool? isClick}) {
    _hdnUserTransactionID = hdnUserTransactionID;
    _hdnShareTypeID = hdnShareTypeID;
    _hdnGainTaxRate = hdnGainTaxRate;
    _shareTypeCode = shareTypeCode;
    _shareTypeName = shareTypeName;
    _dateAD = dateAD;
    _dateBS = dateBS;
    _transactionNumber = transactionNumber;
    _quantity = quantity;
    _balanceQuantity = balanceQuantity;
    _rate = rate;
    _broker = broker;
    _portfolio = portfolio;
    _shareholder = shareholder;
    _salesQty = salesQty;
    _hdnBasePrice = hdnBasePrice;
  }

  BalanceShare.fromJson(dynamic json) {
    _hdnUserTransactionID = json['hdnUserTransactionID'];
    _hdnShareTypeID = json['hdnShareTypeID'];
    _hdnGainTaxRate = json['hdnGainTaxRate'];
    _shareTypeCode = json['ShareTypeCode'];
    _shareTypeName = json['ShareTypeName'];
    _dateAD = json['dateAD'];
    _dateBS = json['dateBS'];
    _transactionNumber = json['TransactionNumber'];
    _quantity = json['Quantity'];
    _balanceQuantity = json['balanceQuantity'];
    _rate = json['Rate'];
    _broker = json['Broker'];
    _portfolio = json['Portfolio'];
    _shareholder = json['Shareholder'];
    _salesQty = json['SalesQty'];
    _hdnBasePrice = json['hdnBasePrice'];
    isClick = json['isClick'];
    userSalesQty = json['userSalesQty'];
    sumQuantity = json['sumQuantity'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['hdnUserTransactionID'] = _hdnUserTransactionID;
    map['hdnShareTypeID'] = _hdnShareTypeID;
    map['hdnGainTaxRate'] = _hdnGainTaxRate;
    map['ShareTypeCode'] = _shareTypeCode;
    map['ShareTypeName'] = _shareTypeName;
    map['dateAD'] = _dateAD;
    map['dateBS'] = _dateBS;
    map['TransactionNumber'] = _transactionNumber;
    map['Quantity'] = _quantity;
    map['balanceQuantity'] = _balanceQuantity;
    map['Rate'] = _rate;
    map['Broker'] = _broker;
    map['Portfolio'] = _portfolio;
    map['Shareholder'] = _shareholder;
    map['SalesQty'] = _salesQty;
    map['hdnBasePrice'] = _hdnBasePrice;
    map['isClick'] = isClick;
    map['userSalesQty'] = userSalesQty;
    map['sumQuantity'] = sumQuantity;
    return map;
  }
}
