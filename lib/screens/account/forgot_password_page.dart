import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/bloc/authorize/login.dart';
import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/screens/account/login.dart';
import 'package:roy_app/screens/widgets/header_widget.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:roy_app/screens/widgets/theme_helper.dart';

import 'forgot_password_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  LoginBloc loginBloc = new LoginBloc();
  TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
      backgroundColor: Constant.colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.password_rounded),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Constant.colorBlack54),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter the email address associated with your account.',
                            style: TextStyle(
                                // fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Constant.colorBlack54),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'We will email you a verification code to check your authenticity.',
                            style: TextStyle(
                              color: Constant.colorBlack38,
                              // fontSize: 20,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: StreamBuilder(
                                stream: loginBloc.emailStream,
                                builder: (context, snapshot) {
                                  return TextFormField(
                                    decoration: ThemeHelper().textInputDecoration("Email", "Enter your email"),
                                    controller: _emailController,
                                  );
                                }),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Send".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Constant.colorWhite,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                buttonSendClick();
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Remember your password? "),
                                TextSpan(
                                  text: 'Login',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    },
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void buttonSendClick() async {
    String email = _emailController.text;
    if (loginBloc.inValidEmail(_emailController.text)) {
      Object response = await Auth.resetPassword(email);
      if (this.mounted) {
        if ((response as Map)['error'] == true) {
          ThemeHelper.alartDialog(context, "Error", response['message']);
        } else {
          ThemeHelper.alartDialog(context, "Success", "Resset Account Success. Please Check Email.", pageRedirect: "/login");
        }
      }
    }
  }
}
