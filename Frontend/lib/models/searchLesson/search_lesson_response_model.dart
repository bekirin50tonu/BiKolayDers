class SearchLessonResponseModel {
  bool? success;
  List<SearchLessonResponseData>? data;
  String? message;

  SearchLessonResponseModel({this.success, this.data, this.message});

  SearchLessonResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SearchLessonResponseData>[];
      json['data'].forEach((v) {
        data!.add(new SearchLessonResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class SearchLessonResponseData {
  int? id;
  String? name;
  double? price;
  User? user;
  List<Detail>? detail;
  Category? category;

  SearchLessonResponseData(
      {this.id, this.name, this.price, this.user, this.detail, this.category});

  SearchLessonResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Detail {
  int? lesson_id;
  String? hour;

  Detail({this.lesson_id, this.hour});

  Detail.fromJson(Map<String, dynamic> json) {
    lesson_id = json['lesson_id'];
    hour = json['hour'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson_id'] = this.lesson_id;
    data['hour'] = this.hour;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  bool? teacher;

  User({this.id, this.name, this.email, this.teacher});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['teacher'] = this.teacher;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
