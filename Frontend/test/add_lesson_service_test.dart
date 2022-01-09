import 'package:bikolayders/models/addLesson/add_lesson_request_model.dart';
import 'package:bikolayders/services/add_lesson_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('add lesson service test', () async {
    var service = AddLessonService(
      Dio(),
    );

    final response = await service.postLesson(
      AddLessonRequestModel(
        name: "Matematik Dersi",
        category: "Matematik",
        price: 100,
        hours: ["00:00"],
      ),
    );
    expect(response?.success, true);
  });
}
