import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/screens/product/widgets/product_cart.dart';
import 'package:roy_app/utilities/constant.dart';

class ListProductScreen extends StatefulWidget {
  List<dynamic> productList = [];
  final refresh;
  final ScrollController controller;
  bool loading = true;

  ListProductScreen({required this.productList, required this.refresh, required this.controller, required this.loading});

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> with TickerProviderStateMixin {
  List<String> size = Constant.listSizeProduct;
  List<Color> colors = Constant.listColorsProduct;

  int _selectedColor = 0;
  int _selectedSize = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.0),
            child: CustomScrollView(
              controller: widget.controller,
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: widget.refresh,
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: Constant.defaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        WidgetProductCart.productCart(widget.productList[index], context, colors, _selectedColor, size, _selectedSize, this),
                    childCount: widget.productList.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: widget.loading
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
}
