import 'package:json_annotation/json_annotation.dart';
part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  final String? name;
  final String? email;
  final String? password;
  final int? teacher;

  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.teacher,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
