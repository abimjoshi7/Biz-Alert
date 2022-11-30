// To parse this JSON data, do
//
//     final companyDetailResModel = companyDetailResModelFromJson(jsonString);

import 'dart:convert';

CompanyDetailResModel companyDetailResModelFromJson(String str) =>
    CompanyDetailResModel.fromJson(json.decode(str));

String companyDetailResModelToJson(CompanyDetailResModel data) =>
    json.encode(data.toJson());

class CompanyDetailResModel {
  CompanyDetailResModel({
    required this.status,
    required this.message,
    required this.dataCollection,
  });

  final String status;
  final String message;
  final DataCollection dataCollection;

  factory CompanyDetailResModel.fromJson(Map<String, dynamic> json) =>
      CompanyDetailResModel(
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
    required this.companyDetail,
    required this.divident,
    required this.bonus,
    required this.right,
  });

  final List<CompanyDetail> companyDetail;
  final List<Divident> divident;
  final List<Bonus> bonus;
  final List<Bonus> right;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        companyDetail: List<CompanyDetail>.from(
            json["companyDetail"].map((x) => CompanyDetail.fromJson(x))),
        divident: List<Divident>.from(
            json["divident"].map((x) => Divident.fromJson(x))),
        bonus: List<Bonus>.from(json["bonus"].map((x) => Bonus.fromJson(x))),
        right: List<Bonus>.from(json["right"].map((x) => Bonus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companyDetail":
            List<dynamic>.from(companyDetail.map((x) => x.toJson())),
        "divident": List<dynamic>.from(divident.map((x) => x.toJson())),
        "bonus": List<dynamic>.from(bonus.map((x) => x.toJson())),
        "right": List<dynamic>.from(right.map((x) => x.toJson())),
      };
}

class Bonus {
  Bonus({
    required this.sNo,
    required this.fiscalYear,
    required this.bonusSharePercent,
  });

  final String sNo;
  final String fiscalYear;
  final String bonusSharePercent;

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
        sNo: json["SNo"],
        fiscalYear: json["FiscalYear"],
        bonusSharePercent: json["BonusSharePercent"],
      );

  Map<String, dynamic> toJson() => {
        "SNo": sNo,
        "FiscalYear": fiscalYear,
        "BonusSharePercent": bonusSharePercent,
      };
}

class CompanyDetail {
  CompanyDetail({
    required this.companyName,
    required this.ltp,
    required this.percentageChange,
    required this.lastTradeOn,
    required this.fifityTwoWeeksHighLow,
    required this.dayAverage,
    required this.oneYearYield,
    required this.eps,
    required this.peRatio,
    required this.dividend,
    required this.bonus,
    required this.rightShare,
    required this.marketCapitalization,
    required this.sector,
    required this.bv,
    required this.pbv,
    required this.avgVol,
    required this.sharesOutstanding,
    required this.oneHundredTwentyDays,
  });

  final String companyName;
  final String ltp;
  final String percentageChange;
  final String lastTradeOn;
  final String fifityTwoWeeksHighLow;
  final String dayAverage;
  final String oneYearYield;
  final String eps;
  final String peRatio;
  final String dividend;
  final String bonus;
  final String rightShare;
  final String marketCapitalization;
  final String sector;
  final String bv;
  final String pbv;
  final String avgVol;
  final String sharesOutstanding;
  final String oneHundredTwentyDays;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
        companyName: json["CompanyName"],
        ltp: json["LTP"],
        percentageChange: json["PercentageChange"],
        lastTradeOn: json["LastTradeOn"],
        fifityTwoWeeksHighLow: json["FifityTwoWeeksHighLow"],
        dayAverage: json["DayAverage"],
        oneYearYield: json["OneYearYield"],
        eps: json["EPS"],
        peRatio: json["PERatio"],
        dividend: json["Dividend"],
        bonus: json["Bonus"],
        rightShare: json["RightShare"],
        marketCapitalization: json["MarketCapitalization"],
        sector: json["Sector"],
        bv: json["BV"],
        pbv: json["PBV"],
        avgVol: json["avgVol"],
        sharesOutstanding: json["SharesOutstanding"],
        oneHundredTwentyDays: json["OneHundredTwentyDays"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyName": companyName,
        "LTP": ltp,
        "PercentageChange": percentageChange,
        "LastTradeOn": lastTradeOn,
        "FifityTwoWeeksHighLow": fifityTwoWeeksHighLow,
        "DayAverage": dayAverage,
        "OneYearYield": oneYearYield,
        "EPS": eps,
        "PERatio": peRatio,
        "Dividend": dividend,
        "Bonus": bonus,
        "RightShare": rightShare,
        "MarketCapitalization": marketCapitalization,
        "Sector": sector,
        "BV": bv,
        "PBV": pbv,
        "avgVol": avgVol,
        "SharesOutstanding": sharesOutstanding,
        "OneHundredTwentyDays": oneHundredTwentyDays,
      };
}

class Divident {
  Divident({
    required this.sNo,
    required this.fiscalYear,
    required this.cashDividendPercent,
  });

  final String sNo;
  final String fiscalYear;
  final String cashDividendPercent;

  factory Divident.fromJson(Map<String, dynamic> json) => Divident(
        sNo: json["SNo"],
        fiscalYear: json["FiscalYear"],
        cashDividendPercent: json["CashDividendPercent"],
      );

  Map<String, dynamic> toJson() => {
        "SNo": sNo,
        "FiscalYear": fiscalYear,
        "CashDividendPercent": cashDividendPercent,
      };
}
