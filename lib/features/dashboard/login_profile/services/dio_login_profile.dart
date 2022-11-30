import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/models/response/get_user_detail_res_model.dart';
import 'package:dio/dio.dart';

class DioLoginProfile {
  // Get UserDetail
  Future<UserDetailsResponseModel?> viewUserDetails(String userID) async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/UserRegistration/GetUserDetails?UserID=$userID",
      );
      return userDetailsResponseModelFromJson(response.data!);
    } catch (e) {
      // print('Error getting user data: $e');
      return null;
    }
  }
}
