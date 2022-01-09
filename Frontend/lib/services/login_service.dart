import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/is_token_valid_response_model.dart';
import 'package:bikolayders/models/login_response_model.dart';
import 'package:bikolayders/models/login_request_model.dart';
import 'package:bikolayders/models/logout_response_model.dart';
import 'package:bikolayders/models/user/user_model.dart';
import 'package:bikolayders/services/ILoginService.dart';
import 'package:bikolayders/services/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponseModel?> postUserLogin(
      LoginRequestModel loginRequestModel) async {
    dio.options.headers['Accept'] = 'application/json';
    final response =
        await dio.post(StaticStrings.loginPath, data: loginRequestModel);

    if (response.statusCode == 200) {
      var responseData = LoginResponseModel.fromJson(response.data);
      AuthController.authenticate(responseData.data?.token ?? "");
      return responseData;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          options.headers["Authorization"] =
              "Bearer " + (prefs.getString("token") ?? "");
          return handler.next(options);
        },
      ),
    );

    final response = await dio.get(StaticStrings.getUserPath);
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    }
    return null;
  }

  @override
  Future<LogoutResponseModel?> logout() async {
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          options.headers["Authorization"] =
              "Bearer " + (prefs.getString("token") ?? "");
          return handler.next(options);
        },
      ),
    );

    final response = await dio.post(StaticStrings.logoutPath);

    switch (response.statusCode) {
      case 200:
        return LogoutResponseModel.fromJson(response.data);
      case 401:
        return LogoutResponseModel(
            message: "Kullanıcı Bulunamadı", success: false);
      default:
    }
  }

  Future<IsTokenResponseValidModel?> isTokenValid() async {
    dio.options.headers['Accept'] = 'application/json';
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          options.headers["Authorization"] =
              "Bearer " + (prefs.getString("token") ?? "");
          return handler.next(options);
        },
      ),
    );

    final response = await dio.get(StaticStrings.isTokenValid);
    if (response.statusCode == 200) {
      return IsTokenResponseValidModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
