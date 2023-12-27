import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class ThemeHelper {
  InputDecoration textInputDecoration([String lableText = "", String hintText = "", String errorText = ""]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      errorText: errorText,
      fillColor: Constant.colorWhite,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide(color: Constant.colorGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide(color: Constant.colorGreyShade400),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide(color: Constant.primaryColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide(color: Constant.primaryColor, width: 2.0),
      ),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Constant.colorBlackOpacity01,
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Constant.colorBlack26, offset: Offset(0, 4), blurRadius: 5.0),
      ],
      gradient: LinearGradient(
        colors: [
          Constant.colorGreyShade200,
          Constant.primaryColor,
        ],
        begin: const FractionalOffset(0.2, 2.8),
        end: const FractionalOffset(0.0, 0.0),
        stops: [0.5, 1.0],
        tileMode: TileMode.clamp,
      ),
      color: Constant.colorDeepPurpleShade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Constant.colorTransparent),
      shadowColor: MaterialStateProperty.all(Constant.colorTransparent),
    );
  }

  static alartDialog(BuildContext context, String title, String content, {String pageRedirect = ''}) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (!pageRedirect.isEmpty && pageRedirect.length > 0) {
          Navigator.pushReplacementNamed(context, pageRedirect);
        } else {
          Navigator.of(context).pop();
        }
      },
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Constant.colorBlack38)),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class LoginFormStyle {}
