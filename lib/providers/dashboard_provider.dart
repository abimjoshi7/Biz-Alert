import 'package:biz_alert/features/dashboard/services/dio_dashboard.dart';
import 'package:biz_alert/models/response/dashboard_res_model.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardModel? dashboard;
  bool loading = false;

  Future<DashboardModel>? getDashboardData() async {
    loading = true;
    dashboard = await DioDashboard().viewDashboard();

    loading = false;
    // print("DASHBOARD DATA" + dashboard!.toJson().toString());

    notifyListeners();
    return dashboard!;
  }
}
