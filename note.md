- backend co the tinh them ngay het han cuar token de kiem tra du lieu va refresh token
- update backend ve search product master

Upload image flutter: https://stackoverflow.com/questions/44841729/how-to-upload-image-in-flutter



                // activeCard == 0
                //     ? AnimatedOpacity(
                //         duration: Duration(milliseconds: 500),
                //         opacity: activeCard == 0 ? 1 : 0,
                //         child: Container(
                //           width: double.infinity,
                //           height: 200,
                //           padding: EdgeInsets.all(20.0),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(30),
                //               gradient: LinearGradient(
                //                 colors: [
                //                   Constant.colorOrange,
                //                   Constant.colorYellowShade800,
                //                   Constant.colorYellowShade900,
                //                 ],
                //                 begin: Alignment.topLeft,
                //                 end: Alignment.bottomRight,
                //               )),
                //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //             Text(
                //               "Credit Card",
                //               style: TextStyle(color: Constant.colorWhite),
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "**** **** **** 7890",
                //                   style: TextStyle(color: Constant.colorWhite, fontSize: 30),
                //                 ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Text(
                //                       "Master Card",
                //                       style: TextStyle(color: Constant.colorWhite),
                //                     ),
                //                     Image.network('https://img.icons8.com/color/2x/mastercard-logo.png', height: 50),
                //                   ],
                //                 )
                //               ],
                //             )
                //           ]),
                //         ),
                //       )
                //     : AnimatedOpacity(
                //         duration: Duration(milliseconds: 500),
                //         opacity: activeCard == 1 ? 1 : 0,
                //         child: Container(
                //           width: double.infinity,
                //           height: 200,
                //           padding: EdgeInsets.all(30.0),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(30),
                //               // color: Constant.colorGreyShade200
                //               gradient: LinearGradient(
                //                 colors: [
                //                   Constant.colorGreyShade200,
                //                   Constant.colorGreyShade100,
                //                   Constant.colorGreyShade200,
                //                   Constant.colorGreyShade300,
                //                 ],
                //                 begin: Alignment.topLeft,
                //                 end: Alignment.bottomRight,
                //               )),
                //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Image.network('https://img.icons8.com/ios/2x/mac-os.png', height: 50),
                //                 SizedBox(
                //                   height: 30,
                //                 ),
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   crossAxisAlignment: CrossAxisAlignment.end,
                //                   children: [
                //                     Text(
                //                       "The Flutter Lover",
                //                       style: TextStyle(color: Constant.colorBlack, fontSize: 18),
                //                     ),
                //                     Image.network(
                //                       'https://img.icons8.com/ios/2x/sim-card-chip.png',
                //                       height: 35,
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             )
                //           ]),
                //         ),
                //       ),
                // SizedBox(
                //   height: 50,
                // ),
                // Text(
                //   "Payment Method",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Row(children: [
                //   GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         activeCard = 0;
                //       });
                //     },
                //     child: AnimatedContainer(
                //       duration: Duration(milliseconds: 300),
                //       margin: EdgeInsets.only(right: 10),
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(18),
                //         border: activeCard == 0
                //             ? Border.all(color: Constant.colorGreyShade300, width: 1)
                //             : Border.all(color: Constant.colorGreyShade300withOpacity0, width: 1),
                //       ),
                //       child: Image.network(
                //         'https://img.icons8.com/color/2x/mastercard-logo.png',
                //         height: 50,
                //       ),
                //     ),
                //   ),
                //   GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         activeCard = 1;
                //       });
                //     },
                //     child: AnimatedContainer(
                //       duration: Duration(milliseconds: 300),
                //       margin: EdgeInsets.only(right: 10),
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(18),
                //         border: activeCard == 1
                //             ? Border.all(color: Constant.colorGreyShade300, width: 1)
                //             : Border.all(color: Constant.colorGreyShade300withOpacity0, width: 1),
                //       ),
                //       child: Image.network(
                //         'https://img.icons8.com/ios-filled/2x/apple-pay.png',
                //         height: 50,
                //       ),
                //     ),
                //   ),
                // ]),