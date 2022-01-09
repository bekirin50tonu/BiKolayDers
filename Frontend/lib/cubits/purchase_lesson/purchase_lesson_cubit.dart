import 'package:bikolayders/models/purchaseLesson/purchase_lesson_hours_request_model.dart';
import 'package:bikolayders/models/purchaseLesson/purchase_lesson_request_model.dart';
import 'package:bikolayders/services/purchase_lesson_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseLessonCubit extends Cubit<PurchaseLessonState> {
  final PurchaseLessonService service;

  Future<bool?> purchaseLesson(PurchaseLessonRequestModel requestModel) async {
    final response = await service.purchaseLesson(requestModel);
    return response?.success;
  }

  PurchaseLessonCubit({required this.service}) : super(PurchaseLessonInitial());
}

abstract class PurchaseLessonState {}

class PurchaseLessonInitial extends PurchaseLessonState {}

class PurchaseLessonLoading extends PurchaseLessonState {}

class PurchaseLessonLoaded extends PurchaseLessonState {}

class PurchaseLessonFailed extends PurchaseLessonState {}
