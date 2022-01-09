class PurchaseLessonRequestModel {
  int? id;
  List<String>? hours;
  String? date;

  PurchaseLessonRequestModel({
    this.date,
    this.hours,
    this.id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hours'] = hours;
    data['date'] = date;
    data['id'] = id;
    return data;
  }
}
