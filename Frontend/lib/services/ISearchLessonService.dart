import 'package:bikolayders/models/searchLesson/search_lesson_request_model.dart';
import 'package:bikolayders/models/searchLesson/search_lesson_response_model.dart';
import 'package:dio/dio.dart';

abstract class ISearchLessonService {
  final Dio dio;

  ISearchLessonService(this.dio);

  Future<SearchLessonResponseModel?> searchLesson(
      SearchLessonRequestModel requestModel);
}
