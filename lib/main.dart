import 'package:flutter/material.dart';
import 'package:roy_app/screens/account/splash_screen.dart';
import 'package:roy_app/screens/home.dart';
import 'package:roy_app/screens/account/login.dart';
import 'package:roy_app/screens/payment/payment.dart';
import 'package:roy_app/utilities/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Onboarding UI',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(title: 'Flutter Login UI'),
      theme: ThemeData(
        primaryColor: Constant.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Constant.accentColor),
        scaffoldBackgroundColor: Constant.colorGreyShade100,
        primarySwatch: Constant.colorGrey,
      ),
      routes: {
        "/home": (_) => new HomeScreen(),
        "/login": (_) => new LoginPage(),
        "/payment": (_) => new PaymentPage(),
      },
    );
  }
}
