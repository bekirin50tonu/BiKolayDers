// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      token: json['token'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'name': instance.name,
    };
