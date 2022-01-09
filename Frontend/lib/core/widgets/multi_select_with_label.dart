import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/constants/utilities.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/cubits/addLesson/add_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectWithLabel extends StatefulWidget {
  final Function(String)? addItemToList;
  final Function(String)? removeItemToList;
  MultiSelectWithLabel({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.lblText,
    this.addItemToList,
    this.removeItemToList,
  }) : super(key: key);

  late List<String?> items = <String>[];
  List<String?> selectedItems;
  final String lblText;

  @override
  State<MultiSelectWithLabel> createState() => _MultiSelectWithLabelState();
}

class _MultiSelectWithLabelState extends State<MultiSelectWithLabel> {
  // @override
  // void initState() {
  //   for (int i = 0; i < widget.items.length; i++) {
  //     widget.selectedItems.add("");
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.lblText,
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        MultiSelectChipDisplay(
          textStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          alignment: Alignment.center,
          chipColor: Styles.colorB,
          items: widget.items.map((e) => MultiSelectItem(e, e ?? "")).toList(),
          onTap: (value) {
            var index = widget.items.indexOf(value.toString());
            setState(() {
              if (value.toString().isEmpty) return;
              widget.selectedItems[index] = value.toString();
              widget.addItemToList!(value.toString());
              widget.items[index] = "";
            });
          },
        ),
        PoppinsText(
            fntSize: 18,
            fntWeight: FontWeight.bold,
            text: "Seçili ${widget.lblText}"),
        MultiSelectChipDisplay(
          textStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14,
              color: Styles.colorB,
            ),
          ),
          chipColor: Colors.white,
          alignment: Alignment.center,
          items: widget.selectedItems
              .map((e) => MultiSelectItem(e, e ?? ""))
              .toList(),
          onTap: (value) {
            var index = widget.selectedItems.indexOf(value.toString());
            setState(() {
              if (value.toString().isEmpty) return;
              widget.items[index] = value.toString();
              widget.removeItemToList!(value.toString());
              widget.selectedItems[index] = "";
            });
          },
        )
      ],
    );
  }
}
