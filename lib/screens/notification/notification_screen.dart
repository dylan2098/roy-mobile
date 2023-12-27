import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.colorTransparent,
        title: Text('Notifications', style: TextStyle(color: Constant.colorBlack)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            height: MediaQuery.of(context).size.height * 0.88,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return cartItem(index + 1);
                }),
          )
        ],
      ),
    );
  }

  cartItem(int index) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: GestureDetector(
        onTap: () {
          print("call on tap");
        },
        child: Card(
          elevation: 5,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.red, width: 5)),
              ),
              child: Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network("http://res.cloudinary.com/dvweth7yl/image/upload/v1637231395/ImagesProduct/nyjiaibof6wlkkotpaj2.jpg",
                        fit: BoxFit.cover, height: 100, width: 100),
                  ),
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text(
                      "Notifications " + index.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                        color: Constant.colorGreyShade800,
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
