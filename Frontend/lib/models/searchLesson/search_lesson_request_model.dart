class SearchLessonRequestModel {
  String? search;

  SearchLessonRequestModel({this.search});

  SearchLessonRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    return data;
  }
}
