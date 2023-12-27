import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roy_app/screens/onboard.dart';
import 'package:roy_app/utilities/constant.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    new Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnboardingScreen()), (route) => false);
      });
    });

    new Timer(Duration(milliseconds: 10), () {
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            Constant.colorGreyShade200,
            Constant.primaryColor,
          ],
          begin: const FractionalOffset(0.1, 0.7),
          end: const FractionalOffset(0.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: Center(
                child: Image(
                  image: AssetImage("assets/images/fluttertutorial.net-logo.png"),
                  height: 300.0,
                  width: 300.0,
                ),
              ), //put your logo here
            ),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
              BoxShadow(
                color: Constant.colorBlackOpacity03,
                blurRadius: 2.0,
                offset: Offset(5.0, 3.0),
                spreadRadius: 2.0,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
