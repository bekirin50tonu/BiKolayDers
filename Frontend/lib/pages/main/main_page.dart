import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/cubits/register/register_cubit.dart';
import 'package:bikolayders/pages/main/widgets/background_circle.dart';
import 'package:bikolayders/pages/main/widgets/header.dart';
import 'package:bikolayders/services/auth_controller.dart';
import 'package:bikolayders/services/register_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController? nameController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!AuthController.isAuth) return;
    if (!AuthController.isUserTeacher) {
      // Future.microtask(() => Navigator.pushNamed(context, "/studentPage"));
    } else {
      // Future.microtask(() => Navigator.pushNamed(context, "/teacherPage"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        registerService: RegisterService(Dio()),
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
      ),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Widget buildScaffold(BuildContext context, RegisterState state) {
    return Scaffold(
      backgroundColor: Color(0xFFD9A7D5),
      // ignore: avoid_unnecessary_containers
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: 250,
            child: BackgroundCircle(
              circleColor: Color(0xFFFFAAAA),
            ),
          ),
          Positioned(
            bottom: -70,
            left: -20,
            child: BackgroundCircle(
              circleColor: Color(0xFF484848),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 128),
                  child: Header(),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 128),
                  child: Row(
                    children: [
                      Visibility(
                        visible: MediaQuery.of(context).size.width > 1000,
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PoppinsText(
                                fntSize: 32,
                                fntWeight: FontWeight.bold,
                                text: "Canlı derslere ulaşmanın",
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    PoppinsText(
                                      fntSize: 32,
                                      fntWeight: FontWeight.bold,
                                      text: "en ",
                                    ),
                                    AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          "Kolay",
                                          textAlign: TextAlign.start,
                                          speed: Duration(milliseconds: 200),
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFE667),
                                          ),
                                        ),
                                        TyperAnimatedText(
                                          "Hızlı",
                                          textAlign: TextAlign.start,
                                          speed: Duration(milliseconds: 200),
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFE667),
                                          ),
                                        ),
                                        TyperAnimatedText(
                                          "Canlı",
                                          textAlign: TextAlign.start,
                                          speed: Duration(milliseconds: 200),
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFE667),
                                          ),
                                        ),
                                      ],
                                    ),
                                    PoppinsText(
                                      fntSize: 32,
                                      fntWeight: FontWeight.bold,
                                      text: " yolu.",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            width: 720 - 240,
                            height: 800 - 240,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFD7D7),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 64),
                                registerInputLabel(lblText: "Ad Soyad"),
                                registerInput(controller: nameController),
                                registerInputLabel(lblText: "E Mail"),
                                registerInput(controller: emailController),
                                registerInputLabel(lblText: "Şifre"),
                                registerInput(
                                    controller: passwordController,
                                    isObsecure: true),
                                Spacer(),
                                Visibility(
                                  visible: !context
                                      .watch<RegisterCubit>()
                                      .isRegister,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 64,
                                      vertical: 8,
                                    ),
                                    child: state is RegisterLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : PoppinsText(
                                            txtColor: Colors.red,
                                            fntSize: 12,
                                            fntWeight: FontWeight.bold,
                                            text: context
                                                    .watch<RegisterCubit>()
                                                    .message ??
                                                "",
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await context
                                          .read<RegisterCubit>()
                                          .register(context: context);
                                    },
                                    child: Container(
                                      height: 56,
                                      width: 128,
                                      child: Center(
                                        child: PoppinsText(
                                          txtColor: Colors.white,
                                          fntSize: 24,
                                          fntWeight: FontWeight.bold,
                                          text: "Katıl",
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
                                InkWell(
                                  onTap: () async {
                                    await context
                                        .read<RegisterCubit>()
                                        .register(
                                            isTeacher: 1, context: context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 64, vertical: 24),
                                    child: Text(
                                      "Öğretmen Olarak Katıl",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding registerInput(
      {bool isObsecure = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isObsecure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Padding registerInputLabel({required String lblText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Text(
        "${lblText}",
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
