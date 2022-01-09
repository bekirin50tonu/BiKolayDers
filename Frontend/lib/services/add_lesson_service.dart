import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/addLesson/add_lesson_response_model.dart';
import 'package:bikolayders/models/addLesson/add_lesson_request_model.dart';
import 'package:bikolayders/services/IAddLessonService.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLessonService extends IAddLessonService {
  AddLessonService(Dio dio) : super(dio);

  Future<Map<String, dynamic>?> getLessonsHours() async {
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        options.headers["Authorization"] =
            "Bearer " + (prefs.getString("token") ?? "");
        return handler.next(options);
      },
    ));

    final response =
        await dio.get<Map<String, dynamic>>(StaticStrings.getHoursLessons);
    return response.data;
  }

  @override
  Future<AddLessonResponseModel?> postLesson(
      AddLessonRequestModel requestModel) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        options.headers["Authorization"] =
            "Bearer " + (prefs.getString("token") ?? "");
        return handler.next(options);
      },
    ));
    final response =
        await dio.post(StaticStrings.addLessonPath, data: requestModel);
    if (response.statusCode == 200) {
      return AddLessonResponseModel.fromJson(response.data);
    }

    return null;
  }
}
