import 'package:biz_alert/features/dashboard/market_overview/services/dio_market.dart';
import 'package:biz_alert/models/response/gainer_losers_details.dart';
import 'package:flutter/cupertino.dart';

class AllGainersDetailProvider extends ChangeNotifier {
  AllGainersLosersDetailsResModel? gainersDetails;
  bool loading = false;

  Future<AllGainersLosersDetailsResModel>? getAllGainersDetails() async {
    loading = true;
    gainersDetails = await DioMarket().viewGainersDetail();

    loading = false;

    notifyListeners();
    return gainersDetails!;
  }
}

class AllLosersDetailProvider extends ChangeNotifier {
  AllGainersLosersDetailsResModel? losersDetails;
  bool loading = false;

  Future<AllGainersLosersDetailsResModel>? getAllLosersDetails() async {
    loading = true;
    losersDetails = await DioMarket().viewLosersDetail();

    loading = false;

    notifyListeners();
    return losersDetails!;
  }
}
