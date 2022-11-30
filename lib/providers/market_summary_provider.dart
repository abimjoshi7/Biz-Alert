import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/market_summary_res_model.dart';
import 'package:flutter/material.dart';

class MarketSummaryProvider extends ChangeNotifier {
  MarketSummaryModel? marketSummary;
  bool loading = false;

  Future<MarketSummaryModel>? getMarketData() async {
    loading = true;
    marketSummary = await DioDashboard().viewMarketSummary();

    loading = false;

    notifyListeners();
    return marketSummary!;
  }
}
