import 'package:bikolayders/core/core/lesson_card_core.dart';
import 'package:flutter/material.dart';

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/rounded_box_label.dart';

class TeacherLessonApproveCard extends StatelessWidget {
  final Function onAccept;
  final Function onReject;
  final String lessonName;
  final String lessonDate;
  final String lessonHour;
  final String studentName;
  const TeacherLessonApproveCard({
    Key? key,
    required this.onAccept,
    required this.onReject,
    required this.lessonName,
    required this.lessonDate,
    required this.lessonHour,
    required this.studentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LessonCardCore(
      linesColor: Colors.white,
      backgroundColor: Styles.colorD,
      header: PoppinsText(
        shadow: Shadow(color: Colors.black, blurRadius: 3),
        fntSize: 16,
        fntWeight: FontWeight.bold,
        text: lessonName,
        txtColor: Colors.white,
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
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white, width: 2)),
            onPressed: () => onAccept,
            child: RichText(
              text: WidgetSpan(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          MaterialButton(
            height: 50,
            color: Colors.red[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white, width: 2)),
            onPressed: () => onReject,
            child: RichText(
              text: WidgetSpan(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
