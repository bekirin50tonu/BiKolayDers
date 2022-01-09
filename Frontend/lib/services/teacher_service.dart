import 'package:bikolayders/models/lessons/get_teacher_approved_lessons_response_model.dart';
import 'package:bikolayders/models/lessons/get_teacher_lessons_response_model.dart';
import 'package:bikolayders/models/lessons/get_teacher_pending_lessons_response_model.dart';
import 'package:bikolayders/services/ITeacherService.dart';
import 'package:dio/dio.dart';

class TeacherService extends ITeacherService {
  TeacherService(Dio dio) : super(dio);

  @override
  Future<TeacherApprovedLessonsResponseModel?>
      getTeacherApprovedLessons() async {}

  @override
  Future<TeacherLessonsResponseModel?> getTeacherLessons() async {}

  @override
  Future<TeacherPendingLessonsResponseModel?>
      getTeacherPendingLessons() async {}
}
