import 'package:bikolayders/models/login_request_model.dart';
import 'package:bikolayders/models/register_request_model.dart';
import 'package:bikolayders/services/login_service.dart';
import 'package:bikolayders/services/register_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login service test', () async {
    var service = LoginService(Dio());
    var loginServiceResponse = await service.postUserLogin(
      LoginRequestModel(email: "admin@admin.com", password: "password"),
    );
    expect(loginServiceResponse?.success, true);
  });

  test('register service test', () async {
    var service = RegisterService(Dio());
    var registerSR = await service.postUserRegister(
      RegisterRequestModel(
        email: "admin@admin.com",
        name: "erdem1",
        password: "erdem",
        teacher: 1,
      ),
    );
    expect(registerSR?.success, true);
  });
  test('get user test', () async {
    var service = LoginService(Dio());
    var response = await service.getUser();
    expect(response?.success, true);
  });

  test('logout user test', () async {
    var service = LoginService(Dio());
    var response = await service.logout();
    expect(response?.success, true);
  });
}
