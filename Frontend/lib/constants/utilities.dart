extension ListStuff on List<dynamic> {
  bool isAllEmpty() {
    bool result = false;
    for (int i = 0; i < length; i++) {
      result = this[i].isEmpty;
    }
    return result;
  }
}

class Utilities {
  static String token = "";
}
