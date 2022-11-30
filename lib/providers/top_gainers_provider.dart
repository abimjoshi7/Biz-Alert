import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/top_gainers_res_model.dart';
import 'package:flutter/material.dart';

class TopGainersProvider extends ChangeNotifier {
  TopGainersModel? topGainers;
  bool loading = false;

  Future<TopGainersModel>? getTopGainersData() async {
    loading = true;
    topGainers = await DioDashboard().viewTopGainers();

    loading = false;

    notifyListeners();
    return topGainers!;
  }
}
