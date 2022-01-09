class PurchaseLessonGetHoursRequestModel {
  String? date;
  int id;

  PurchaseLessonGetHoursRequestModel(
    this.date,
    this.id,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = date;
    data['id'] = id;
    return data;
  }
}
