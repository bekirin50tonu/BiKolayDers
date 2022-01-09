import 'package:bikolayders/models/lessons/get_student_lessons_response_model.dart';
import 'package:bikolayders/services/student_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentService service;
  StudentCubit({required this.service}) : super(StudentInitial());

  Future getAllLessons() async {
    emit(StudentLoading());
    var response = await service.getStudentLessons();
    emit(StudentComplete(response?.data));
  }
}

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentComplete extends StudentState {
  List<StudentLessonResponseData>? allLessons;
  StudentComplete(this.allLessons);
}
