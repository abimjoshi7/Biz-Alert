import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:biz_alert/models/response/user_active_service_res.dart';
import 'package:dio/dio.dart';

class DioPayment {
  // User Active Service
  Future<UserActiveServiceResponseModel?> userActiveService() async {
    String userID = await SecureStorage().readData(key: saveUserID) ?? "0";
    try {
      Dio dio = await postClient();
      Response<String> response = await dio.post(
        "/api/Payment/UsersActiveService?userId=$userID",
      );
      return userActiveServiceResponseModelFromJson(response.data!);
    } catch (e) {
      // print("Error retreiving user active service data");
      return null;
    }
  }
}
