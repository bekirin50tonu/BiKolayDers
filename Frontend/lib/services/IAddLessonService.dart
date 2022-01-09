import 'package:bikolayders/models/addLesson/add_lesson_request_model.dart';
import 'package:bikolayders/models/addLesson/add_lesson_response_model.dart';
import 'package:dio/dio.dart';

abstract class IAddLessonService {
  final Dio dio;

  IAddLessonService(this.dio);

  Future<AddLessonResponseModel?> postLesson(
      AddLessonRequestModel requestModel);
}
