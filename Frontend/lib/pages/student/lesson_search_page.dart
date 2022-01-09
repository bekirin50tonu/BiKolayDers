import 'package:bikolayders/constants/styles.dart';
import 'package:bikolayders/core/widgets/student/lesson_card.dart';
import 'package:bikolayders/core/widgets/lesson_header_widget.dart';
import 'package:bikolayders/core/widgets/poppins_text.dart';
import 'package:bikolayders/cubits/searchLesson/search_lesson_cubit.dart';
import 'package:bikolayders/pages/student/purchase_lesson_page.dart';
import 'package:bikolayders/services/search_lesson_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

class LessonSearchPage extends StatefulWidget {
  final String? studentName;
  const LessonSearchPage({Key? key, this.studentName}) : super(key: key);

  @override
  State<LessonSearchPage> createState() => _LessonSearchPageState();
}

class _LessonSearchPageState extends State<LessonSearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchLessonCubit(SearchLessonService(Dio())),
      child: BlocBuilder<SearchLessonCubit, SearchLessonState>(
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  bool? init = false;

  @override
  void initState() {
    super.initState();
    // if (!AuthController.isAuth || AuthController.isUserTeacher) {
    //   Future.microtask(() => Navigator.pushNamed(context, '/'));
    // }
  }

  Scaffold buildScaffold(BuildContext context, state) {
    if (init == false) {
      context.read<SearchLessonCubit>().searchLesson("");
      init = true;
    }

    return Scaffold(
      backgroundColor: Styles.colorD,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LessonHeaderWidget(
              onFieldChange: (val) async {
                if (state is SearchLessonComplete)
                  context.read<SearchLessonCubit>().searchLesson(val);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
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
                text: "Bulunan Dersler",
                txtColor: Colors.white,
              ),
            ),
            state is SearchLessonComplete
                ? ResponsiveGridRow(
                    children: List.generate(
                      state.data.length,
                      (index) => ResponsiveGridCol(
                        lg: 2,
                        xs: 6,
                        md: 3,
                        child: LessonCard(
                          lessonName: state.data[index]?.name ?? "",
                          teacherName: state.data[index]?.user?.name ?? "",
                          lessonPrice: state.data[index]?.price ?? 0,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PurchaseLessonPage(data: state.data[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
