import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/screens/account/login.dart';
import 'package:roy_app/screens/profile/aboutus_screen.dart';
import 'package:roy_app/screens/profile/faq_screen.dart';
import 'package:roy_app/screens/profile/privacy_policy_screen.dart';
import 'package:roy_app/screens/profile/termofuse_screen.dart';
import 'package:roy_app/utilities/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValue = true;

  @override
  void initState() {
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
                          "Settings",
                          style: TextStyle(color: Constant.colorBlack, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Night Theme",
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
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: "About us"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AboutScreen(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: "Terms Of Use"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TermOfUseScreen(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: "Privacy Policy"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PrivacyPolicyScreen(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: "FAQ"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FAQScreen(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                      children: [
                                        TextSpan(text: "Logout"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Auth.logout();
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                ),
                              ],
                            ),
                          ],
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
}
