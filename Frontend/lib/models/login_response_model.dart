import 'package:bikolayders/models/login_response_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool? success;
  final LoginResponseData? data;
  final String? message;

  LoginResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
