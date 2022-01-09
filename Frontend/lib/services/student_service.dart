import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/lessons/get_student_lessons_response_model.dart';
import 'package:bikolayders/services/IStudentService.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentService extends IStudentService {
  StudentService(Dio dio) : super(dio);

  @override
  Future<StudentLessonsResponseModel?> getStudentLessons() async {
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
    final response = await dio.get(StaticStrings.getStudentAllLessons);

    if (response.statusCode == 200) {
      return StudentLessonsResponseModel.fromJson(response.data);
    }
    return null;
  }
}
