import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateTimeWithLabel extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy");
  DateTime selectedDate;
  final String lblText;
  final Function(DateTime?) onChanged;
  DateTimeWithLabel({
    Key? key,
    required this.lblText,
    required this.onChanged,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          lblText,
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        DateTimeField(
          initialValue: selectedDate,
          decoration: InputDecoration(
            hintText: "${format.pattern}",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          format: format,
          onChanged: (v) {
            onChanged(v);
          },
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(
                  days: 15,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
