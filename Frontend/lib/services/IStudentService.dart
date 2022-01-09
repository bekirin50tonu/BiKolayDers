import 'package:bikolayders/models/lessons/get_student_lessons_response_model.dart';
import 'package:dio/dio.dart';

abstract class IStudentService {
  final Dio dio;

  IStudentService(this.dio);

  Future<StudentLessonsResponseModel?> getStudentLessons();
}
