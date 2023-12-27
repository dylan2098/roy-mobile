import 'dart:async';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _emailController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;
  Stream get emailStream => _emailController.stream;

  bool inValidInfo(String username, String pass) {
    if (!(username.length > 0)) {
      _userController.sink.addError("User name invalid!");
      return false;
    }
    _userController.sink.add("OK");

    if (!(pass.length > 0)) {
      _passController.sink.addError("Password at least 6 characters.");
      return false;
    }
    _passController.sink.add("OK");

    return true;
  }

  bool inValidEmail(String email) {
    if (email.length <= 0) {
      _emailController.sink.addError("Email invalid");
      return false;
    }

    _emailController.sink.add("OK");
    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
    _emailController.close();
  }
}
