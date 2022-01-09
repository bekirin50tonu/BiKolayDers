import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/text_field_with_label.dart';
import 'package:bikolayders/cubits/login/login_cubit.dart';

import 'package:bikolayders/services/login_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // cubit
  var loginService = LoginService(Dio());
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        emailController: emailController,
        passwordController: passwordController,
        loginService: loginService,
      ),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      backgroundColor: Styles.colorC,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Styles.colorA,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                TextFieldWithLabel(
                  controller: emailController,
                  labelText: "E-Mail",
                ),
                SizedBox(height: 8),
                TextFieldWithLabel(
                  controller: passwordController,
                  labelText: "Şifre",
                  isObsecure: true,
                ),
                Visibility(
                  visible: context.watch<LoginCubit>().isVisible,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: PoppinsText(
                          fntSize: 18,
                          txtColor: Colors.red,
                          fntWeight: FontWeight.bold,
                          text: context.watch<LoginCubit>().errorMessage ?? "",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  child: ElevatedButton(
                    onPressed: () => {
                      // SignIn(),
                      context.read<LoginCubit>().login(context),
                    },
                    child: SizedBox(
                      height: 56,
                      width: 128,
                      child: Center(
                        child: state is LoginLoading
                            ? CircularProgressIndicator()
                            : PoppinsText(
                                txtColor: Colors.white,
                                fntSize: 18,
                                fntWeight: FontWeight.bold,
                                text: "Giriş Yap",
                              ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2E3249),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
