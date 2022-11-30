import 'package:biz_alert/features/dashboard/login_profile/services/dio_login_profile.dart';
import 'package:biz_alert/models/response/get_user_detail_res_model.dart';
import 'package:flutter/material.dart';

class UserDetailProvider extends ChangeNotifier {
  UserDetailsResponseModel? userDetailsModel;
  bool loading = false;

  Future<UserDetailsResponseModel>? getUserDetail(String userID) async {
    loading = true;
    userDetailsModel = await DioLoginProfile().viewUserDetails(userID);

    loading = false;

    notifyListeners();
    return userDetailsModel!;
  }
}
