import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/lesson_header_widget.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/core/widgets/student/student_own_lesson_card.dart';
import 'package:bikolayders/cubits/student/student_cubit.dart';
import 'package:bikolayders/models/lessons/get_student_lessons_response_model.dart';
import 'package:bikolayders/services/student_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

class StudentPage extends StatefulWidget {
  final String? studentName;
  const StudentPage({Key? key, this.studentName}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  bool isInit = false;
  var service = StudentService(Dio());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentCubit(service: service),
      child: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // if (!AuthController.isAuth || AuthController.isUserTeacher) {
    //   Future.microtask(() => Navigator.pushNamed(context, '/'));
    // }
  }

  Scaffold buildScaffold(BuildContext context, StudentState state) {
    if (!isInit) {
      Future.microtask(() => context.read<StudentCubit>().getAllLessons());
      isInit = true;
    }
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 64),
              child: PoppinsText(
                fntSize: 32,
                fntWeight: FontWeight.bold,
                text: "Alınan Dersler",
                txtColor: Colors.black,
              ),
            ),
            state is StudentComplete
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: ResponsiveGridRow(
                      children: List.generate(
                        state.allLessons?.length ?? 0,
                        (index) => ResponsiveGridCol(
                            lg: 2,
                            xs: 8,
                            md: 3,
                            child: StudentOwnLessonCard(
                              lessonDate: state.allLessons?[index].date ?? "",
                              lessonHour:
                                  state.allLessons?[index].parent?.hour ?? "",
                              lessonName: state.allLessons?[index].parent
                                      ?.parent?.name ??
                                  "",
                              teacherName: state.allLessons?[index].parent
                                      ?.parent?.teacher?.name ??
                                  "",
                              onClick: state.allLessons?[index].status == "sold"
                                  ? () {}
                                  : null,
                              buttonLabel:
                                  state.allLessons?[index].status == "pending"
                                      ? "Onay Bekleniyor"
                                      : "Derse Katıl",
                            )),
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
