// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_lesson_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLessonResponseData _$AddLessonResponseDataFromJson(
        Map<String, dynamic> json) =>
    AddLessonResponseData(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddLessonResponseDataToJson(
        AddLessonResponseData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
