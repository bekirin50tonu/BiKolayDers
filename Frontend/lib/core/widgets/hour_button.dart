import 'package:bikolayders/constants/styles.dart';
import 'package:flutter/material.dart';

import 'package:bikolayders/core/widgets/poppins_text.dart';

enum HourButtonState { disabled, enabled, selected }

class HourButtonWidget extends StatefulWidget {
  final String lblText;
  final Function onPressed;
  HourButtonState state;
  HourButtonWidget({
    Key? key,
    this.state = HourButtonState.enabled,
    required this.lblText,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<HourButtonWidget> createState() => _HourButtonWidgetState();
}

class _HourButtonWidgetState extends State<HourButtonWidget> {
  Color textColorByState() {
    switch (widget.state) {
      case HourButtonState.disabled:
        return Colors.black.withAlpha(50);
      case HourButtonState.enabled:
        return Colors.black;
      case HourButtonState.selected:
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.state == HourButtonState.selected
          ? Styles.colorD
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      disabledColor: Colors.grey.withAlpha(50),
      onPressed: widget.state == HourButtonState.disabled
          ? null
          : () {
              widget.onPressed.call();
              setState(() {});
            },
      child: Center(
        child: PoppinsText(
          fntSize: 12,
          fntWeight: FontWeight.bold,
          text: widget.lblText,
          txtColor: textColorByState(),
        ),
      ),
    );
  }
}
