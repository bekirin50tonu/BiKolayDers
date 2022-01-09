// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_lesson_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLessonRequestModel _$AddLessonRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddLessonRequestModel(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] as String?,
      hours: (json['hours'] as List<String>?),
    );

Map<String, dynamic> _$AddLessonRequestModelToJson(
        AddLessonRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'hours': instance.hours,
    };
