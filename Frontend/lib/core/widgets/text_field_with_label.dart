import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWithLabel extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool isObsecure;
  final String? hntText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  const TextFieldWithLabel({
    Key? key,
    required this.labelText,
    this.isObsecure = false,
    this.inputFormatters,
    this.hntText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Text(
            labelText,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            obscureText: isObsecure,
            decoration: InputDecoration(
              hintText: hntText,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        )
      ],
    );
  }
}
