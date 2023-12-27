import 'dart:async';

import 'package:roy_app/utilities/regex.dart';

class RegisterBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _firstNameController = new StreamController();
  StreamController _lastNameController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get firstNameStream => _firstNameController.stream;
  Stream get lastNameStream => _lastNameController.stream;

  bool inValidInfo(String username, String pass, String email, String phone, String firstName, String lastName) {
    if (firstName.length <= 0) {
      _firstNameController.sink.addError("First name invalid");
      return false;
    }
    _firstNameController.sink.add("OK");

    if (lastName.length <= 0) {
      _lastNameController.sink.addError("Last name invalid");
      return false;
    }
    _lastNameController.sink.add("OK");

    if ((email.length < 0) || !Regex.regexEmail(email)) {
      _emailController.sink.addError("Email invalid!");
      return false;
    }
    _emailController.sink.add("OK");

    if (username.length <= 5) {
      _userController.sink.addError("User name invalid!");
      return false;
    }
    _userController.sink.add("OK");

    if (phone.length < 10 || !Regex.regexPhone(phone)) {
      _phoneController.sink.addError("Phone invalid!");
      return false;
    }
    _phoneController.sink.add("OK");

    if (pass.length <= 6 || !Regex.regexPassword(pass)) {
      _passController.sink.addError("Password must have at least 6 characters, 1 uppercase letter, 1 lowercase letter and 1 special character");
      return false;
    }
    _passController.sink.add("OK");

    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
    _emailController.close();
    _phoneController.close();
    _firstNameController.close();
    _lastNameController.close();
  }
}
