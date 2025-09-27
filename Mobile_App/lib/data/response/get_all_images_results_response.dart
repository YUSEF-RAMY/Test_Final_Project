import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:eye_app/data/model/image_result_model.dart';
import '../../main.dart';

class GetAllImagesResultsResponse {
  final Dio dio;

  GetAllImagesResultsResponse(this.dio);

  Future<ImageResultModel> getCurrentWeather() async {
    Response response = await dio.get(
      '${EyeApp.baseUrl}/api/get/scan',
      options: Options( headers: {
        "Authorization": "Bearer ${EyeApp.token}",
        "Accept": "application/json",
      },),
    );
    try {
      ImageResultModel imageResultModel = ImageResultModel.fromjson(
        response.data,
      );
      return imageResultModel;
    } on DioException catch (e) {
      log(e.toString());
      String errMessage =
          e.response?.data['error']['message'] ??
          'Oops there was an error, Try later!';
      throw Exception(errMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('try later!');
    }
  }
}
