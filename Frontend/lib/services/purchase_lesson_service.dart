import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_request_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_response_model.dart';
import 'package:bikolayders/services/IPurchaseLessonService.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseLessonService extends IPurchaseLessonService {
  PurchaseLessonService(Dio dio) : super(dio);

  @override
  Future<PurchaseLessonResponseModel?> purchaseLesson(
      PurchaseLessonRequestModel requestModel) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          options.headers["Authorization"] =
              "Bearer " + (prefs.getString("token") ?? "");
          return handler.next(options);
        },
      ),
    );
    final response =
        await dio.post(StaticStrings.purchaseLesson, data: requestModel);

    if (response.statusCode == 200) {
      return PurchaseLessonResponseModel.fromJson(response.data);
    }
    return null;
  }
}
