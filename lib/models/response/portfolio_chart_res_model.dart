// // To parse this JSON data, do
// //
// //     final portfolioChartResponseModel = portfolioChartResponseModelFromJson(jsonString);

// import 'dart:convert';

// PortfolioChartResponseModel portfolioChartResponseModelFromJson(String str) =>
//     PortfolioChartResponseModel.fromJson(json.decode(str));

// String portfolioChartResponseModelToJson(PortfolioChartResponseModel data) =>
//     json.encode(data.toJson());

// class PortfolioChartResponseModel {
//   PortfolioChartResponseModel({
//     this.status,
//     this.message,
//     this.dataCollection,
//   });

//   final String? status;
//   final String? message;
//   final DataCollection? dataCollection;

//   factory PortfolioChartResponseModel.fromJson(Map<String, dynamic> json) =>
//       PortfolioChartResponseModel(
//         status: json["status"],
//         message: json["message"],
//         // dataCollection: DataCollection.fromJson(json["dataCollection"]),
//         dataCollection: json["dataCollection"] != null
//             ? DataCollection.fromJson(json['dataCollection'])
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "dataCollection":
//             dataCollection != null ? dataCollection?.toJson() : '',
//       };
// }

// class DataCollection {
//   DataCollection({
//     this.status,
//     this.message,
//     this.data,
//   });

//   final String? status;
//   final String? message;
//   final Data? data;

//   factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
//         status: json["Status"],
//         message: json["Message"],
//         // data: Data.fromJson(json["Data"]),
//         data: json["Data"] != null ? Data.fromJson(json["Data"]) : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "Status": status,
//         "Message": message,
//         "Data": data != null ? data?.toJson() : '',
//       };
// }

// class Data {
//   Data({
//     this.portfolioSummary,
//     this.investmentChart,
//     this.sectorHoldings,
//   });

//   final PortfolioSummary? portfolioSummary;
//   final List<InvestmentChart>? investmentChart;
//   final List<SectorHolding>? sectorHoldings;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         portfolioSummary: json['PortfolioSummary'] !=
//             null ? PortfolioSummary.fromJson(json["PortfolioSummary"]):null,
//         investmentChart: List<InvestmentChart>.from(
//             json["InvestmentChart"].map((x) => InvestmentChart.fromJson(x))),
//         sectorHoldings: List<SectorHolding>.from(
//             json["SectorHoldings"].map((x) => SectorHolding.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "PortfolioSummary": portfolioSummary!.toJson(),
//         "InvestmentChart":
//             List<dynamic>.from(investmentChart!.map((x) => x.toJson())),
//         "SectorHoldings":
//             List<dynamic>.from(sectorHoldings!.map((x) => x.toJson())),
//       };
// }

// class InvestmentChart {
//   InvestmentChart({
//     this.sectorId,
//     this.sectorName,
//     this.investment,
//   });

//   final int? sectorId;
//   final String? sectorName;
//   final double? investment;

//   factory InvestmentChart.fromJson(Map<String, dynamic> json) =>
//       InvestmentChart(
//         sectorId: json["SectorId"],
//         sectorName: json["SectorName"],
//         investment: json["Investment"].toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "SectorId": sectorId,
//         "SectorName": sectorName,
//         "Investment": investment,
//       };
// }

// class PortfolioSummary {
//   PortfolioSummary({
//     this.overallGain,
//     this.daysGain,
//     this.invertment,
//     this.networth,
//     this.recurring,
//     this.portfolioExpiryDate,
//     this.portfolioExpiryMsg,
//     this.marketDate,
//   });

//   final String? overallGain;
//   final String? daysGain;
//   final String? invertment;
//   final String? networth;
//   final bool? recurring;
//   final String? portfolioExpiryDate;
//   final dynamic portfolioExpiryMsg;
//   final String? marketDate;

//   factory PortfolioSummary.fromJson(Map<String, dynamic> json) =>
//       PortfolioSummary(
//         overallGain: json["OverallGain"],
//         daysGain: json["DaysGain"],
//         invertment: json["Invertment"],
//         networth: json["Networth"],
//         recurring: json["Recurring"],
//         portfolioExpiryDate: json["PortfolioExpiryDate"],
//         portfolioExpiryMsg: json["PortfolioExpiryMsg"],
//         marketDate: json["MarketDate"],
//       );

//   Map<String, dynamic> toJson() => {
//         "OverallGain": overallGain,
//         "DaysGain": daysGain,
//         "Invertment": invertment,
//         "Networth": networth,
//         "Recurring": recurring,
//         "PortfolioExpiryDate": portfolioExpiryDate,
//         "PortfolioExpiryMsg": portfolioExpiryMsg,
//         "MarketDate": marketDate,
//       };
// }

// class SectorHolding {
//   SectorHolding({
//     this.sectorId,
//     this.sectorName,
//     this.portfolioHoldings,
//   });

//   final int? sectorId;
//   final String? sectorName;
//   final List<PortfolioHolding>? portfolioHoldings;

//   factory SectorHolding.fromJson(Map<String, dynamic> json) => SectorHolding(
//         sectorId: json["SectorID"],
//         sectorName: json["SectorName"],
//         portfolioHoldings: List<PortfolioHolding>.from(
//             json["portfolioHoldings"].map((x) => PortfolioHolding.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "SectorID": sectorId,
//         "SectorName": sectorName,
//         "portfolioHoldings":
//             List<dynamic>.from(portfolioHoldings!.map((x) => x.toJson())),
//       };
// }

// class PortfolioHolding {
//   PortfolioHolding({
//     this.sectorId,
//     this.companyId,
//     this.companyName,
//     this.symbol,
//     this.quantity,
//     this.price,
//     this.marketValue,
//     this.date,
//     this.rate,
//     this.investment,
//     this.changeInPrice,
//     this.changeInPercentage,
//     this.fiftTwoWeekChange,
//     this.day,
//     this.overall,
//     this.perviousClose,
//   });

//   final int? sectorId;
//   final String? companyId;
//   final String? companyName;
//   final String? symbol;
//   final String? quantity;
//   final String? price;
//   final String? marketValue;
//   final String? date;
//   final String? rate;
//   final String? investment;
//   final String? changeInPrice;
//   final String? changeInPercentage;
//   final String? fiftTwoWeekChange;
//   final String? day;
//   final String? overall;
//   final String? perviousClose;

