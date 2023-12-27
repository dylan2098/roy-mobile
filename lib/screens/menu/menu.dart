import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roy_app/screens/menu/menuListProduct.dart';
import 'package:roy_app/utilities/constant.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

const List<String> tabNames = Constant.listTabName;

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  int _screen = 0;

  Widget _tabIndex(BuildContext context, int index) {
    if (index > 5 || index < 0) index = 1;
    return MenuProductScreen(categoryId: index + 1);
  }

  @override
  void dispose() {
    _screen = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constant.colorWhite,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/qrcode.svg",
              height: 30.0,
              width: 30.0,
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                // By default our  icon color is white
                color: Constant.textColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/cart.svg",
                // By default our  icon color is white
                color: Constant.textColor,
              ),
              onPressed: () {},
            ),
            SizedBox(width: Constant.defaultPaddin / 2)
          ],
          bottom: PreferredSize(
            preferredSize: _screen == 0 ? Size.fromHeight(50.0) : Size.fromHeight(0),
            child: Material(
              color: Constant.colorWhite,
              textStyle: TextStyle(color: Constant.colorBlack),
              child: TabBar(
                labelColor: Constant.colorBlack,
                isScrollable: true,
                tabs: List.generate(tabNames.length, (index) {
                  return Tab(
                    text: tabNames[index],
                  );
                }),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List<Widget>.generate(
            tabNames.length,
            (index) {
              switch (_screen) {
                case 0:
                  return Center(child: _tabIndex(context, index));
                default:
                  return Center(
                    child: Text('Screen default'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
