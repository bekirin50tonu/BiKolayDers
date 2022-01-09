class StaticStrings {
  static String _baseURL = 'http://192.168.195.10:8000/api';
  static String get loginPath => "$_baseURL/login";
  static String get registerPath => "$_baseURL/register";
  static String get addLessonPath => "$_baseURL/lesson/create";
  static String get getUserPath => "$_baseURL/user";
  static String get getHoursLessons => "$_baseURL/get/lesson/detail/hour";
  static String get purchaseLessonGetHours => "$_baseURL/get/lesson/date_hour";
  static String get purchaseLesson => "$_baseURL/set/lesson/pending";
  static String get getStudentAllLessons => "$_baseURL/get/lesson/student/all";
  static String get logoutPath => "$_baseURL/logout";
  static String get isTokenValid => "$_baseURL/is_auth";
  static String get searchLessonPath => "$_baseURL/search/lesson";
}
