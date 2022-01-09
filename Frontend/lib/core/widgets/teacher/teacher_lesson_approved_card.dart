import 'package:bikolayders/core/core/lesson_card_core.dart';
import 'package:flutter/material.dart';

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/rounded_box_label.dart';

class TeacherLessonApprovedCard extends StatelessWidget {
  final Function onClick;
  final String lessonName;
  final String lessonDate;
  final String lessonHour;
  final String studentName;
  const TeacherLessonApprovedCard({
    Key? key,
    required this.onClick,
    required this.lessonName,
    required this.lessonDate,
    required this.lessonHour,
    required this.studentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LessonCardCore(
      linesColor: Colors.white,
      backgroundColor: Styles.colorC,
      header: PoppinsText(
        shadow: Shadow(color: Colors.black, blurRadius: 3),
        fntSize: 16,
        fntWeight: FontWeight.bold,
        txtColor: Colors.white,
        text: lessonName,
      ),
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: RoundedBoxLabel(
            lblText: lessonDate,
            backgroundColor: Styles.colorF,
            textColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: RoundedBoxLabel(
            lblText: lessonHour,
            backgroundColor: Styles.colorG,
            textColor: Colors.white,
          ),
        ),
        PoppinsText(
          fntSize: 16,
          fntWeight: FontWeight.normal,
          text: "- $studentName -",
        ),
      ],
      footer: Row(
        children: [
          MaterialButton(
            height: 50,
            color: Colors.green[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: Colors.white, width: 1)),
            onPressed: () => onClick,
            child: RichText(
              text: WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: PoppinsText(
                    fntSize: 16,
                    fntWeight: FontWeight.bold,
                    text: "Dersi Başlat",
                    txtColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
