import 'package:flutter/material.dart';

class Styles {
  static Color get colorA => Color(0xFFD9A7D5);
  static Color get colorB => Color(0xFF2E3249);
  static Color get colorC => Color(0xFFFFD7D7);
  static Color get colorD => Color(0xFFF2D07D);
  static Color get colorE => Color(0xFFF2A2A9);
  static Color get colorF => Color(0xFFFFAAAA);
  static Color get colorG => Color(0xFFD9A7D5);
  static Color get textColorA => Color(0xFF454545);
}

extension ColorChanging on Color {
  Color setAlpha(int alpha) {
    return Color.fromARGB(alpha, red, green, blue);
  }
}
