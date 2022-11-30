/// TransactionNumber : "44"
/// CompanyID : "1"
/// Symbol : "Agriculture Development Bank Limited"
/// Quantity : "300"
/// Rate : "1254"
/// BrokerID : "1"
/// CapitalGainTax : "22412.42"
/// Purchase : [{"PurchaseTransactionID":990897,"ShareTypeID":1,"GainTaxRate":0.1,"Rate":"500.00","BasePrice":0,"Quantity":"300"}]

class PurchaseTransactionRequest {
  String? _transactionNumber;
  String? _companyID;
  String? _symbol;
  String? _quantity;
  String? _rate;
  String? _brokerID;
  String? _capitalGainTax;
  List<Purchase>? _purchase;

  String? get transactionNumber => _transactionNumber;
  String? get companyID => _companyID;
  String? get symbol => _symbol;
  String? get quantity => _quantity;
  String? get rate => _rate;
  String? get brokerID => _brokerID;
  String? get capitalGainTax => _capitalGainTax;
  List<Purchase>? get purchase => _purchase;

  PurchaseTransactionRequest(
      {String? transactionNumber,
      String? companyID,
      String? symbol,
      String? quantity,
      String? rate,
      String? brokerID,
      String? capitalGainTax,
      List<Purchase>? purchase}) {
    _transactionNumber = transactionNumber;
    _companyID = companyID;
    _symbol = symbol;
    _quantity = quantity;
    _rate = rate;
    _brokerID = brokerID;
    _capitalGainTax = capitalGainTax;
    _purchase = purchase;
  }

  PurchaseTransactionRequest.fromJson(dynamic json) {
    _transactionNumber = json['TransactionNumber'];
    _companyID = json['CompanyID'];
    _symbol = json['Symbol'];
    _quantity = json['Quantity'];
    _rate = json['Rate'];
    _brokerID = json['BrokerID'];
    _capitalGainTax = json['CapitalGainTax'];
    if (json['Purchase'] != null) {
      _purchase = [];
      json['Purchase'].forEach((v) {
        _purchase?.add(Purchase.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['TransactionNumber'] = _transactionNumber;
    map['CompanyID'] = _companyID;
    map['Symbol'] = _symbol;
    map['Quantity'] = _quantity;
    map['Rate'] = _rate;
    map['BrokerID'] = _brokerID;
    map['CapitalGainTax'] = _capitalGainTax;
    if (_purchase != null) {
      map['Purchase'] = _purchase?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// PurchaseTransactionID : 990897
/// ShareTypeID : 1
/// GainTaxRate : 0.1
/// Rate : "500.00"
/// BasePrice : 0
/// Quantity : "300"

class Purchase {
  String? _purchaseTransactionID;
  String? _shareTypeID;
  String? _gainTaxRate;
  String? _rate;
  String? _basePrice;
  String? _quantity;

  String? get purchaseTransactionID => _purchaseTransactionID;
  String? get shareTypeID => _shareTypeID;
  String? get gainTaxRate => _gainTaxRate;
  String? get rate => _rate;
  String? get basePrice => _basePrice;
  String? get quantity => _quantity;

  Purchase(
      {String? purchaseTransactionID,
      String? shareTypeID,
      String? gainTaxRate,
      String? rate,
      String? basePrice,
      String? quantity}) {
    _purchaseTransactionID = purchaseTransactionID;
    _shareTypeID = shareTypeID;
    _gainTaxRate = gainTaxRate;
    _rate = rate;
    _basePrice = basePrice;
    _quantity = quantity;
  }

  Purchase.fromJson(dynamic json) {
    _purchaseTransactionID = json['PurchaseTransactionID'];
    _shareTypeID = json['ShareTypeID'];
    _gainTaxRate = json['GainTaxRate'];
    _rate = json['Rate'];
    _basePrice = json['BasePrice'];
    _quantity = json['Quantity'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['PurchaseTransactionID'] = _purchaseTransactionID;
    map['ShareTypeID'] = _shareTypeID;
    map['GainTaxRate'] = _gainTaxRate;
    map['Rate'] = _rate;
    map['BasePrice'] = _basePrice;
    map['Quantity'] = _quantity;
    return map;
  }
}
