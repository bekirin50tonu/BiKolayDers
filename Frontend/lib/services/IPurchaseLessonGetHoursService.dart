import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_request_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_response_model.dart';
import 'package:dio/dio.dart';

abstract class IPurchaseLessonGetHoursService {
  final Dio dio;

  IPurchaseLessonGetHoursService(this.dio);

  Future<PurchaseLessonGetHoursResponseModel?> getHours(
      PurchaseLessonGetHoursRequestModel requestModel);
}
