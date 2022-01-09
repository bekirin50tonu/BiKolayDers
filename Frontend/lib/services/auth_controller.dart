import 'package:bikolayders/services/login_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static bool isAuth = false;
  static bool isUserTeacher = false;

  static authenticate(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<void> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final service = LoginService(Dio());

    if (prefs.getString("token")?.isNotEmpty == true) {
      final isTokenValidData = await service.isTokenValid();
      if (isTokenValidData?.success == true) {
        isAuth = true;
        return;
      } else {
        prefs.setString("token", "");
        isAuth = false;
        return;
      }
    }
    isAuth = false;
  }

  static Future<void> isTeacher() async {
    if (!isAuth) return;
    var service = LoginService(Dio());
    var user = await service.getUser();
    isUserTeacher = user?.data?.teacher ?? false;
  }
}
