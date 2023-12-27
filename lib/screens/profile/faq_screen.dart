import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constant.colorTransparent,
          title: Text("FAQ", style: TextStyle(color: Constant.colorBlack)),
        ),
        body: Container(
          child: Text("Designer by Tri Nguyen"),
        ));
  }
}