//   factory PortfolioHolding.fromJson(Map<String, dynamic> json) =>
//       PortfolioHolding(
//         sectorId: json["SectorID"],
//         companyId: json["CompanyID"],
//         companyName: json["CompanyName"],
//         symbol: json["Symbol"],
//         quantity: json["Quantity"],
//         price: json["Price"],
//         marketValue: json["MarketValue"],
//         date: json["Date"],
//         rate: json["Rate"],
//         investment: json["Investment"],
//         changeInPrice: json["ChangeInPrice"],
//         changeInPercentage: json["ChangeInPercentage"],
//         fiftTwoWeekChange: json["FiftTwoWeekChange"],
//         day: json["Day"],
//         overall: json["Overall"],
//         perviousClose: json["PerviousClose"],
//       );

//   Map<String, dynamic> toJson() => {
//         "SectorID": sectorId,
//         "CompanyID": companyId,
//         "CompanyName": companyName,
//         "Symbol": symbol,
//         "Quantity": quantity,
//         "Price": price,
//         "MarketValue": marketValue,
//         "Date": date,
//         "Rate": rate,
//         "Investment": investment,
//         "ChangeInPrice": changeInPrice,
//         "ChangeInPercentage": changeInPercentage,
//         "FiftTwoWeekChange": fiftTwoWeekChange,
//         "Day": day,
//         "Overall": overall,
//         "PerviousClose": perviousClose,
//       };
// }

/// status : "Success"
/// message : ""
/// dataCollection : {"Status":"Success","Message":"","Data":{"PortfolioSummary":{"OverallGain":"6,652,185.18 (204.92%)","DaysGain":"-53,327.9 (-1.64%)","Invertment":"3,246,194.57","Networth":"9,898,379.75","Recurring":false,"PortfolioExpiryDate":"2022/09/03","PortfolioExpiryMsg":null,"MarketDate":"2021/08/04 03:00:00"},"InvestmentChart":[{"SectorId":1,"SectorName":"Commercial Banks","Investment":1499151.12},{"SectorId":2,"SectorName":"Corporate Debenture","Investment":4160.62},{"SectorId":3,"SectorName":"Development Bank Limited","Investment":36220.4},{"SectorId":7,"SectorName":"Hydro Power","Investment":538672.43},{"SectorId":8,"SectorName":"Non-Life Insurance","Investment":4800.71},{"SectorId":10,"SectorName":"Mutual Fund","Investment":904660.0},{"SectorId":11,"SectorName":"Others","Investment":23417.99},{"SectorId":14,"SectorName":"Tradings","Investment":178527.87},{"SectorId":18,"SectorName":"Life Insurance","Investment":56583.43}],"SectorHoldings":[{"SectorID":1,"SectorName":"Commercial Banks","portfolioHoldings":[{"SectorID":1,"CompanyID":"1","CompanyName":"Agriculture Development Bank Limited","Symbol":"ADBL","Quantity":"5","Price":"582.50","MarketValue":"2,887","Date":"2021/08/04 03:00:00","Rate":"455.07","Investment":"2,275","ChangeInPrice":"2.50","ChangeInPercentage":"0.43%","FiftTwoWeekChange":"597-406","Day":"12.50(0.54%)","Overall":"611.72(26.88%)","PerviousClose":"580.00"},{"SectorID":1,"CompanyID":"18","CompanyName":"Nepal Bangladesh Bank Limited","Symbol":"NBB","Quantity":"69","Price":"493.00","MarketValue":"33,876","Date":"2021/08/04 03:00:00","Rate":"362.80","Investment":"25,033","ChangeInPrice":"10.00","ChangeInPercentage":"2.07%","FiftTwoWeekChange":"493-193","Day":"690.00(2.75%)","Overall":"8,842.58(35.32%)","PerviousClose":"483.00"},{"SectorID":1,"CompanyID":"19","CompanyName":"Nepal Bank Limited","Symbol":"NBL","Quantity":"10","Price":"480.00","MarketValue":"4,774","Date":"2021/08/04 03:00:00","Rate":"55.01","Investment":"550","ChangeInPrice":"1.00","ChangeInPercentage":"0.21%","FiftTwoWeekChange":"508-247","Day":"10.00(1.81%)","Overall":"4,224.20(767.92%)","PerviousClose":"479.00"},{"SectorID":1,"CompanyID":"20","CompanyName":"Nepal Credit And Commercial Bank Limited","Symbol":"NCCB","Quantity":"2,000","Price":"384.00","MarketValue":"765,274","Date":"2021/08/04 03:00:00","Rate":"365.30","Investment":"730,609","ChangeInPrice":"4.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"399.5-190","Day":"8,000.00(1.09%)","Overall":"34,664.20(4.74%)","PerviousClose":"380.00"},{"SectorID":1,"CompanyID":"22","CompanyName":"NIC Asia Bank Ltd.","Symbol":"NICA","Quantity":"610","Price":"1,025.70","MarketValue":"623,456","Date":"2021/08/04 03:00:00","Rate":"354.05","Investment":"215,970","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.19%","FiftTwoWeekChange":"1,073-548","Day":"-1,220.00(-0.56%)","Overall":"407,486.10(188.68%)","PerviousClose":"1,027.70"},{"SectorID":1,"CompanyID":"28","CompanyName":"Standard Chartered Bank Limited","Symbol":"SCB","Quantity":"1,200","Price":"598.00","MarketValue":"715,053","Date":"2021/08/04 03:00:00","Rate":"437.26","Investment":"524,713","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.17%","FiftTwoWeekChange":"699-574","Day":"-1,200.00(-0.22%)","Overall":"190,339.22(36.27%)","PerviousClose":"599.00"}]},{"SectorID":2,"SectorName":"Corporate Debenture","portfolioHoldings":[{"SectorID":2,"CompanyID":"5069","CompanyName":"12% Goodwill finance Debenture 2083","Symbol":"GWFD83","Quantity":"10","Price":"1,170.00","MarketValue":"11,651","Date":"2021/08/02 03:00:00","Rate":"416.06","Investment":"4,161","ChangeInPrice":"0.00","ChangeInPercentage":"0%","FiftTwoWeekChange":"1,242-1,145","Day":"0.00(0%)","Overall":"7,490.83(180.04%)","PerviousClose":"1,170.00"}]},{"SectorID":3,"SectorName":"Development Bank Limited","portfolioHoldings":[{"SectorID":3,"CompanyID":"180","CompanyName":"Kailash Bikas Bank Ltd.","Symbol":"KBBL","Quantity":"100","Price":"238.00","MarketValue":"23,701","Date":"2019/07/04 03:00:00","Rate":"351.70","Investment":"35,170","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.83%","FiftTwoWeekChange":"240-238","Day":"0.00(0%)","Overall":"-11,469.02(-32.61%)","PerviousClose":"-"},{"SectorID":3,"CompanyID":"219","CompanyName":"Shangrila Development Bank Ltd.","Symbol":"SADBL","Quantity":"10","Price":"461.30","MarketValue":"4,587","Date":"2021/08/04 03:00:00","Rate":"105.01","Investment":"1,050","ChangeInPrice":"6.30","ChangeInPercentage":"1.38%","FiftTwoWeekChange":"473-141","Day":"63.00(5.99%)","Overall":"3,537.16(336.82%)","PerviousClose":"455.00"}]},{"SectorID":7,"SectorName":"Hydro Power","portfolioHoldings":[{"SectorID":7,"CompanyID":"115","CompanyName":"Chilime Hydropower Company Limited","Symbol":"CHCL","Quantity":"790","Price":"732.80","MarketValue":"576,857","Date":"2021/08/04 03:00:00","Rate":"671.41","Investment":"530,411","ChangeInPrice":"34.30","ChangeInPercentage":"4.91%","FiftTwoWeekChange":"752-384","Day":"27,097.00(5.1%)","Overall":"46,445.65(8.76%)","PerviousClose":"698.50"},{"SectorID":7,"CompanyID":"4582","CompanyName":"United Modi Hydropower Ltd.","Symbol":"UMHL","Quantity":"10","Price":"516.00","MarketValue":"5,134","Date":"2021/08/04 03:00:00","Rate":"441.06","Investment":"4,411","ChangeInPrice":"7.00","ChangeInPercentage":"1.38%","FiftTwoWeekChange":"516-100","Day":"70.00(1.58%)","Overall":"723.58(16.41%)","PerviousClose":"509.00"},{"SectorID":7,"CompanyID":"4879","CompanyName":"Upper Tamakoshi Hydropower Ltd","Symbol":"UPPER","Quantity":"38","Price":"761.20","MarketValue":"28,806","Date":"2021/08/04 03:00:00","Rate":"101.33","Investment":"3,851","ChangeInPrice":"69.20","ChangeInPercentage":"10%","FiftTwoWeekChange":"908-219","Day":"2,629.60(68.29%)","Overall":"24,954.99(648.09%)","PerviousClose":"692.00"}]},{"SectorID":8,"SectorName":"Non-Life Insurance","portfolioHoldings":[{"SectorID":8,"CompanyID":"141","CompanyName":"Siddhartha Insurance Ltd.","Symbol":"SIL","Quantity":"10","Price":"1,160.00","MarketValue":"11,552","Date":"2021/08/04 03:00:00","Rate":"480.07","Investment":"4,801","ChangeInPrice":"12.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"1,360-578","Day":"120.00(2.49%)","Overall":"6,751.15(140.63%)","PerviousClose":"1,148.00"}]},{"SectorID":10,"SectorName":"Mutual Fund","portfolioHoldings":[{"SectorID":10,"CompanyID":"4904","CompanyName":"NABIL BALANCED FUND-2","Symbol":"NBF2","Quantity":"90,000","Price":"15.93","MarketValue":"1,428,610","Date":"2021/08/04 03:00:00","Rate":"10.05","Investment":"904,660","ChangeInPrice":"0.01","ChangeInPercentage":"0.06%","FiftTwoWeekChange":"16.7-8.7","Day":"900.00(0.09%)","Overall":"523,950.37(57.92%)","PerviousClose":"15.92"}]},{"SectorID":11,"SectorName":"Others","portfolioHoldings":[{"SectorID":11,"CompanyID":"4638","CompanyName":"Nepal Re-Insurance Company Limited","Symbol":"NRIC","Quantity":"50","Price":"1,655.00","MarketValue":"82,431","Date":"2021/08/04 03:00:00","Rate":"468.36","Investment":"23,418","ChangeInPrice":"-25.00","ChangeInPercentage":"-1.49%","FiftTwoWeekChange":"1,977-572","Day":"-1,250.00(-5.33%)","Overall":"59,013.42(252%)","PerviousClose":"1,680.00"}]},{"SectorID":14,"SectorName":"Tradings","portfolioHoldings":[{"SectorID":14,"CompanyID":"121","CompanyName":"Salt Trading Corporation","Symbol":"STC","Quantity":"500","Price":"10,802.00","MarketValue":"5,383,987","Date":"2021/08/04 03:00:00","Rate":"357.06","Investment":"178,528","ChangeInPrice":"-178.00","ChangeInPercentage":"-1.62%","FiftTwoWeekChange":"13,317-2,655","Day":"-89,000.00(-49.85%)","Overall":"5,205,458.98(2,915.77%)","PerviousClose":"10,980.00"}]},{"SectorID":18,"SectorName":"Life Insurance","portfolioHoldings":[{"SectorID":18,"CompanyID":"4749","CompanyName":"Jyoti Life Insurance Company Limited","Symbol":"JLI","Quantity":"250","Price":"786.00","MarketValue":"195,743","Date":"2021/08/04 03:00:00","Rate":"226.33","Investment":"56,583","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.13%","FiftTwoWeekChange":"908-388","Day":"-250.00(-0.44%)","Overall":"139,160.05(245.94%)","PerviousClose":"787.00"}]}]}}

