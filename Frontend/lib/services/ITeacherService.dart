import 'package:bikolayders/models/lessons/get_teacher_approved_lessons_response_model.dart';
import 'package:bikolayders/models/lessons/get_teacher_lessons_response_model.dart';
import 'package:bikolayders/models/lessons/get_teacher_pending_lessons_response_model.dart';
import 'package:dio/dio.dart';

abstract class ITeacherService {
  final Dio dio;

  ITeacherService(this.dio);

  Future<TeacherPendingLessonsResponseModel?> getTeacherPendingLessons();
  Future<TeacherApprovedLessonsResponseModel?> getTeacherApprovedLessons();
  Future<TeacherLessonsResponseModel?> getTeacherLessons();
}
