import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/searchLesson/search_lesson_response_model.dart';
import 'package:bikolayders/models/searchLesson/search_lesson_request_model.dart';
import 'package:bikolayders/services/ISearchLessonService.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLessonService extends ISearchLessonService {
  SearchLessonService(Dio dio) : super(dio);

  @override
  Future<SearchLessonResponseModel?> searchLesson(
      SearchLessonRequestModel requestModel) async {
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
        await dio.post(StaticStrings.searchLessonPath, data: requestModel);

    if (response.statusCode == 200) {
      return SearchLessonResponseModel.fromJson(response.data);
    }
    return null;
  }
}
