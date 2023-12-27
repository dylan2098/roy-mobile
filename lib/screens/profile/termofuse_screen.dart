import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class TermOfUseScreen extends StatelessWidget {
  const TermOfUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constant.colorTransparent,
          title: Text("Terms of Use", style: TextStyle(color: Constant.colorBlack)),
        ),
        body: Container(
          child: Text("Tri Nguyen"),
        ));
  }
}
