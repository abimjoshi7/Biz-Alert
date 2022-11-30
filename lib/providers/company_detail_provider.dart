import 'package:biz_alert/features/dashboard/companyDetail/service/dio_company_detail.dart';
import 'package:biz_alert/models/response/company_detail_floorsheet_res_model.dart';
import 'package:biz_alert/models/response/company_detail_price_history_res_model.dart';
import 'package:biz_alert/models/response/company_detail_res.dart';
import 'package:biz_alert/models/response/stock_graph_res_model.dart';
import 'package:flutter/cupertino.dart';

class CompanyDetailProvider extends ChangeNotifier {
  CompanyDetailResModel? companyDetail;
  CompanyDetailFloorsheetResModel? companyDetailFloorsheet;
  CompanyDetailPriceHistoryResModel? companyDetailPriceHistory;
  StockGraphResModel? stockGraph;
  bool loading = false;

  Future<CompanyDetailResModel>? getCompanyDetailData(String companySym) async {
    loading = true;
    companyDetail =
        await DioCompanyDetail().viewCompanyDetail(companySym: companySym);

    loading = false;

    notifyListeners();
    return companyDetail!;
  }

  Future<CompanyDetailFloorsheetResModel>? getCompanyDetailFloorsheetData(
      String companySym) async {
    loading = true;
    companyDetailFloorsheet =
        await DioCompanyDetail().viewFloorsheet(companySym: companySym);

    loading = false;

    notifyListeners();
    return companyDetailFloorsheet!;
  }

  Future<CompanyDetailPriceHistoryResModel>? getCompanyDetailPriceHistoryData(
      String companySym,
      [String? date]) async {
    loading = true;
    companyDetailPriceHistory = await DioCompanyDetail()
        .viewPriceHistory(companySym: companySym, date: date);

    loading = false;

    notifyListeners();
    return companyDetailPriceHistory!;
  }

  Future<StockGraphResModel>? getStockGraph(
      String companySym, int period) async {
    loading = true;
    stockGraph = await DioCompanyDetail()
        .viewStockGraph(companySym: companySym, period: period);

    loading = false;

    notifyListeners();
    return stockGraph!;
  }
}
