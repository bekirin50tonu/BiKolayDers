import 'package:flutter/material.dart';

import 'package:bikolayders/constants/styles.dart';

class LessonCardCore extends StatelessWidget {
  final Widget header;
  final List<Widget> body;
  final Widget footer;
  final Color backgroundColor;
  final Color linesColor;
  const LessonCardCore({
    Key? key,
    required this.header,
    required this.body,
    required this.footer,
    this.backgroundColor = Colors.white,
    this.linesColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: BorderSide(color: linesColor, width: 0.5)),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              header,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: linesColor,
                  height: 1,
                  width: 200,
                ),
              ),
              Column(
                children: body,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  color: linesColor,
                  height: 1,
                  width: 200,
                ),
              ),
              footer
            ],
          ),
        ),
      ),
    );
  }
}
