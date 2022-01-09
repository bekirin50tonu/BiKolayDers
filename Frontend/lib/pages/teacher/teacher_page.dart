import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/lesson_header_widget.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/teacher/teacher_lesson_approve_card.dart';
import 'package:bikolayders/core/widgets/teacher/teacher_lesson_approved_card.dart';
import 'package:bikolayders/core/widgets/teacher/teacher_lesson_published_card.dart';
import 'package:bikolayders/cubits/teacher/teacher_cubit.dart';
import 'package:bikolayders/services/teacher_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

class TeacherPage extends StatefulWidget {
  final String? studentName;
  const TeacherPage({Key? key, this.studentName}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  TeacherService service = TeacherService(Dio());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherCubit(service: service),
      child: BlocBuilder<TeacherCubit, TeacherState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // if (!AuthController.isAuth || !AuthController.isUserTeacher) {
    //   Future.microtask(() => Navigator.pushNamed(context, '/'));
    // }
  }

  Scaffold buildScaffold(BuildContext context, TeacherState state) => Scaffold(
        extendBody: true,
        floatingActionButton: MaterialButton(
          hoverElevation: 10,
          textColor: Styles.colorD,
          onPressed: () {
            Navigator.pushNamed(context, "/addLessonPage");
          },
          shape: CircleBorder(),
          color: Styles.colorB,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LessonHeaderWidget(
                searchBorderColor: Styles.colorD,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Styles.colorD,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Expanded(
                      child: PoppinsText(
                        fntSize: 32,
                        fntWeight: FontWeight.bold,
                        text: "Yayınlanan Dersler",
                        txtColor: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: PoppinsText(
                        fntSize: 32,
                        fntWeight: FontWeight.bold,
                        text: "Onaylanan Dersler",
                        txtColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 64, right: 0),
                          child: ResponsiveGridRow(
                            rowSegments: 12,
                            children: List.generate(
                              16,
                              (index) => ResponsiveGridCol(
                                  xs: 12,
                                  sm: 12,
                                  md: 6,
                                  lg: 4,
                                  xl: 3,
                                  child: TeacherLessonPublishedCard(
                                    lessonName: "Matematik",
                                    lessonHours: "11:00\n12:00\n13:00",
                                    onClick: () {},
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 500,
                      height: 500,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 64),
                          child: ResponsiveGridRow(
                            rowSegments: 12,
                            children: List.generate(
                              16,
                              (index) => ResponsiveGridCol(
                                  xs: 12,
                                  sm: 12,
                                  md: 6,
                                  lg: 4,
                                  xl: 3,
                                  child: TeacherLessonApprovedCard(
                                    lessonDate: "05/01/2022",
                                    lessonHour: "11:00",
                                    lessonName: "Matematik",
                                    studentName: "Erdem Kalay",
                                    onClick: () {},
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Styles.colorD,
                      height: 1,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 64),
                child: PoppinsText(
                  fntSize: 32,
                  fntWeight: FontWeight.bold,
                  text: "Onay Bekleyen Dersler",
                  txtColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: ResponsiveGridRow(
                      children: List.generate(
                        8,
                        (index) => ResponsiveGridCol(
                          lg: 2,
                          xs: 6,
                          md: 3,
                          child: TeacherLessonApproveCard(
                            lessonDate: "05/01/2022",
                            lessonHour: "11:00",
                            lessonName: "Matematik",
                            studentName: "Erdem Kalay",
                            onAccept: () {},
                            onReject: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
