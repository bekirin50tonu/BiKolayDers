import 'package:json_annotation/json_annotation.dart';
part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final bool? success;
  final List<dynamic>? data;
  final String? message;

  RegisterResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}
