import 'package:bikolayders/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'add_lesson_response_data.dart';
part 'add_lesson_response_model.g.dart';

@JsonSerializable()
class AddLessonResponseModel {
  final bool? success;
  final String? message;

  AddLessonResponseModel({
    this.success,
    this.message,
  });

  factory AddLessonResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddLessonResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddLessonResponseModelToJson(this);
}
