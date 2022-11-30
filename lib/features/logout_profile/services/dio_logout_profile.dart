import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/login_user_new1_res_model.dart';
import 'package:dio/dio.dart';

class DioLogoutProfile {
  // Get LoginNewUser1 of Social Media
  Future<LoginUserNew1Model?> viewLoginUserNew1(
      String? email, String password, int socialStatus) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/UserRegistration/LoginUserNew1?Email=$email&Password=$password&socialStatus=$socialStatus&Mode=0&UserHostAddress=dssfdsfdf",
      );
      return loginUserNew1ModelFromJson(response.data!);
    } catch (e) {
      return null;
    }
  }

  // Login with Mobile Number

}
