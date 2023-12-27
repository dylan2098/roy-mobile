import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/bloc/product/product.dart';
import 'package:roy_app/providers/product.dart';
import 'package:roy_app/screens/product/list.dart';
import 'package:roy_app/screens/widgets/modal_bottom.dart';
import 'package:roy_app/utilities/constant.dart';

class ScreenSearchProduct extends StatefulWidget {
  bool isShowModalFilter = false;
  ScreenSearchProduct({this.isShowModalFilter: false});
  @override
  _ScreenSearchProductState createState() => _ScreenSearchProductState();
}

class _ScreenSearchProductState extends State<ScreenSearchProduct> {
  TextEditingController _searchController = new TextEditingController();
  ProductBloc productBloc = new ProductBloc();

  List<dynamic> productList = [];
  bool _loading = true;
  bool isHasData = false;

  int scroll = 1;
  static const double _endReachedThreshold = 200;
  final ScrollController _controller = ScrollController();
  String searchString = "";

  void _onScroll() {
    if (!_controller.hasClients || _loading) return; // Chỉ chạy những dòng dưới nếu như controller đã được mount vào widget và đang không loading

    final thresholdReached = _controller.position.extentAfter < _endReachedThreshold; // Check xem đã đạt tới _endReachedThreshold chưa

    if (thresholdReached && isHasData == true) {
      // gọi lại để chuyển sang page tiếp theo
      products(searchString, sortDisplayType, size, rangeStart, rangeEnd, brand, supplier, scroll = scroll + 1);
    }
  }

  // filter
  int sortDisplayType = -1;
  String size = "";
  double rangeStart = 0.0;
  double rangeEnd = 0.0;
  String brand = "";
  String supplier = "";

  @override
  void initState() {
    _controller.addListener(_onScroll);
    products(searchString, sortDisplayType, size, rangeStart, rangeEnd, brand, supplier, scroll);
    super.initState();

    if (widget.isShowModalFilter == true) {
      Future.delayed(Duration(milliseconds: 500), () => _initModal());
    }
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
                child: StreamBuilder(
                  stream: productBloc.searchStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _searchController,
                      cursorColor: Constant.colorGrey,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        filled: true,
                        fillColor: Constant.colorWhite,
                        prefixIcon: IconButton(
                          onPressed: (_loading == true)
                              ? null
                              : () {
                                  setState(() {
                                    productList = [];
                                  });

                                  products(_searchController.text, sortDisplayType, size, rangeStart, rangeEnd, brand, supplier, 1);
                                },
                          icon: Icon(Icons.search, color: Constant.colorBlack),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search e.g Cotton Sweatshirt",
                        hintStyle: TextStyle(fontSize: 14, color: Constant.colorBlack),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Constant.colorWhite, borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: () {
                    _initModal();
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
      body: Center(
        child: ListProductScreen(
          controller: _controller,
          refresh: _refresh,
          productList: productList,
          loading: _loading,
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      scroll = 1;
      productList.clear();
    });
    products(searchString, sortDisplayType, size, rangeStart, rangeEnd, brand, supplier, 1);
  }

  _initModal() {
    return ModalBottom.modalBottomSheet(context: context, onFilter: onFilter);
  }

  Future<void> onFilter(sortDisplayType, size, rangeStart, rangeEnd, brand, supplier) async {
    setState(() {
      scroll = 1;
      productList.clear();
    });

    products(searchString, sortDisplayType, size, rangeStart, rangeEnd, brand, supplier, scroll);
  }

  Future<void> products(
    String searchString,
    int sortDisplayType,
    String size,
    double rangeStart,
    double rangeEnd,
    String brand,
    String supplier,
    int offset,
  ) async {
    _loading = true;
    isHasData = false;
    Map<String, dynamic> response =
        await ProductProvider.getProducts(searchString, sortDisplayType, size, rangeStart, rangeEnd, brand, supplier, offset);

    if (this.mounted) {
      setState(() {
        if (response['data'].length > 0) {
          productList.addAll(response['data']);
          isHasData = true;
        }
      });
      _loading = false;
    }
  }
}
