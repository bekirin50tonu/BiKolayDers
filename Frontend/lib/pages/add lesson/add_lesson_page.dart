// ignore_for_file: iterable_contains_unrelated_type, list_remove_unrelated_type

import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/multi_select_with_label.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/text_field_with_label.dart';
import 'package:bikolayders/cubits/addLesson/add_lesson_cubit.dart';
import 'package:bikolayders/extensions/string_extensions.dart';
import 'package:bikolayders/models/addLesson/add_lesson_request_model.dart';
import 'package:bikolayders/services/add_lesson_service.dart';
import 'package:bikolayders/services/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({Key? key}) : super(key: key);

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  TextEditingController? nameController = TextEditingController();

  TextEditingController? priceController = TextEditingController();

  TextEditingController? categoryController = TextEditingController();

  var service = AddLessonService(Dio());
  List<dynamic>? allLessonsHours = [];
  List<String> hours = [];

  void getLessonsHours() async {
    var h = await service.getLessonsHours();
    allLessonsHours = h?["data"];
    if (allLessonsHours!.length >= 24) {
      Navigator.pushNamed(context, '/');
    }
    var formatter = NumberFormat("00");
    for (int i = 0; i < 24; i++) {
      var f = "${formatter.format(i)}:00";
      if (allLessonsHours!.contains(f)) {
        f = "";
      }

      hours.add(f);
    }

    setState(() {});
    //allLessonsHours = hours;
  }

  @override
  void initState() {
    super.initState();
    // if (!AuthController.isAuth || !AuthController.isUserTeacher) {
    //   Future.microtask(() => Navigator.pushNamed(context, '/'));
    // }
    getLessonsHours();
  }

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddLessonCubit(
        categoryController: categoryController,
        nameController: nameController,
        priceController: priceController,
        service: service,
      ),
      child: BlocBuilder<AddLessonCubit, AddLessonState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, AddLessonState state) {
    return Scaffold(
      backgroundColor: Styles.colorC,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Styles.colorA,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                TextFieldWithLabel(
                  controller: nameController,
                  labelText: "Ders Adı",
                ),
                SizedBox(height: 8),
                TextFieldWithLabel(
                  controller: categoryController,
                  labelText: "Ders Kategorisi",
                ),
                SizedBox(height: 8),
                TextFieldWithLabel(
                  controller: priceController,
                  labelText: "Saatlik Ücreti",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hntText: "₺",
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 64, left: 64, top: 8),
                  child: MultiSelectWithLabel(
                    selectedItems: List.generate(24, (index) => ""),
                    addItemToList: (val) {
                      var cbt = context.read<AddLessonCubit>();
                      if (!cbt.hours!.contains(val)) {
                        cbt.hours?.add(val);
                      }
                    },
                    removeItemToList: (val) {
                      var cbt = context.read<AddLessonCubit>();
                      if (cbt.hours!.contains(val)) {
                        cbt.hours?.remove(val);
                      }
                    },
                    items: hours,
                    lblText: "Saatler",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Visibility(
                    visible: state is AddLessonFailed,
                    child: Center(
                      child: PoppinsText(
                        txtColor: Colors.red,
                        text: context
                            .watch<AddLessonCubit>()
                            .message
                            .toString()
                            .replaceExtension(),
                        fntSize: 16,
                        fntWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: state is AddLessonLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            await context
                                .read<AddLessonCubit>()
                                .createLesson(context);
                          },
                          child: SizedBox(
                            height: 56,
                            width: 128,
                            child: Center(
                              child: PoppinsText(
                                txtColor: Colors.white,
                                fntSize: 18,
                                fntWeight: FontWeight.bold,
                                text: "Ders Oluştur",
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2E3249),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
