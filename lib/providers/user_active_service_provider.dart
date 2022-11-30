import 'package:biz_alert/features/payment/services/dio_payment.dart';
import 'package:biz_alert/models/response/user_active_service_res.dart';
import 'package:flutter/material.dart';

class UserActiveServiceProvider extends ChangeNotifier {
  UserActiveServiceResponseModel? userActiveService;
  bool loading = false;

  Future<UserActiveServiceResponseModel>? getUserActiveService() async {
    loading = true;
    userActiveService = await DioPayment().userActiveService();

    loading = false;

    notifyListeners();
    return userActiveService!;
  }
}
