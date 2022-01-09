import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsText extends StatelessWidget {
  final String text;
  final Color txtColor;
  final double fntSize;
  final FontWeight fntWeight;
  final Shadow shadow;

  const PoppinsText({
    Key? key,
    required this.fntSize,
    required this.fntWeight,
    required this.text,
    this.txtColor = Colors.black,
    this.shadow = const Shadow(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: GoogleFonts.poppins(
        shadows: [
          shadow,
        ],
        textStyle: TextStyle(
          color: txtColor,
          fontSize: fntSize,
          fontWeight: fntWeight,
        ),
      ),
    );
  }
}
