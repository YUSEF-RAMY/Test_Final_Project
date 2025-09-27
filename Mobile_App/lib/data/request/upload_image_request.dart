import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eye_app/main.dart';

Future<void> UploadImageRequest({required File imageFile}) async {
  final dio = Dio();

  try {
    String fileName = imageFile.path.split('/').last; //للحصول على اسم الصوره
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
    log(EyeApp.token);
    final response = await dio.post(
      "${EyeApp.baseUrl}/api/scan",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer ${EyeApp.token}",
          "Accept": "application/json",
        },
      ),
    );
    log("Signup Success: ${response.data}");
  } on DioException catch (e) {
    if (e.response != null) {
      log("Error: ${e.response?.statusCode} - ${e.response?.data}");
      throw Exception(e.message);
    } else {
      log("Error: ${e.message}");
      throw Exception(e.message);
    }
  }
}