class PortfolioChartResponseModel {
  String? _status;
  String? _message;
  DataCollection? _dataCollection;

  String? get status => _status;
  String? get message => _message;
  DataCollection? get dataCollection => _dataCollection;

  PortfolioChartResponseModel(
      {String? status, String? message, DataCollection? dataCollection}) {
    _status = status;
    _message = message;
    _dataCollection = dataCollection;
  }

  PortfolioChartResponseModel.fromJson(dynamic json) {
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

/// Status : "Success"
/// Message : ""
/// Data : {"PortfolioSummary":{"OverallGain":"6,652,185.18 (204.92%)","DaysGain":"-53,327.9 (-1.64%)","Invertment":"3,246,194.57","Networth":"9,898,379.75","Recurring":false,"PortfolioExpiryDate":"2022/09/03","PortfolioExpiryMsg":null,"MarketDate":"2021/08/04 03:00:00"},"InvestmentChart":[{"SectorId":1,"SectorName":"Commercial Banks","Investment":1499151.12},{"SectorId":2,"SectorName":"Corporate Debenture","Investment":4160.62},{"SectorId":3,"SectorName":"Development Bank Limited","Investment":36220.4},{"SectorId":7,"SectorName":"Hydro Power","Investment":538672.43},{"SectorId":8,"SectorName":"Non-Life Insurance","Investment":4800.71},{"SectorId":10,"SectorName":"Mutual Fund","Investment":904660.0},{"SectorId":11,"SectorName":"Others","Investment":23417.99},{"SectorId":14,"SectorName":"Tradings","Investment":178527.87},{"SectorId":18,"SectorName":"Life Insurance","Investment":56583.43}],"SectorHoldings":[{"SectorID":1,"SectorName":"Commercial Banks","portfolioHoldings":[{"SectorID":1,"CompanyID":"1","CompanyName":"Agriculture Development Bank Limited","Symbol":"ADBL","Quantity":"5","Price":"582.50","MarketValue":"2,887","Date":"2021/08/04 03:00:00","Rate":"455.07","Investment":"2,275","ChangeInPrice":"2.50","ChangeInPercentage":"0.43%","FiftTwoWeekChange":"597-406","Day":"12.50(0.54%)","Overall":"611.72(26.88%)","PerviousClose":"580.00"},{"SectorID":1,"CompanyID":"18","CompanyName":"Nepal Bangladesh Bank Limited","Symbol":"NBB","Quantity":"69","Price":"493.00","MarketValue":"33,876","Date":"2021/08/04 03:00:00","Rate":"362.80","Investment":"25,033","ChangeInPrice":"10.00","ChangeInPercentage":"2.07%","FiftTwoWeekChange":"493-193","Day":"690.00(2.75%)","Overall":"8,842.58(35.32%)","PerviousClose":"483.00"},{"SectorID":1,"CompanyID":"19","CompanyName":"Nepal Bank Limited","Symbol":"NBL","Quantity":"10","Price":"480.00","MarketValue":"4,774","Date":"2021/08/04 03:00:00","Rate":"55.01","Investment":"550","ChangeInPrice":"1.00","ChangeInPercentage":"0.21%","FiftTwoWeekChange":"508-247","Day":"10.00(1.81%)","Overall":"4,224.20(767.92%)","PerviousClose":"479.00"},{"SectorID":1,"CompanyID":"20","CompanyName":"Nepal Credit And Commercial Bank Limited","Symbol":"NCCB","Quantity":"2,000","Price":"384.00","MarketValue":"765,274","Date":"2021/08/04 03:00:00","Rate":"365.30","Investment":"730,609","ChangeInPrice":"4.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"399.5-190","Day":"8,000.00(1.09%)","Overall":"34,664.20(4.74%)","PerviousClose":"380.00"},{"SectorID":1,"CompanyID":"22","CompanyName":"NIC Asia Bank Ltd.","Symbol":"NICA","Quantity":"610","Price":"1,025.70","MarketValue":"623,456","Date":"2021/08/04 03:00:00","Rate":"354.05","Investment":"215,970","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.19%","FiftTwoWeekChange":"1,073-548","Day":"-1,220.00(-0.56%)","Overall":"407,486.10(188.68%)","PerviousClose":"1,027.70"},{"SectorID":1,"CompanyID":"28","CompanyName":"Standard Chartered Bank Limited","Symbol":"SCB","Quantity":"1,200","Price":"598.00","MarketValue":"715,053","Date":"2021/08/04 03:00:00","Rate":"437.26","Investment":"524,713","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.17%","FiftTwoWeekChange":"699-574","Day":"-1,200.00(-0.22%)","Overall":"190,339.22(36.27%)","PerviousClose":"599.00"}]},{"SectorID":2,"SectorName":"Corporate Debenture","portfolioHoldings":[{"SectorID":2,"CompanyID":"5069","CompanyName":"12% Goodwill finance Debenture 2083","Symbol":"GWFD83","Quantity":"10","Price":"1,170.00","MarketValue":"11,651","Date":"2021/08/02 03:00:00","Rate":"416.06","Investment":"4,161","ChangeInPrice":"0.00","ChangeInPercentage":"0%","FiftTwoWeekChange":"1,242-1,145","Day":"0.00(0%)","Overall":"7,490.83(180.04%)","PerviousClose":"1,170.00"}]},{"SectorID":3,"SectorName":"Development Bank Limited","portfolioHoldings":[{"SectorID":3,"CompanyID":"180","CompanyName":"Kailash Bikas Bank Ltd.","Symbol":"KBBL","Quantity":"100","Price":"238.00","MarketValue":"23,701","Date":"2019/07/04 03:00:00","Rate":"351.70","Investment":"35,170","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.83%","FiftTwoWeekChange":"240-238","Day":"0.00(0%)","Overall":"-11,469.02(-32.61%)","PerviousClose":"-"},{"SectorID":3,"CompanyID":"219","CompanyName":"Shangrila Development Bank Ltd.","Symbol":"SADBL","Quantity":"10","Price":"461.30","MarketValue":"4,587","Date":"2021/08/04 03:00:00","Rate":"105.01","Investment":"1,050","ChangeInPrice":"6.30","ChangeInPercentage":"1.38%","FiftTwoWeekChange":"473-141","Day":"63.00(5.99%)","Overall":"3,537.16(336.82%)","PerviousClose":"455.00"}]},{"SectorID":7,"SectorName":"Hydro Power","portfolioHoldings":[{"SectorID":7,"CompanyID":"115","CompanyName":"Chilime Hydropower Company Limited","Symbol":"CHCL","Quantity":"790","Price":"732.80","MarketValue":"576,857","Date":"2021/08/04 03:00:00","Rate":"671.41","Investment":"530,411","ChangeInPrice":"34.30","ChangeInPercentage":"4.91%","FiftTwoWeekChange":"752-384","Day":"27,097.00(5.1%)","Overall":"46,445.65(8.76%)","PerviousClose":"698.50"},{"SectorID":7,"CompanyID":"4582","CompanyName":"United Modi Hydropower Ltd.","Symbol":"UMHL","Quantity":"10","Price":"516.00","MarketValue":"5,134","Date":"2021/08/04 03:00:00","Rate":"441.06","Investment":"4,411","ChangeInPrice":"7.00","ChangeInPercentage":"1.38%","FiftTwoWeekChange":"516-100","Day":"70.00(1.58%)","Overall":"723.58(16.41%)","PerviousClose":"509.00"},{"SectorID":7,"CompanyID":"4879","CompanyName":"Upper Tamakoshi Hydropower Ltd","Symbol":"UPPER","Quantity":"38","Price":"761.20","MarketValue":"28,806","Date":"2021/08/04 03:00:00","Rate":"101.33","Investment":"3,851","ChangeInPrice":"69.20","ChangeInPercentage":"10%","FiftTwoWeekChange":"908-219","Day":"2,629.60(68.29%)","Overall":"24,954.99(648.09%)","PerviousClose":"692.00"}]},{"SectorID":8,"SectorName":"Non-Life Insurance","portfolioHoldings":[{"SectorID":8,"CompanyID":"141","CompanyName":"Siddhartha Insurance Ltd.","Symbol":"SIL","Quantity":"10","Price":"1,160.00","MarketValue":"11,552","Date":"2021/08/04 03:00:00","Rate":"480.07","Investment":"4,801","ChangeInPrice":"12.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"1,360-578","Day":"120.00(2.49%)","Overall":"6,751.15(140.63%)","PerviousClose":"1,148.00"}]},{"SectorID":10,"SectorName":"Mutual Fund","portfolioHoldings":[{"SectorID":10,"CompanyID":"4904","CompanyName":"NABIL BALANCED FUND-2","Symbol":"NBF2","Quantity":"90,000","Price":"15.93","MarketValue":"1,428,610","Date":"2021/08/04 03:00:00","Rate":"10.05","Investment":"904,660","ChangeInPrice":"0.01","ChangeInPercentage":"0.06%","FiftTwoWeekChange":"16.7-8.7","Day":"900.00(0.09%)","Overall":"523,950.37(57.92%)","PerviousClose":"15.92"}]},{"SectorID":11,"SectorName":"Others","portfolioHoldings":[{"SectorID":11,"CompanyID":"4638","CompanyName":"Nepal Re-Insurance Company Limited","Symbol":"NRIC","Quantity":"50","Price":"1,655.00","MarketValue":"82,431","Date":"2021/08/04 03:00:00","Rate":"468.36","Investment":"23,418","ChangeInPrice":"-25.00","ChangeInPercentage":"-1.49%","FiftTwoWeekChange":"1,977-572","Day":"-1,250.00(-5.33%)","Overall":"59,013.42(252%)","PerviousClose":"1,680.00"}]},{"SectorID":14,"SectorName":"Tradings","portfolioHoldings":[{"SectorID":14,"CompanyID":"121","CompanyName":"Salt Trading Corporation","Symbol":"STC","Quantity":"500","Price":"10,802.00","MarketValue":"5,383,987","Date":"2021/08/04 03:00:00","Rate":"357.06","Investment":"178,528","ChangeInPrice":"-178.00","ChangeInPercentage":"-1.62%","FiftTwoWeekChange":"13,317-2,655","Day":"-89,000.00(-49.85%)","Overall":"5,205,458.98(2,915.77%)","PerviousClose":"10,980.00"}]},{"SectorID":18,"SectorName":"Life Insurance","portfolioHoldings":[{"SectorID":18,"CompanyID":"4749","CompanyName":"Jyoti Life Insurance Company Limited","Symbol":"JLI","Quantity":"250","Price":"786.00","MarketValue":"195,743","Date":"2021/08/04 03:00:00","Rate":"226.33","Investment":"56,583","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.13%","FiftTwoWeekChange":"908-388","Day":"-250.00(-0.44%)","Overall":"139,160.05(245.94%)","PerviousClose":"787.00"}]}]}

class DataCollection {
  String? _status;
  String? _message;
  Data? _data;

  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  DataCollection({String? status, String? message, Data? data}) {
    _status = status;
    _message = message;
    _data = data;
  }

  DataCollection.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    return map;
  }
}

/// PortfolioSummary : {"OverallGain":"6,652,185.18 (204.92%)","DaysGain":"-53,327.9 (-1.64%)","Invertment":"3,246,194.57","Networth":"9,898,379.75","Recurring":false,"PortfolioExpiryDate":"2022/09/03","PortfolioExpiryMsg":null,"MarketDate":"2021/08/04 03:00:00"}
/// InvestmentChart : [{"SectorId":1,"SectorName":"Commercial Banks","Investment":1499151.12},{"SectorId":2,"SectorName":"Corporate Debenture","Investment":4160.62},{"SectorId":3,"SectorName":"Development Bank Limited","Investment":36220.4},{"SectorId":7,"SectorName":"Hydro Power","Investment":538672.43},{"SectorId":8,"SectorName":"Non-Life Insurance","Investment":4800.71},{"SectorId":10,"SectorName":"Mutual Fund","Investment":904660.0},{"SectorId":11,"SectorName":"Others","Investment":23417.99},{"SectorId":14,"SectorName":"Tradings","Investment":178527.87},{"SectorId":18,"SectorName":"Life Insurance","Investment":56583.43}]
/// SectorHoldings : [{"SectorID":1,"SectorName":"Commercial Banks","portfolioHoldings":[{"SectorID":1,"CompanyID":"1","CompanyName":"Agriculture Development Bank Limited","Symbol":"ADBL","Quantity":"5","Price":"582.50","MarketValue":"2,887","Date":"2021/08/04 03:00:00","Rate":"455.07","Investment":"2,275","ChangeInPrice":"2.50","ChangeInPercentage":"0.43%","FiftTwoWeekChange":"597-406","Day":"12.50(0.54%)","Overall":"611.72(26.88%)","PerviousClose":"580.00"},{"SectorID":1,"CompanyID":"18","CompanyName":"Nepal Bangladesh Bank Limited","Symbol":"NBB","Quantity":"69","Price":"493.00","MarketValue":"33,876","Date":"2021/08/04 03:00:00","Rate":"362.80","Investment":"25,033","ChangeInPrice":"10.00","ChangeInPercentage":"2.07%","FiftTwoWeekChange":"493-193","Day":"690.00(2.75%)","Overall":"8,842.58(35.32%)","PerviousClose":"483.00"},{"SectorID":1,"CompanyID":"19","CompanyName":"Nepal Bank Limited","Symbol":"NBL","Quantity":"10","Price":"480.00","MarketValue":"4,774","Date":"2021/08/04 03:00:00","Rate":"55.01","Investment":"550","ChangeInPrice":"1.00","ChangeInPercentage":"0.21%","FiftTwoWeekChange":"508-247","Day":"10.00(1.81%)","Overall":"4,224.20(767.92%)","PerviousClose":"479.00"},{"SectorID":1,"CompanyID":"20","CompanyName":"Nepal Credit And Commercial Bank Limited","Symbol":"NCCB","Quantity":"2,000","Price":"384.00","MarketValue":"765,274","Date":"2021/08/04 03:00:00","Rate":"365.30","Investment":"730,609","ChangeInPrice":"4.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"399.5-190","Day":"8,000.00(1.09%)","Overall":"34,664.20(4.74%)","PerviousClose":"380.00"},{"SectorID":1,"CompanyID":"22","CompanyName":"NIC Asia Bank Ltd.","Symbol":"NICA","Quantity":"610","Price":"1,025.70","MarketValue":"623,456","Date":"2021/08/04 03:00:00","Rate":"354.05","Investment":"215,970","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.19%","FiftTwoWeekChange":"1,073-548","Day":"-1,220.00(-0.56%)","Overall":"407,486.10(188.68%)","PerviousClose":"1,027.70"},{"SectorID":1,"CompanyID":"28","CompanyName":"Standard Chartered Bank Limited","Symbol":"SCB","Quantity":"1,200","Price":"598.00","MarketValue":"715,053","Date":"2021/08/04 03:00:00","Rate":"437.26","Investment":"524,713","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.17%","FiftTwoWeekChange":"699-574","Day":"-1,200.00(-0.22%)","Overall":"190,339.22(36.27%)","PerviousClose":"599.00"}]},{"SectorID":2,"SectorName":"Corporate Debenture","portfolioHoldings":[{"SectorID":2,"CompanyID":"5069","CompanyName":"12% Goodwill finance Debenture 2083","Symbol":"GWFD83","Quantity":"10","Price":"1,170.00","MarketValue":"11,651","Date":"2021/08/02 03:00:00","Rate":"416.06","Investment":"4,161","ChangeInPrice":"0.00","ChangeInPercentage":"0%","FiftTwoWeekChange":"1,242-1,145","Day":"0.00(0%)","Overall":"7,490.83(180.04%)","PerviousClose":"1,170.00"}]},{"SectorID":3,"SectorName":"Development Bank Limited","portfolioHoldings":[{"SectorID":3,"CompanyID":"180","CompanyName":"Kailash Bikas Bank Ltd.","Symbol":"KBBL","Quantity":"100","Price":"238.00","MarketValue":"23,701","Date":"2019/07/04 03:00:00","Rate":"351.70","Investment":"35,170","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.83%","FiftTwoWeekChange":"240-238","Day":"0.00(0%)","Overall":"-11,469.02(-32.61%)","PerviousClose":"-"},{"SectorID":3,"CompanyID":"219","CompanyName":"Shangrila Development Bank Ltd.","Symbol":"SADBL","Quantity":"10","Price":"461.30","MarketValue":"4,587","Date":"2021/08/04 03:00:00","Rate":"105.01","Investment":"1,050","ChangeInPrice":"6.30","ChangeInPercentage":"1.38%","FiftTwoWeekChange":"473-141","Day":"63.00(5.99%)","Overall":"3,537.16(336.82%)","PerviousClose":"455.00"}]},{"SectorID":7,"SectorName":"Hydro Power","portfolioHoldings":[{"SectorID":7,"CompanyID":"115","CompanyName":"Chilime Hydropower Company Limited","Symbol":"CHCL","Quantity":"790","Price":"732.80","MarketValue":"576,857","Date":"2021/08/04 03:00:00","Rate":"671.41","Investment":"530,411","ChangeInPrice":"34.30","ChangeInPercentage":"4.91%","FiftTwoWeekChange":"752-384","Day":"27,097.00(5.1%)","Overall":"46,445.65(8.76%)","PerviousClose":"698.50"},{"SectorID":7,"CompanyID":"4582","CompanyName":"United Modi Hydropower Ltd.","Symbol":"UMHL","Quantity":"10","Price":"516.00","MarketValue":"5,134","Date":"2021/08/04 03:00:00","Rate":"441.06","Investment":"4,411","ChangeInPrice":"7.00","ChangeInPercentage":"1.38%","FiftTwoWeekChange":"516-100","Day":"70.00(1.58%)","Overall":"723.58(16.41%)","PerviousClose":"509.00"},{"SectorID":7,"CompanyID":"4879","CompanyName":"Upper Tamakoshi Hydropower Ltd","Symbol":"UPPER","Quantity":"38","Price":"761.20","MarketValue":"28,806","Date":"2021/08/04 03:00:00","Rate":"101.33","Investment":"3,851","ChangeInPrice":"69.20","ChangeInPercentage":"10%","FiftTwoWeekChange":"908-219","Day":"2,629.60(68.29%)","Overall":"24,954.99(648.09%)","PerviousClose":"692.00"}]},{"SectorID":8,"SectorName":"Non-Life Insurance","portfolioHoldings":[{"SectorID":8,"CompanyID":"141","CompanyName":"Siddhartha Insurance Ltd.","Symbol":"SIL","Quantity":"10","Price":"1,160.00","MarketValue":"11,552","Date":"2021/08/04 03:00:00","Rate":"480.07","Investment":"4,801","ChangeInPrice":"12.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"1,360-578","Day":"120.00(2.49%)","Overall":"6,751.15(140.63%)","PerviousClose":"1,148.00"}]},{"SectorID":10,"SectorName":"Mutual Fund","portfolioHoldings":[{"SectorID":10,"CompanyID":"4904","CompanyName":"NABIL BALANCED FUND-2","Symbol":"NBF2","Quantity":"90,000","Price":"15.93","MarketValue":"1,428,610","Date":"2021/08/04 03:00:00","Rate":"10.05","Investment":"904,660","ChangeInPrice":"0.01","ChangeInPercentage":"0.06%","FiftTwoWeekChange":"16.7-8.7","Day":"900.00(0.09%)","Overall":"523,950.37(57.92%)","PerviousClose":"15.92"}]},{"SectorID":11,"SectorName":"Others","portfolioHoldings":[{"SectorID":11,"CompanyID":"4638","CompanyName":"Nepal Re-Insurance Company Limited","Symbol":"NRIC","Quantity":"50","Price":"1,655.00","MarketValue":"82,431","Date":"2021/08/04 03:00:00","Rate":"468.36","Investment":"23,418","ChangeInPrice":"-25.00","ChangeInPercentage":"-1.49%","FiftTwoWeekChange":"1,977-572","Day":"-1,250.00(-5.33%)","Overall":"59,013.42(252%)","PerviousClose":"1,680.00"}]},{"SectorID":14,"SectorName":"Tradings","portfolioHoldings":[{"SectorID":14,"CompanyID":"121","CompanyName":"Salt Trading Corporation","Symbol":"STC","Quantity":"500","Price":"10,802.00","MarketValue":"5,383,987","Date":"2021/08/04 03:00:00","Rate":"357.06","Investment":"178,528","ChangeInPrice":"-178.00","ChangeInPercentage":"-1.62%","FiftTwoWeekChange":"13,317-2,655","Day":"-89,000.00(-49.85%)","Overall":"5,205,458.98(2,915.77%)","PerviousClose":"10,980.00"}]},{"SectorID":18,"SectorName":"Life Insurance","portfolioHoldings":[{"SectorID":18,"CompanyID":"4749","CompanyName":"Jyoti Life Insurance Company Limited","Symbol":"JLI","Quantity":"250","Price":"786.00","MarketValue":"195,743","Date":"2021/08/04 03:00:00","Rate":"226.33","Investment":"56,583","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.13%","FiftTwoWeekChange":"908-388","Day":"-250.00(-0.44%)","Overall":"139,160.05(245.94%)","PerviousClose":"787.00"}]}]

class Data {
  PortfolioSummary? _portfolioSummary;
  List<InvestmentChart>? _investmentChart;
  List<SectorHoldings>? _sectorHoldings;

