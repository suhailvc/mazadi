class EmailChecker {
  static bool isNotValid(String email) {
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+[.com]+").hasMatch(email);
  }
}

class NameChecker {
  static bool isNotValid(String Name) {
    return !RegExp(r'\D').hasMatch(Name);
  }
}