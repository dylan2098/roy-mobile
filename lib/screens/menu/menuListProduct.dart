import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/providers/product.dart';
import 'package:roy_app/screens/product/widgets/product_cart.dart';
import 'package:roy_app/utilities/constant.dart';

class MenuProductScreen extends StatefulWidget {
  final int categoryId;

  const MenuProductScreen({this.categoryId = 0});

  @override
  _MenuProductScreenState createState() => _MenuProductScreenState();
}

class _MenuProductScreenState extends State<MenuProductScreen> with TickerProviderStateMixin {
  List<dynamic> productList = [];
  bool _loading = true;
  bool isHasData = false;

  int scroll = 1;

  static const double _endReachedThreshold = 200;

  final ScrollController _controller = ScrollController();

  List<String> size = Constant.listSizeProduct;

  List<Color> colors = Constant.listColorsProduct;

  int _selectedColor = 0;
  int _selectedSize = 1;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    products(widget.categoryId, scroll);
    super.initState();
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return; // Chỉ chạy những dòng dưới nếu như controller đã được mount vào widget và đang không loading

    final thresholdReached = _controller.position.extentAfter < _endReachedThreshold; // Check xem đã đạt tới _endReachedThreshold chưa

    if (thresholdReached && isHasData == true) {
      // gọi lại để chuyển sang page tiếp theo
      products(widget.categoryId, scroll = scroll + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.0),
            child: CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: _refresh,
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: Constant.defaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => WidgetProductCart.productCart(productList[index], context, colors, _selectedColor, size, _selectedSize, this),
                    childCount: productList.length,
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
      ],
    );
  }

  Future<void> _refresh() async {
    setState(() {
      scroll = 1;
      productList.clear();
    });
    products(widget.categoryId, 1);
  }

  Future<void> products(int categoryId, int scroll) async {
    _loading = true;
    isHasData = false;
    Map<String, dynamic> response = await ProductProvider.getProductsCategory(categoryId, scroll);

    if (this.mounted) {
      setState(() {
        productList.addAll(response['data']);

        if (response['data'].length > 0) {
          isHasData = true;
        }
      });
      _loading = false;
    }
  }
}
