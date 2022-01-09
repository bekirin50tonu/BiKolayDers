import 'package:json_annotation/json_annotation.dart';
part 'login_response_data.g.dart';

@JsonSerializable()
class LoginResponseData {
  final String? token;
  final String? name;

  LoginResponseData({this.token, this.name});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
