import 'package:dio/dio.dart';
import 'dart:convert';

Future<Dio> getClient() async {
  final Dio dio = Dio();
  // String token;
  // const baseUrl = "http://192.168.2.110:2015";
  const baseUrl = "http://biz-acl.demo-4u.net/";
  // token = await SecureStorage().readData(key: saveToken);
  // Passing the basic authentication of username and password
  String username = 'biz@alert';
  String password1 = 'biz@alert570)';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password1'))}';

  final headers = <String, String>{'authorization': basicAuth};

  dio.options.headers = headers;
  dio.options.baseUrl = baseUrl;
  dio.interceptors.add(LogInterceptor(requestBody: false));
  return dio;
}

Future<Dio> postClient() async {
  final Dio dio = Dio();
  // const baseUrl = "http://192.168.2.110:2015";
  const baseUrl = "http://biz-acl.demo-4u.net/";

  // Passing the basic authentication of username and password
  String username = 'biz@alert';
  String password1 = 'biz@alert570)';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password1'))}';

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    // 'Accept': 'application/json',
    'authorization': basicAuth
  };
  dio.options.headers = headers;
  dio.options.baseUrl = baseUrl;
  dio.interceptors.add(LogInterceptor(requestBody: false));
  return dio;
}
