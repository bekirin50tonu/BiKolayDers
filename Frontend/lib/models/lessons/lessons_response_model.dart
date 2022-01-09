import 'package:bikolayders/models/user/user_model.dart';

class LessonsResponseModel {
  final bool? success;
  final LessonsResponseData? data;
  final String? message;

  LessonsResponseModel({
    this.success,
    this.data,
    this.message,
  });
}

class LessonsResponseData {
  final String? name;
  final double? price;
  final UserModel? user;
  final List<Times?>? times;

  LessonsResponseData({
    this.name,
    this.price,
    this.user,
    this.times,
  });
}

class Times {
  final List<Hours?>? hours;
  final List<Days?>? days;

  Times({this.hours, this.days});
}

class Days {
  final String? day;

  Days({this.day});
}

class Hours {
  final String? hours;

  Hours({this.hours});
}
