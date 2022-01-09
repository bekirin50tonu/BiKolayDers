// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutResponseModel _$LogoutResponseModelFromJson(Map<String, dynamic> json) =>
    LogoutResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LogoutResponseModelToJson(
        LogoutResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
