import 'package:bikolayders/core/widgets/animated_header_item.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';

import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  double width = 0;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: MediaQuery.of(context).size.width > 600,
          child: PoppinsText(
            text: "BiKolayDers",
            fntSize: 36,
            fntWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        AnimatedHeaderItem(
          indicatorH: 5,
          indicatorW: 64,
          text: "Giriş Yap",
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             Utilities.token == "" ? LoginPage() : AddLessonPage()));
            Navigator.pushNamed(context, '/login');
          },
        ),
        // SizedBox(width: 32),
        // AnimatedHeaderItem(
        //   indicatorH: 5,
        //   indicatorW: 64,
        //   text: "Öğretmen Girişi",
        //   onTap: () {},
        // ),
      ],
    );
  }
}
