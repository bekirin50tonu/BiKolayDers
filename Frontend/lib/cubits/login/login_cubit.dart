import 'package:bikolayders/models/login_request_model.dart';
import 'package:bikolayders/models/login_response_model.dart';
import 'package:bikolayders/services/auth_controller.dart';
import 'package:bikolayders/services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final LoginService loginService;

  bool isLogouting = false;

  String? errorMessage;
  bool isVisible = false;
  String? name;
  LoginCubit({
    this.emailController,
    this.passwordController,
    required this.loginService,
  }) : super(LoginInitial());

  Future<void> login(BuildContext context) async {
    emit(LoginLoading());
    var loginServiceResponse = await loginService.postUserLogin(
      LoginRequestModel(
        email: emailController?.text.trim(),
        password: passwordController?.text.trim(),
      ),
    );
    if (loginServiceResponse?.success == false) {
      emit(LoginFailed(loginServiceResponse?.message));
      isVisible = true;
      errorMessage = loginServiceResponse?.message?.replaceAll("\\n", "\n");
    } else {
      emit(LoginComplete());
      name = loginServiceResponse?.data?.name;

      isVisible = false;
      Navigator.pushNamed(context, '/studentPage', arguments: name);
    }
  }

  Future<void> logout(BuildContext context) async {
    isLogouting = true;
    var response = await loginService.logout();
    if (response?.success == true) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", "");
      isLogouting = false;
      Navigator.pushNamed(context, '/studentPage');
    }
  }
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginComplete extends LoginState {}

class LoginFailed extends LoginState {
  final String? failMessage;

  LoginFailed(this.failMessage);
}

abstract class LoginState {}
