import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:flutter/material.dart';

class AnimatedHeaderItem extends StatefulWidget {
  final String text;
  final Function() onTap;
  final double indicatorW;
  final double indicatorH;
  const AnimatedHeaderItem({
    Key? key,
    required this.text,
    required this.onTap,
    required this.indicatorW,
    required this.indicatorH,
  }) : super(key: key);

  @override
  State<AnimatedHeaderItem> createState() => _AnimatedHeaderItemState();
}

class _AnimatedHeaderItemState extends State<AnimatedHeaderItem> {
  double width = 0;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          width = value ? widget.indicatorW : 0;
          height = value ? widget.indicatorH : 0;
        });
      },
      hoverColor: Colors.transparent,
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PoppinsText(
            txtColor: Color(0xFF2E3249),
            text: "${widget.text}",
            fntSize: 20,
            fntWeight: FontWeight.bold,
          ),
          AnimatedContainer(
            width: width,
            height: height,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Color(0xFFFFE667),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
