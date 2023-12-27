import 'package:flutter/material.dart';
import 'package:roy_app/bloc/product/search.dart';
import 'package:roy_app/providers/product.dart';
import 'package:roy_app/screens/cart/cart.dart';
import 'package:roy_app/screens/menu/menu.dart';
import 'package:roy_app/screens/product/widgets/product_cart.dart';
import 'package:roy_app/screens/profile/profile_screen.dart';
import 'package:roy_app/utilities/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _screen = 0;

  // end param filter

  late ScrollController _scrollController;
  bool _isScrolled = false;
  bool _loading = true;

  List<dynamic> productsNew = [];
  List<dynamic> productsHot = [];
  List<dynamic> productsWishlist = [];

  List<String> size = Constant.listSizeProduct;

  List<Color> colors = Constant.listColorsProduct;

  int _selectedColor = 0;
  int _selectedSize = 1;

  var selectedRange = RangeValues(0, 2000.00);

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    getProductsHotNews('new', productsNew);
    getProductsHotNews('hot', productsHot);
    getProductsWishlist(productsWishlist);
    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Constant.primaryColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: _screen,
            onTap: (int index) {
              setState(() {
                _screen = index;
              });
            },
            items: _itemsBottomNavigationbar,
          ),
          body: tabbarView(_screen, context)),
    );
  }

// Bottom navigation bar item
  List<BottomNavigationBarItem> _itemsBottomNavigationbar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Dashboard",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Cart",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Menu',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.chat),
    //   label: 'Chat',
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_rounded),
      label: 'Account',
    ),
  ];

  Widget loadHomePage(context) {
    return PageView(
      children: <Widget>[
        CustomScrollView(controller: _scrollController, slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 300.0,
            elevation: 0,
            pinned: true,
            floating: true,
            stretch: true,
            backgroundColor: Constant.colorGreyShade50,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              titlePadding: EdgeInsets.only(left: 20, right: 30, bottom: 100),
              stretchModes: [
                // StretchMode.fadeTitle
                StretchMode.zoomBackground,
              ],
              title: AnimatedOpacity(
                opacity: _isScrolled ? 0.0 : 1.0,
                duration: Duration(milliseconds: 500),
                child: Text("Find your 2022 Collections",
                    style: TextStyle(
                      color: Constant.colorBlack,
                      fontSize: 28.0,
                    )),
              ),
              background: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Constant.colorGreyShade200,
                      Constant.primaryColor,
                    ],
                    begin: const FractionalOffset(0.1, 0.7),
                    end: const FractionalOffset(0.8, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
            bottom: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Constant.colorTransparent,
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 50,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenSearchProduct(),
                                ));
                          },
                          cursorColor: Constant.colorGrey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            filled: true,
                            fillColor: Constant.colorWhite,
                            prefixIcon: IconButton(
                              onPressed: () async {},
                              icon: Icon(
                                Icons.search,
                                color: Constant.colorBlack,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search e.g Cotton Sweatshirt",
                            hintStyle: TextStyle(fontSize: 14, color: Constant.colorBlack),
                          ),
                        )),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: Constant.colorWhite, borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenSearchProduct(isShowModalFilter: true),
                            ));
                      },
                      icon: Icon(
                        Icons.filter_list,
                        color: Constant.colorBlack,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              WidgetProductCart.productViewHome(
                text: "Product New",
                products: productsNew,
                colors: colors,
                selectedColor: _selectedColor,
                size: size,
                selectedSize: _selectedSize,
                asThis: this,
              ),
              (productsWishlist.length > 0) ? WidgetProductCart.promotionProduct(text: "Wishlist", products: productsWishlist) : Container(),
              WidgetProductCart.productViewHome(
                text: "Best Seller Product",
                products: productsHot,
                colors: colors,
                selectedColor: _selectedColor,
                size: size,
                selectedSize: _selectedSize,
                asThis: this,
              ),
            ]),
          )
        ])
      ],
    );
  }

  Widget tabbarView(screen, context) {
    return TabBarView(
      children: List<Widget>.generate(
        1, // amount screen in one tab
        (index) {
          switch (screen) {
            case 0:
              return Center(
                child: loadHomePage(context),
              );
            case 1:
              return Center(
                child: CartPage(),
              );
            case 2:
              return Center(
                child: MenuScreen(),
              );
            // case 3:
            //   return Center(
            //     child: RecentChats(),
            //   );
            case 3:
              return Center(
                child: ProfileScreen(),
              );
            default:
              return Center(
                child: loadHomePage(context),
              );
          }
        },
      ),
    );
  }

  // handle product hot and new
  Future<void> getProductsHotNews(String typeGet, List<dynamic> productList) async {
    _loading = true;

    // two type is: "hot" and "new"
    Map<String, dynamic> response = await ProductProvider.getProductHotNew(typeGet);

    if (this.mounted) {
      if (response['data'] != null) {
        setState(() {
          productList.addAll(response['data']);
        });
      }
      _loading = false;
    }
  }

  //handle product wishlish
  Future<void> getProductsWishlist(List<dynamic> productList) async {
    _loading = true;

    Map<String, dynamic> response = await ProductProvider.getProductWishlist();

    if (this.mounted) {
      if (response['data'] != null) {
        setState(() {
          productList.addAll(response['data']);
        });
      }
      _loading = false;
    }
  }
}
