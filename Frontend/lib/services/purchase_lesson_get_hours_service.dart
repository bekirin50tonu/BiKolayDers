import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_request_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_response_model.dart';
import 'package:bikolayders/services/IPurchaseLessonGetHoursService.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseLessonGetHoursService extends IPurchaseLessonGetHoursService {
  PurchaseLessonGetHoursService(Dio dio) : super(dio);

  @override
  Future<PurchaseLessonGetHoursResponseModel?> getHours(
      PurchaseLessonGetHoursRequestModel requestModel) async {
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
    final response = await dio.post(StaticStrings.purchaseLessonGetHours,
        data: requestModel);

    if (response.statusCode == 200) {
      return PurchaseLessonGetHoursResponseModel.fromJson(response.data);
    }
    return null;
  }
}
