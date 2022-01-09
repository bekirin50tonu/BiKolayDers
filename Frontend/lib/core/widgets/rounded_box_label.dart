import 'package:flutter/material.dart';

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';

class RoundedBoxLabel extends StatelessWidget {
  final String lblText;
  final Color backgroundColor;
  final Color textColor;
  const RoundedBoxLabel({
    Key? key,
    required this.lblText,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: Colors.black.withAlpha(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: PoppinsText(
          fntSize: 16,
          fntWeight: FontWeight.bold,
          text: lblText,
          txtColor: textColor,
        ),
      ),
    );
  }
}
