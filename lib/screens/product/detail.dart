import 'package:flutter/material.dart';
import 'package:roy_app/providers/cart.dart';
import 'package:roy_app/providers/product.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:roy_app/utilities/hexcolor.dart';

class ProductViewPage extends StatefulWidget {
  final productId;
  const ProductViewPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  bool _loading = true;
  late final product;
  dynamic price = 0.0;
  String symboy = '';
  int _productVariantId = 0;

  List<dynamic> productColors = [];
  List<dynamic> productSizes = [];
  List<dynamic> productVariants = [];
  List<int> productsInCart = [];

  List<dynamic> carts = [];

  int _selectedColor = 0;
  int _selectedSize = 0;

  String _valueSelectedColor = '';
  String _valueSelectedSize = '';

  @override
  void initState() {
    getCarts();
    getProduct(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading
        ? Scaffold(
            backgroundColor: Constant.colorWhite,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.6,
                elevation: 0,
                snap: true,
                floating: true,
                stretch: true,
                backgroundColor: Constant.colorGreyShade50,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                  ],
                  background: ProductProvider.showImage((product['productImage'] != null) ? product['productImage'] : ''),
                ),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(45),
                    child: Transform.translate(
                      offset: Offset(0, 1),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Constant.colorWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                            child: Container(
                          width: 50,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Constant.colorGreyShade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                      ),
                    )),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    color: Constant.colorWhite,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['productName'],
                                  style: TextStyle(
                                    color: Constant.colorBlack,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            Text(
                              (price != 0.0) ? symboy + price.toString() : 'Out of stock',
                              style: TextStyle(
                                color: Constant.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          product['productShortDescription'],
                          style: TextStyle(
                            height: 1.5,
                            color: Constant.colorGreyShade800,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Color",
                          style: TextStyle(color: Constant.colorGreyShade400, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productColors.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                    _valueSelectedColor = productColors[index];

                                    final dataProduct = ProductProvider.getGrossPrice(
                                        _valueSelectedColor, _valueSelectedSize, productVariants, product['grossPrice']);

                                    final productVariantId = ProductProvider.getIdProductVariant(
                                        _valueSelectedColor, _valueSelectedSize, productVariants, product['grossPrice']);

                                    price = dataProduct['price'];
                                    symboy = dataProduct['symbol'];
                                    _productVariantId = productVariantId;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: _selectedColor == index
                                          ? HexColor.fromHex(productColors[index])
                                          : HexColor.fromHex(productColors[index]).withOpacity(0.5),
                                      shape: BoxShape.circle),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: _selectedColor == index
                                        ? Icon(
                                            Icons.check,
                                            color: Constant.colorWhite,
                                          )
                                        : Container(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Size',
                          style: TextStyle(color: Constant.colorGreyShade400, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productSizes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSize = index;
                                    _valueSelectedSize = productSizes[index];

                                    final dataProduct = ProductProvider.getGrossPrice(
                                        _valueSelectedColor, _valueSelectedSize, productVariants, product['grossPrice']);

                                    final productVariantId = ProductProvider.getIdProductVariant(
                                        _valueSelectedColor, _valueSelectedSize, productVariants, product['grossPrice']);

                                    price = dataProduct['price'];
                                    symboy = dataProduct['symbol'];
                                    _productVariantId = productVariantId;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: _selectedSize == index ? Constant.colorYellow800 : Constant.colorGreyShade200, shape: BoxShape.circle),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      productSizes[index],
                                      style: TextStyle(color: _selectedSize == index ? Constant.colorWhite : Constant.colorBlack, fontSize: 15),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: (price != 0.0)
                              ? () async {
                                  if (_loading == false) {
                                    if (productsInCart.contains(_productVariantId)) {
                                      setState(() {
                                        carts.forEach((cart) {
                                          if (cart['productId'] == _productVariantId) {
                                            cart['amount'] = cart['amount'] + 1;
                                          }
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        carts.add({'productId': _productVariantId, 'amount': 1});
                                        productsInCart.add(_productVariantId);
                                      });
                                    }

                                    final response = await CartProvider.updateProductCart(carts);
                                    if (response['statusCode'] == 200) {
                                      final snackbar = SnackBar(
                                        content: Text("Item added to cart"),
                                        duration: Duration(seconds: 1),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    } else {
                                      final snackbar = SnackBar(
                                        content: Text("Add to cart failed"),
                                        duration: Duration(milliseconds: 10),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    }
                                  }
                                }
                              : null,
                          height: 50,
                          elevation: 0,
                          splashColor: Constant.colorYellow700,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Constant.colorYellow800,
                          child: Center(
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(color: Constant.colorWhite, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ))
              ])),
            ]),
          )
        : Container(
            padding: EdgeInsets.only(bottom: 16),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  Future<void> getCarts() async {
    Map<String, dynamic> response = await CartProvider.getCart();
    if (this.mounted) {
      if (response['data'].length > 0) {
        setState(() {
          response['data'].forEach((product) {
            productsInCart.add(product['productId']);
            carts.add({'productId': product['productId'], 'amount': product['buyAmount']});
          });
        });
      }
    }
  }

  Future<void> getProduct(int productId) async {
    _loading = true;

    Map<String, dynamic> response = await ProductProvider.getProduct(productId);

    if (this.mounted) {
      setState(() {
        product = response['data'];
        _loading = false;
        productColors = product['colors'];
        productSizes = product['sizes'];

        _valueSelectedColor = productColors[0];
        _valueSelectedSize = productSizes[0];

        if (product['productVariants'] != null && product['listProductVariants'] != null) {
          productVariants = product['listProductVariants'];
          final dataProduct = ProductProvider.getGrossPrice(_valueSelectedColor, _valueSelectedSize, productVariants, product['grossPrice']);

          final productVariantId =
              ProductProvider.getIdProductVariant(_valueSelectedColor, _valueSelectedSize, productVariants, product['grossPrice']);

          price = dataProduct['price'];
          symboy = dataProduct['symbol'];
          _productVariantId = productVariantId;
        } else {
          price = product['grossPrice'];
          symboy = product['symbol'];
          _productVariantId = product['productId'];
        }
      });
    }
  }
}
