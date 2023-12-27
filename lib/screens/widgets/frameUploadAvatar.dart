import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class FrameUploadAvatar extends StatefulWidget {
  const FrameUploadAvatar({Key? key}) : super(key: key);

  @override
  _FrameUploadAvatarState createState() => _FrameUploadAvatarState();
}

class _FrameUploadAvatarState extends State<FrameUploadAvatar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 5, color: Constant.colorWhite),
              color: Constant.colorWhite,
              boxShadow: [
                BoxShadow(
                  color: Constant.colorBlack12,
                  blurRadius: 20,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              color: Constant.colorGreyShade300,
              size: 80.0,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
            child: Icon(
              Icons.add_circle,
              color: Constant.colorGreyShade700,
              size: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
