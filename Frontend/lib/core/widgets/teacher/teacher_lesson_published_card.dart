import 'package:bikolayders/core/core/lesson_card_core.dart';
import 'package:flutter/material.dart';

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/rounded_box_label.dart';

class TeacherLessonPublishedCard extends StatelessWidget {
  final Function onClick;
  final String lessonName;
  final String lessonHours;
  const TeacherLessonPublishedCard({
    Key? key,
    required this.onClick,
    required this.lessonName,
    required this.lessonHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LessonCardCore(
      linesColor: Colors.white,
      backgroundColor: Styles.colorA,
      header: PoppinsText(
        shadow: Shadow(color: Colors.black, blurRadius: 3),
        fntSize: 16,
        fntWeight: FontWeight.bold,
        txtColor: Colors.white,
        text: lessonName,
      ),
      body: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: RoundedBoxLabel(
            lblText: lessonHours,
            backgroundColor: Styles.colorG,
            textColor: Colors.white,
          ),
        ),
        SizedBox()
      ],
      footer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: MaterialButton(
          onPressed: () {},
          color: Colors.red[200],
          height: 50,
          shape: CircleBorder(),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.close,
                    size: 35,
                    color: Colors.white,
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
