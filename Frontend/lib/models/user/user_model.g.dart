// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      teacher: json['teacher'] as bool?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'teacher': instance.teacher,
    };
