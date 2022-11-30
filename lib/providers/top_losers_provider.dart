import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/top_losers_res_model.dart';
import 'package:flutter/material.dart';

class TopLosersProvider extends ChangeNotifier {
  TopLosersModel? topLosers;
  bool loading = false;

  Future<TopLosersModel>? getTopLosersData() async {
    loading = true;
    topLosers = await DioDashboard().viewTopLosers();

    loading = false;

    notifyListeners();
    return topLosers!;
  }
}
