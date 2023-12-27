import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constant.colorTransparent,
          title: Text("Privacy Policy", style: TextStyle(color: Constant.colorBlack)),
        ),
        body: Container(
          child: Text("Designer By Tri Nguyen"),
        ));
  }
}
