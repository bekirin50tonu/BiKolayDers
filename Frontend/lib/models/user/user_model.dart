import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final bool? success;
  final UserData? data;
  final String? message;

  UserModel({this.success, this.data, this.message});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserData {
  final int? id;
  final String? name;
  final String? email;

  final bool? teacher;

  UserData({this.id, this.name, this.email, this.teacher});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
