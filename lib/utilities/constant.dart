import 'package:flutter/material.dart';

class Constant {
  static const API = "http://localhost:5000/api/v1";
  static const String imageDir = "assets/images";
  static const String imageOnBoard_0 = '$imageDir/onboarding0.png';
  static const String imageOnBoard_1 = '$imageDir/onboarding1.png';
  static const String imageOnBoard_2 = '$imageDir/onboarding2.png';

  static final primaryColor = Color(0xffF89F66);
  static final accentColor = Colors.white;
  static final textColor = Color(0xFF757575);
  static final defaultPaddin = 10.0;

  static List<Color> listColorsProduct = [
    Constant.colorBlack,
    Colors.purple,
    Constant.colorOrangeShade200,
    Constant.colorBlueGrey,
    Color(0xFFFFC1D9)
  ];

  static List<String> listSizeProduct = ["S", "M", "L", "XL", "2XL", "3XL", "MAX"];
  static const List<String> listTabName = const <String>["Bag", "Female", "Male", "Shoes", "Child", "Clothes"];

  static final titleStyle = TextStyle(
    color: Constant.colorWhite,
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  static final subtitleStyle = TextStyle(
    color: Constant.colorWhite,
    fontSize: 18.0,
    height: 1.2,
  );

  // color black
  static final colorBlack = Colors.black;
  static final colorBlackOpacity03 = Colors.black.withOpacity(0.3);
  static final colorBlackOpacity01 = Colors.black.withOpacity(0.1);
  static final colorBlack54 = Colors.black54;
  static final colorBlack26 = Colors.black26;
  static final colorBlack38 = Colors.black38;
  static final colorBlack12 = Colors.black12;

  // color white
  static final colorWhite = Colors.white;
  static final colorTransparent = Colors.transparent;

  // color pink
  static final colorPink1 = Color(0xFF3594DD);
  static final colorPink2 = Color(0xFF4563DB);

  // color orange
  static final colorOrange = Colors.orange;
  static final colorOrange1 = Color(0xFF5036D5);
  static final colorOrange2 = Color(0xFF5B16D0);
  static final colorOrangeShade200 = Constant.colorOrange.shade200;

  // color grey
  static final colorGrey = Colors.grey;
  static final colorGreyShade100 = Constant.colorGrey.shade100;
  static final colorGreyShade200 = Constant.colorGrey.shade200;
  static final colorGreyShade300 = Constant.colorGrey.shade300;
  static final colorGreyShade400 = Constant.colorGrey.shade400;
  static final colorGreyShade700 = Constant.colorGrey.shade700;
  static final colorGreyShade800 = Constant.colorGrey.shade800;
  static final colorGreyShade300withOpacity0 = Constant.colorGrey.shade300.withOpacity(0);
  static final colorGreyShade50 = Constant.colorGrey.shade50;

  // color red
  static final colorRed = Colors.red;
  static final colorRed600 = Colors.red.shade600;

  // color blueGrey
  static final colorBlueGrey = Colors.blueGrey;
  static final colorBlue500 = Colors.blue.shade500;

  // color yellow
  static final colorYellow700 = Colors.yellow[700];
  static final colorYellow800 = Colors.yellow[800];
  static final colorYellowShade800 = Colors.yellow.shade800;
  static final colorYellowShade900 = Colors.yellow.shade900;

  // color purple
  static final colorDeepPurpleShade300 = Colors.deepPurple.shade300;
}
