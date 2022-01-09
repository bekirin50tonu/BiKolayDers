import 'package:json_annotation/json_annotation.dart';
part 'add_lesson_request_model.g.dart';

@JsonSerializable()
class AddLessonRequestModel {
  final String? name;
  final double? price;
  final String? category;
  final List<String?>? hours;

  AddLessonRequestModel({
    this.name,
    this.price,
    this.category,
    this.hours,
  });

  factory AddLessonRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddLessonRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddLessonRequestModelToJson(this);
}
