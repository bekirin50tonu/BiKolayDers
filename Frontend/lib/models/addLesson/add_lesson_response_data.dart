import 'package:json_annotation/json_annotation.dart';
part 'add_lesson_response_data.g.dart';

@JsonSerializable()
class AddLessonResponseData {
  final String? name;
  final double? price;

  AddLessonResponseData({
    this.name,
    this.price,
  });

  factory AddLessonResponseData.fromJson(Map<String, dynamic> json) =>
      _$AddLessonResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddLessonResponseDataToJson(this);
}
