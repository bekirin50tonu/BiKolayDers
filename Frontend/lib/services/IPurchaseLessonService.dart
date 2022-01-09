import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_response_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_request_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_response_model.dart';
import 'package:dio/dio.dart';

abstract class IPurchaseLessonService {
  final Dio dio;

  IPurchaseLessonService(this.dio);

  Future<PurchaseLessonResponseModel?> purchaseLesson(
      PurchaseLessonRequestModel requestModel);
}
