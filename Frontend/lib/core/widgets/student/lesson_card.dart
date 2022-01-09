import 'package:bikolayders/core/core/lesson_card_core.dart';
import "package:flutter/material.dart";

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';

class LessonCard extends StatelessWidget {
  final String lessonName;
  final String teacherName;
  final String? buttonText;
  final double lessonPrice;
  final Color backgroundColor;
  final Function()? onPressed;
  const LessonCard({
    Key? key,
    required this.lessonName,
    required this.teacherName,
    this.backgroundColor = Colors.white,
    this.buttonText = "Dersi Al",
    required this.lessonPrice,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LessonCardCore(
      linesColor: Styles.colorD,
      header: PoppinsText(
        fntSize: 16,
        fntWeight: FontWeight.bold,
        text: lessonName,
      ),
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: PoppinsText(
            fntSize: 16,
            fntWeight: FontWeight.bold,
            text: "- $teacherName -",
            txtColor: Styles.colorB,
          ),
        ),
      ],
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PoppinsText(
                fntSize: 24, fntWeight: FontWeight.bold, text: "$lessonPrice₺"),
          ),
          MaterialButton(
            onPressed: onPressed,
            color: Styles.colorD,
            height: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
