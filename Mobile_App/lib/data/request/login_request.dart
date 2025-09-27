import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:eye_app/data/model/login_response_model.dart';
import 'package:eye_app/main.dart';
import '../model/login_model.dart';

class LoginRequest {
  final Dio _dio;
  static late bool success;
  LoginResponseModel? loginResponseModel;

  LoginRequest(this._dio);

  Future<String> loginRequest(LoginModel request) async {
    try {
      final response = await _dio.post(
        "${EyeApp.baseUrl}/api/login",
        options: Options(
          headers: {
            "Accept": "application/json", // token
          },
        ),
        data: request.toJson(),
      );
      log("Login Success: ${response.data}");
      success = true;
      loginResponseModel = LoginResponseModel.fromjson(response.data);
      return loginResponseModel!.token;
    } on DioException catch (e) {
      if (e.response != null) {
        success = false;
        log("Error: ${e.response?.statusCode} - ${e.response?.data}");
        throw Exception(e.message);
      } else {
        success = false;
        log("Error: ${e.message}");
        throw Exception(e.message);
      }
    }
  }
}
