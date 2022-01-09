import 'package:bikolayders/models/register_request_model.dart';
import 'package:bikolayders/services/auth_controller.dart';
import 'package:bikolayders/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final RegisterService registerService;

  bool isRegister = false;
  String? message;

  RegisterCubit({
    this.nameController,
    this.emailController,
    this.passwordController,
    required this.registerService,
  }) : super(RegisterInitial());

  Future<void> register(
      {int isTeacher = 0, required BuildContext context}) async {
    emit(RegisterLoading());
    var response = await registerService.postUserRegister(
      RegisterRequestModel(
        email: emailController?.text.trim(),
        name: nameController?.text.trim(),
        password: passwordController?.text.trim(),
        teacher: isTeacher,
      ),
    );
    emit(RegisterComplete());
    isRegister = true;

    if (response?.success == true) {
      Navigator.pushNamed(context, '/login');
    }

    message = response?.message?.replaceAll("\\n", "\n");
    if (response?.success == false) {
      isRegister = false;
    }
  }

  void isAuthenticated() {
    if (AuthController.isAuth == true) {
      emit(Authenticated());
    }
  }
}

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterComplete extends RegisterState {}

class Authenticated extends RegisterState {}
