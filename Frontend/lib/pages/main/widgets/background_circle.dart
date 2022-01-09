import 'package:flutter/material.dart';

class BackgroundCircle extends StatelessWidget {
  final Color circleColor;
  const BackgroundCircle({
    Key? key,
    required this.circleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
    );
  }
}
