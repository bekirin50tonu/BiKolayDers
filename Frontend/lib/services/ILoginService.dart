import 'package:bikolayders/models/login_request_model.dart';
import 'package:bikolayders/models/login_response_model.dart';
import 'package:bikolayders/models/logout_response_model.dart';
import 'package:bikolayders/models/user/user_model.dart';
import 'package:dio/dio.dart';

abstract class ILoginService {
  final Dio dio;

  ILoginService(this.dio);

  Future<LoginResponseModel?> postUserLogin(
      LoginRequestModel loginRequestModel);

  Future<UserModel?> getUser();
  Future<LogoutResponseModel?> logout();
}
