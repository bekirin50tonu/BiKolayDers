class StudentLessonsResponseModel {
  bool? success;
  List<StudentLessonResponseData>? data;
  String? message;

  StudentLessonsResponseModel({this.success, this.data, this.message});

  StudentLessonsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StudentLessonResponseData>[];
      json['data'].forEach((v) {
        data!.add(StudentLessonResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class StudentLessonResponseData {
  String? date;
  String? status;
  User? user;
  Parent? parent;

  StudentLessonResponseData({this.date, this.status, this.user, this.parent});

  StudentLessonResponseData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Parent {
  int? id;
  String? hour;
  Parent2? parent;

  Parent({this.id, this.hour, this.parent});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hour = json['hour'];
    parent = json['parent'] != null ? Parent2.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hour'] = hour;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}

class Parent2 {
  int? id;
  String? name;
  User? category;
  User? teacher;

  Parent2({this.id, this.name, this.category});

  Parent2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category =
        json['category'] != null ? User.fromJson(json['category']) : null;
    teacher = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}
