import 'package:bikolayders/services/teacher_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherCubit extends Cubit<TeacherState> {
  final TeacherService service;
  TeacherCubit({required this.service}) : super(TeacherInitial());
}

abstract class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherComplete extends TeacherState {}
