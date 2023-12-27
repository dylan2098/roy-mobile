import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/bloc/product/coupon.dart';
import 'package:roy_app/providers/coupon.dart';
import 'package:roy_app/screens/payment/payment.dart';
import 'package:roy_app/utilities/constant.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  TextEditingController searchController = new TextEditingController();

  bool _loading = true;
  bool _isHasData = true;
  List<dynamic> couponList = [];
  int scroll = 1;

  final ScrollController _controller = ScrollController();
  String searchString = "";

  static const double _endReachedThreshold = 200;

  TextEditingController _searchController = new TextEditingController();
  CouponBloc couponBloc = new CouponBloc();

  void _onScroll() {
    if (!_controller.hasClients || _loading) return; // Chỉ chạy những dòng dưới nếu như controller đã được mount vào widget và đang không loading

    final thresholdReached = _controller.position.extentAfter < _endReachedThreshold; // Check xem đã đạt tới _endReachedThreshold chưa

    if (thresholdReached && _isHasData == true) {
      // gọi lại để chuyển sang page tiếp theo
      getCoupons(searchString, scroll = scroll + 1);
    }
  }

  @override
  void initState() {
    _controller.addListener(_onScroll);
    getCoupons(searchString, 1);
    super.initState();
  }

  @override
  void dispose() {
    _loading = true;
    couponList = [];
    scroll = 0;
    _searchController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.colorWhite,
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          titlePadding: EdgeInsets.only(left: 20, right: 30, bottom: 100),
          stretchModes: [
            StretchMode.zoomBackground,
          ],
          background: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Constant.colorGreyShade200,
                  Constant.primaryColor,
                ],
                begin: const FractionalOffset(0.1, 0.6),
                end: const FractionalOffset(0.1, 0.0),
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
                child: StreamBuilder(
                    stream: couponBloc.searchStream,
                    builder: (context, snapshot) {
                      return TextField(
                        cursorColor: Constant.colorGrey,
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          filled: true,
                          fillColor: Constant.colorWhite,
                          prefixIcon: IconButton(
                            onPressed: (_loading == true)
                                ? null
                                : () {
                                    setState(() {
                                      couponList = [];
                                      searchString = _searchController.text;
                                    });

                                    getCoupons(_searchController.text, 1);
                                  },
                            icon: Icon(Icons.search, color: Constant.colorBlack),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search coupon",
                          hintStyle: TextStyle(fontSize: 14, color: Constant.colorBlack),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                CupertinoSliverRefreshControl(onRefresh: _refresh),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return cartItem(couponList[index]);
                    },
                    childCount: couponList.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _loading
                      ? Container(
                          padding: EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      scroll = 1;
      couponList.clear();
    });
    getCoupons(searchString, 1);
  }

  cartItem(coupon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Constant.colorWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Constant.colorGreyShade200,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                "Coupon with special promotional value. Please don't shared with anybody.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    coupon["code"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constant.colorRed,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                    coupon: coupon,
                                  )),
                          ModalRoute.withName("/payment"));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Use",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
            ]),
          ),
        ]),
      ),
    );
  }

  Future<void> getCoupons(String searchString, int scroll) async {
    _loading = true;
    _isHasData = false;
    Map<String, dynamic> response = await CouponProvider.getCouponSearch(searchString, scroll);

    if (this.mounted) {
      setState(() {
        if (response['data'].length > 0) {
          couponList.addAll(response['data']);
          _isHasData = true;
        }
      });
      _loading = false;
    }
  }
}
