import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/models/response/portfolio_chart_res_model.dart';
import 'package:flutter/cupertino.dart';

class PortfolioChartProvider extends ChangeNotifier {
  PortfolioChartResponseModel? portfolioChart;
  bool loading = false;

  Future<PortfolioChartResponseModel>? getPortofolioChartData() async {
    loading = true;
    portfolioChart = await DioPortfolioChart().viewPortfolioChart();

    loading = false;
    notifyListeners();
    return portfolioChart!;
  }
}
