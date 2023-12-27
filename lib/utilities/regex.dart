class Regex {
  static bool regexEmail(String email) {
    final regexExEmail = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!(email.isEmpty) && regexExEmail.hasMatch(email)) {
      return true;
    }
    return false;
  }

  static bool regexPhone(String phoneNumber) {
    final regexExPhone = RegExp(r'^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$');
    if (!(phoneNumber.isEmpty) && regexExPhone.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  static bool regexPassword(String password) {
    final regexExPassword = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!(password.isEmpty) && regexExPassword.hasMatch(password)) {
      return true;
    }
    return false;
  }
}
