import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constant.colorTransparent,
          title: Text("About Us", style: TextStyle(color: Constant.colorBlack)),
        ),
        body: Container(
          child: Text("Tri Nguyen"),
        ));
  }
}
