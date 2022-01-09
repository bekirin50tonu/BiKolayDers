import 'package:bikolayders/models/addLesson/add_lesson_request_model.dart';
import 'package:bikolayders/services/add_lesson_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  final AddLessonService service;
  final TextEditingController? nameController;
  final TextEditingController? priceController;
  final TextEditingController? categoryController;

  String? message;

  List<String?>? hours = [];

  bool isPosting = false;

  AddLessonCubit({
    required this.service,
    this.nameController,
    this.priceController,
    this.categoryController,
  }) : super(AddLessonInitial());

  Future<void> createLesson(BuildContext context) async {
    isPosting = true;
    emit(AddLessonLoading());
    final response = await service.postLesson(
      AddLessonRequestModel(
        name: nameController?.text.trim(),
        price: priceController?.text.trim() == ""
            ? null
            : double.parse(priceController?.text.trim() ?? "0"),
        category: categoryController?.text.trim(),
        hours: hours,
      ),
    );
    emit(AddLessonLoaded());
    isPosting = false;
    if (response?.success == false) {
      emit(AddLessonFailed());
      message = response?.message;
    } else {
      Navigator.pushNamed(context, '/studentPage', arguments: "/");
    }
  }
}

abstract class AddLessonState {}

class AddLessonInitial extends AddLessonState {}

class AddLessonLoading extends AddLessonState {}

class AddLessonLoaded extends AddLessonState {}

class AddLessonFailed extends AddLessonState {}
