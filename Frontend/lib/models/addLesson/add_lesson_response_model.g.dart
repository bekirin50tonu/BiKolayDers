// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_lesson_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLessonResponseModel _$AddLessonResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddLessonResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddLessonResponseModelToJson(
        AddLessonResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
