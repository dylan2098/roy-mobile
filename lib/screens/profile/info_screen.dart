import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/screens/profile/change_password_screen.dart';
import 'package:roy_app/screens/widgets/theme_helper.dart';
import 'package:roy_app/utilities/constant.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late dynamic isEdit;
  bool _switchValue = true;

  @override
  void initState() {
    isEdit = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.colorWhite,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Information",
                          style: TextStyle(color: Constant.colorBlack, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: !isEdit ? "Edit" : "Not Edit"),
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Icon(Icons.edit, size: 20, color: Constant.colorRed),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isEdit = !isEdit;
                                    });
                                  },
                                ),
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorBlue500, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: "Edit Password"),
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Icon(Icons.edit, size: 20, color: Constant.colorBlue500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChangePasswordScreen(),
                                        ));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                              'First Name*',
                              'Enter First name',
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                              'Last Name',
                              'Enter Last name',
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                              'Phone*',
                              'Enter your phone',
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                              'Birthday',
                              'Enter Birthday',
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subscribe News",
                                  style: TextStyle(fontSize: 16),
                                ),
                                CupertinoSwitch(
                                  value: _switchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _switchValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        isEdit
                            ? Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      "SUBMIT".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Constant.colorWhite,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {},
                                ),
                              )
                            : Container(),
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
}
