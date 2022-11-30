import 'package:biz_alert/features/dashboard/protfolio/services/dio_protfolio.dart';
import 'package:biz_alert/models/response/get_portfolio_res_model.dart';
import 'package:flutter/cupertino.dart';

class PortfolioProvider extends ChangeNotifier {
  GetPortfolioResponseModel? getPortfolioModel;
  bool loading = false;

  Future<GetPortfolioResponseModel>? getPortfolio() async {
    loading = true;
    getPortfolioModel = await DioPortfolioChart().viewPortfolio();

    loading = false;

    notifyListeners();
    return getPortfolioModel!;
  }
}
