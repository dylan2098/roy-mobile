import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/bloc/authorize/login.dart';
import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/screens/account/forgot_password_page.dart';
import 'package:roy_app/screens/account/registration_page.dart';
import 'package:roy_app/screens/home.dart';
import 'package:roy_app/screens/widgets/header_widget.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:roy_app/screens/widgets/theme_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  LoginBloc loginBloc = new LoginBloc();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Signin into your account',
                        style: TextStyle(color: Constant.colorGrey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: StreamBuilder(
                                  stream: loginBloc.userStream,
                                  builder: (context, snapshot) => TextField(
                                    decoration: ThemeHelper().textInputDecoration(
                                      'User Name',
                                      'Enter your user name',
                                      snapshot.hasError ? snapshot.error.toString() : "",
                                    ),
                                    controller: _userController,
                                  ),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: StreamBuilder(
                                    stream: loginBloc.passStream,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        obscureText: true,
                                        decoration: ThemeHelper().textInputDecoration(
                                          'Password',
                                          'Enter your password',
                                          snapshot.hasError ? snapshot.error.toString() : "",
                                        ),
                                        controller: _passController,
                                      );
                                    }),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                                    );
                                  },
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Constant.colorGrey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Login'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Constant.colorWhite,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    onSignInClicked();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Don\'t have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                      },
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void onSignInClicked() async {
    if (loginBloc.inValidInfo(_userController.text, _passController.text)) {
      Object dataAuth = await Auth.login(_userController.text, _passController.text);
      if ((dataAuth as Map)['error'] == true) {
        ThemeHelper.alartDialog(context, "Error", dataAuth['message']);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }
}