  PortfolioSummary? get portfolioSummary => _portfolioSummary;
  List<InvestmentChart>? get investmentChart => _investmentChart;
  List<SectorHoldings>? get sectorHoldings => _sectorHoldings;

  Data(
      {PortfolioSummary? portfolioSummary,
      List<InvestmentChart>? investmentChart,
      List<SectorHoldings>? sectorHoldings}) {
    _portfolioSummary = portfolioSummary;
    _investmentChart = investmentChart;
    _sectorHoldings = sectorHoldings;
  }

  Data.fromJson(dynamic json) {
    _portfolioSummary = json['PortfolioSummary'] != null
        ? PortfolioSummary.fromJson(json['PortfolioSummary'])
        : null;
    if (json['InvestmentChart'] != null) {
      _investmentChart = [];
      json['InvestmentChart'].forEach((v) {
        _investmentChart?.add(InvestmentChart.fromJson(v));
      });
    }
    if (json['SectorHoldings'] != null) {
      _sectorHoldings = [];
      json['SectorHoldings'].forEach((v) {
        _sectorHoldings?.add(SectorHoldings.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    if (_portfolioSummary != null) {
      map['PortfolioSummary'] = _portfolioSummary?.toJson();
    }
    if (_investmentChart != null) {
      map['InvestmentChart'] =
          _investmentChart?.map((v) => v.toJson()).toList();
    }
    if (_sectorHoldings != null) {
      map['SectorHoldings'] = _sectorHoldings?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// SectorID : 1
/// SectorName : "Commercial Banks"
/// portfolioHoldings : [{"SectorID":1,"CompanyID":"1","CompanyName":"Agriculture Development Bank Limited","Symbol":"ADBL","Quantity":"5","Price":"582.50","MarketValue":"2,887","Date":"2021/08/04 03:00:00","Rate":"455.07","Investment":"2,275","ChangeInPrice":"2.50","ChangeInPercentage":"0.43%","FiftTwoWeekChange":"597-406","Day":"12.50(0.54%)","Overall":"611.72(26.88%)","PerviousClose":"580.00"},{"SectorID":1,"CompanyID":"18","CompanyName":"Nepal Bangladesh Bank Limited","Symbol":"NBB","Quantity":"69","Price":"493.00","MarketValue":"33,876","Date":"2021/08/04 03:00:00","Rate":"362.80","Investment":"25,033","ChangeInPrice":"10.00","ChangeInPercentage":"2.07%","FiftTwoWeekChange":"493-193","Day":"690.00(2.75%)","Overall":"8,842.58(35.32%)","PerviousClose":"483.00"},{"SectorID":1,"CompanyID":"19","CompanyName":"Nepal Bank Limited","Symbol":"NBL","Quantity":"10","Price":"480.00","MarketValue":"4,774","Date":"2021/08/04 03:00:00","Rate":"55.01","Investment":"550","ChangeInPrice":"1.00","ChangeInPercentage":"0.21%","FiftTwoWeekChange":"508-247","Day":"10.00(1.81%)","Overall":"4,224.20(767.92%)","PerviousClose":"479.00"},{"SectorID":1,"CompanyID":"20","CompanyName":"Nepal Credit And Commercial Bank Limited","Symbol":"NCCB","Quantity":"2,000","Price":"384.00","MarketValue":"765,274","Date":"2021/08/04 03:00:00","Rate":"365.30","Investment":"730,609","ChangeInPrice":"4.00","ChangeInPercentage":"1.05%","FiftTwoWeekChange":"399.5-190","Day":"8,000.00(1.09%)","Overall":"34,664.20(4.74%)","PerviousClose":"380.00"},{"SectorID":1,"CompanyID":"22","CompanyName":"NIC Asia Bank Ltd.","Symbol":"NICA","Quantity":"610","Price":"1,025.70","MarketValue":"623,456","Date":"2021/08/04 03:00:00","Rate":"354.05","Investment":"215,970","ChangeInPrice":"-2.00","ChangeInPercentage":"-0.19%","FiftTwoWeekChange":"1,073-548","Day":"-1,220.00(-0.56%)","Overall":"407,486.10(188.68%)","PerviousClose":"1,027.70"},{"SectorID":1,"CompanyID":"28","CompanyName":"Standard Chartered Bank Limited","Symbol":"SCB","Quantity":"1,200","Price":"598.00","MarketValue":"715,053","Date":"2021/08/04 03:00:00","Rate":"437.26","Investment":"524,713","ChangeInPrice":"-1.00","ChangeInPercentage":"-0.17%","FiftTwoWeekChange":"699-574","Day":"-1,200.00(-0.22%)","Overall":"190,339.22(36.27%)","PerviousClose":"599.00"}]

class SectorHoldings {
  int? _sectorID;
  String? _sectorName;
  List<PortfolioHoldings>? _portfolioHoldings;

  int? get sectorID => _sectorID;
  String? get sectorName => _sectorName;
  List<PortfolioHoldings>? get portfolioHoldings => _portfolioHoldings;

  SectorHoldings(
      {int? sectorID,
      String? sectorName,
      List<PortfolioHoldings>? portfolioHoldings}) {
    _sectorID = sectorID;
    _sectorName = sectorName;
    _portfolioHoldings = portfolioHoldings;
  }

  SectorHoldings.fromJson(dynamic json) {
    _sectorID = json['SectorID'];
    _sectorName = json['SectorName'];
    if (json['portfolioHoldings'] != null) {
      _portfolioHoldings = [];
      json['portfolioHoldings'].forEach((v) {
        _portfolioHoldings?.add(PortfolioHoldings.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['SectorID'] = _sectorID;
    map['SectorName'] = _sectorName;
    if (_portfolioHoldings != null) {
      map['portfolioHoldings'] =
          _portfolioHoldings?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// SectorID : 1
/// CompanyID : "1"
/// CompanyName : "Agriculture Development Bank Limited"
/// Symbol : "ADBL"
/// Quantity : "5"
/// Price : "582.50"
/// MarketValue : "2,887"
/// Date : "2021/08/04 03:00:00"
/// Rate : "455.07"
/// Investment : "2,275"
/// ChangeInPrice : "2.50"
/// ChangeInPercentage : "0.43%"
/// FiftTwoWeekChange : "597-406"
/// Day : "12.50(0.54%)"
/// Overall : "611.72(26.88%)"
/// PerviousClose : "580.00"

class PortfolioHoldings {
  int? _sectorID;
  String? _companyID;
  String? _companyName;
  String? _symbol;
  String? _quantity;
  String? _price;
  String? _marketValue;
  String? _date;
  String? _rate;
  String? _investment;
  String? _changeInPrice;
  String? _changeInPercentage;
  String? _fiftTwoWeekChange;
  String? _day;
  String? _overall;
  String? _perviousClose;

  int? get sectorID => _sectorID;
  String? get companyID => _companyID;
  String? get companyName => _companyName;
  String? get symbol => _symbol;
  String? get quantity => _quantity;
  String? get price => _price;
  String? get marketValue => _marketValue;
  String? get date => _date;
  String? get rate => _rate;
  String? get investment => _investment;
  String? get changeInPrice => _changeInPrice;
  String? get changeInPercentage => _changeInPercentage;
  String? get fiftTwoWeekChange => _fiftTwoWeekChange;
  String? get day => _day;
  String? get overall => _overall;
  String? get perviousClose => _perviousClose;

  PortfolioHoldings(
      {int? sectorID,
      String? companyID,
      String? companyName,
      String? symbol,
      String? quantity,
      String? price,
      String? marketValue,
      String? date,
      String? rate,
      String? investment,
      String? changeInPrice,
      String? changeInPercentage,
      String? fiftTwoWeekChange,
      String? day,
      String? overall,
      String? perviousClose}) {
    _sectorID = sectorID;
    _companyID = companyID;
    _companyName = companyName;
    _symbol = symbol;
    _quantity = quantity;
    _price = price;
    _marketValue = marketValue;
    _date = date;
    _rate = rate;
    _investment = investment;
    _changeInPrice = changeInPrice;
    _changeInPercentage = changeInPercentage;
    _fiftTwoWeekChange = fiftTwoWeekChange;
    _day = day;
    _overall = overall;
    _perviousClose = perviousClose;
  }

  PortfolioHoldings.fromJson(dynamic json) {
    _sectorID = json['SectorID'];
    _companyID = json['CompanyID'];
    _companyName = json['CompanyName'];
    _symbol = json['Symbol'];
    _quantity = json['Quantity'];
    _price = json['Price'];
    _marketValue = json['MarketValue'];
    _date = json['Date'];
    _rate = json['Rate'];
    _investment = json['Investment'];
    _changeInPrice = json['ChangeInPrice'];
    _changeInPercentage = json['ChangeInPercentage'];
    _fiftTwoWeekChange = json['FiftTwoWeekChange'];
    _day = json['Day'];
    _overall = json['Overall'];
    _perviousClose = json['PerviousClose'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['SectorID'] = _sectorID;
    map['CompanyID'] = _companyID;
    map['CompanyName'] = _companyName;
    map['Symbol'] = _symbol;
    map['Quantity'] = _quantity;
    map['Price'] = _price;
    map['MarketValue'] = _marketValue;
    map['Date'] = _date;
    map['Rate'] = _rate;
    map['Investment'] = _investment;
    map['ChangeInPrice'] = _changeInPrice;
    map['ChangeInPercentage'] = _changeInPercentage;
    map['FiftTwoWeekChange'] = _fiftTwoWeekChange;
    map['Day'] = _day;
    map['Overall'] = _overall;
    map['PerviousClose'] = _perviousClose;
    return map;
  }
}

/// SectorId : 1
/// SectorName : "Commercial Banks"
/// Investment : 1499151.12

class InvestmentChart {
  int? _sectorId;
  String? _sectorName;
  double? _investment;

  int? get sectorId => _sectorId;
  String? get sectorName => _sectorName;
  double? get investment => _investment;

  InvestmentChart({int? sectorId, String? sectorName, double? investment}) {
    _sectorId = sectorId;
    _sectorName = sectorName;
    _investment = investment;
  }

  InvestmentChart.fromJson(dynamic json) {
    _sectorId = json['SectorId'];
    _sectorName = json['SectorName'];
    _investment = json['Investment'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['SectorId'] = _sectorId;
    map['SectorName'] = _sectorName;
    map['Investment'] = _investment;
    return map;
  }
}

/// OverallGain : "6,652,185.18 (204.92%)"
/// DaysGain : "-53,327.9 (-1.64%)"
/// Invertment : "3,246,194.57"
/// Networth : "9,898,379.75"
/// Recurring : false
/// PortfolioExpiryDate : "2022/09/03"
/// PortfolioExpiryMsg : null
/// MarketDate : "2021/08/04 03:00:00"

class PortfolioSummary {
  String? _overallGain;
  String? _daysGain;
  String? _invertment;
  String? _networth;
  bool? _recurring;
  String? _portfolioExpiryDate;
  dynamic _portfolioExpiryMsg;
  String? _marketDate;

  String? get overallGain => _overallGain;
  String? get daysGain => _daysGain;
  String? get invertment => _invertment;
  String? get networth => _networth;
  bool? get recurring => _recurring;
  String? get portfolioExpiryDate => _portfolioExpiryDate;
  dynamic get portfolioExpiryMsg => _portfolioExpiryMsg;
  String? get marketDate => _marketDate;

  PortfolioSummary(
      {String? overallGain,
      String? daysGain,
      String? invertment,
      String? networth,
      bool? recurring,
      String? portfolioExpiryDate,
      dynamic portfolioExpiryMsg,
      String? marketDate}) {
    _overallGain = overallGain;
    _daysGain = daysGain;
    _invertment = invertment;
    _networth = networth;
    _recurring = recurring;
    _portfolioExpiryDate = portfolioExpiryDate;
    _portfolioExpiryMsg = portfolioExpiryMsg;
    _marketDate = marketDate;
  }

  PortfolioSummary.fromJson(dynamic json) {
    _overallGain = json['OverallGain'];
    _daysGain = json['DaysGain'];
    _invertment = json['Invertment'];
    _networth = json['Networth'];
    _recurring = json['Recurring'];
    _portfolioExpiryDate = json['PortfolioExpiryDate'];
    _portfolioExpiryMsg = json['PortfolioExpiryMsg'];
    _marketDate = json['MarketDate'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['OverallGain'] = _overallGain;
    map['DaysGain'] = _daysGain;
    map['Invertment'] = _invertment;
    map['Networth'] = _networth;
    map['Recurring'] = _recurring;
    map['PortfolioExpiryDate'] = _portfolioExpiryDate;
    map['PortfolioExpiryMsg'] = _portfolioExpiryMsg;
    map['MarketDate'] = _marketDate;
    return map;
  }
}
