import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/bloc/authorize/register.dart';
import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/screens/widgets/header_widget.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:roy_app/screens/widgets/theme_helper.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  RegisterBloc registerBloc = new RegisterBloc();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.colorWhite,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: registerBloc.firstNameStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'First Name*',
                                'Enter your first name',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _firstNameController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: registerBloc.lastNameStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'Last Name*',
                                'Enter your last name',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _lastNameController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: StreamBuilder(
                              stream: registerBloc.emailStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                    "E-mail*",
                                    "Enter your email",
                                    snapshot.hasError ? snapshot.error.toString() : "",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                );
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: StreamBuilder(
                              stream: registerBloc.userStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                    "User name*",
                                    "Enter your username",
                                    snapshot.hasError ? snapshot.error.toString() : "",
                                  ),
                                  controller: _userNameController,
                                );
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: StreamBuilder(
                              stream: registerBloc.phoneStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                    "Phone*",
                                    "Enter your phone number",
                                    snapshot.hasError ? snapshot.error.toString() : "",
                                  ),
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneController,
                                );
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: StreamBuilder(
                              stream: registerBloc.passStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                    "Password*",
                                    "Enter your password",
                                    snapshot.hasError ? snapshot.error.toString() : "",
                                  ),
                                  controller: _passwordController,
                                );
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Constant.colorWhite,
                                ),
                              ),
                            ),
                            onPressed: () {
                              onRegisterClicked();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRegisterClicked() async {
    String username = _userNameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;

    if (registerBloc.inValidInfo(username, password, email, phone, firstName, lastName)) {
      Object dataRegister = await Auth.register(firstName, lastName, email, username, password, phone);
      if ((dataRegister as Map)['error'] == true) {
        ThemeHelper.alartDialog(context, "Error", dataRegister['message']);
      } else {
        ThemeHelper.alartDialog(context, "Success", "Create Account Success", pageRedirect: "/login");
      }
    }
  }
}
