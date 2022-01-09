import 'package:bikolayders/core/widgets/animated_header_item.dart';
import 'package:bikolayders/cubits/login/login_cubit.dart';
import 'package:bikolayders/services/login_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';

class LessonHeaderWidget extends StatelessWidget {
  final Function(String)? onFieldChange;

  final Color? searchBorderColor;
  const LessonHeaderWidget({
    Key? key,
    this.searchBorderColor = Colors.transparent,
    this.onFieldChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 64, right: 64, top: 32),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: PoppinsText(
              fntSize: 28,
              fntWeight: FontWeight.bold,
              text: "BiKolayDers",
            ),
          ),
        ),
        Visibility(
          visible: onFieldChange != null,
          child: Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, right: 128),
              child: Container(
                height: 56,
                width: 300,
                child: TextField(
                  onChanged: onFieldChange,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Ders Ara...",
                    hintStyle: TextStyle(
                      color: Colors.black.setAlpha(58),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: searchBorderColor ?? Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: searchBorderColor ?? Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        BlocProvider(
          create: (context) => LoginCubit(loginService: LoginService(Dio())),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 64,
                ),
                child: context.watch<LoginCubit>().isLogouting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : AnimatedHeaderItem(
                        text: "Çıkış Yap",
                        onTap: () async {
                          await BlocProvider.of<LoginCubit>(context)
                              .logout(context);
                          Navigator.pushNamed(context, '/');
                        },
                        indicatorW: 30,
                        indicatorH: 5,
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
