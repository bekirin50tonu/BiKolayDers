import 'package:bikolayders/pages/add%20lesson/add_lesson_page.dart';
import 'package:bikolayders/pages/login/login_page.dart';
import 'package:bikolayders/pages/main/main_page.dart';
import 'package:bikolayders/pages/student/purchase_lesson_page.dart';
import 'package:bikolayders/pages/student/student_page.dart';
import 'package:bikolayders/pages/teacher/teacher_page.dart';
import 'package:bikolayders/services/auth_controller.dart';
import 'package:flutter/material.dart';

import 'pages/student/lesson_search_page.dart';

Future<void> main() async {
  await AuthController.isAuthenticated();

  await AuthController.isTeacher();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/addLessonPage': (context) => AddLessonPage(),
        '/studentPage': (context) => StudentPage(),
        '/lessonSearchPage': (context) => LessonSearchPage(),
        '/teacherPage': (context) => TeacherPage(),
      },
    );
  }
}
