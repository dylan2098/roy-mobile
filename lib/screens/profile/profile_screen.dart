import 'package:flutter/material.dart';
import 'package:roy_app/screens/notification/notification_screen.dart';
import 'package:roy_app/screens/profile/components/profile_menu.dart';
import 'package:roy_app/screens/profile/components/profile_pic.dart';
import 'package:roy_app/screens/profile/info_screen.dart';
import 'package:roy_app/screens/profile/setting_screen.dart';
import 'package:roy_app/utilities/constant.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.colorTransparent,
        title: Text("My account", style: TextStyle(color: Constant.colorBlack)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            ProfileMenu(
              text: "Profile",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoScreen(),
                    ))
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ));
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
              },
            ),
            ProfileMenu(
              text: "Orders",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Wishlist",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
