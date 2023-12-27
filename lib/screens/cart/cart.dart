import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:roy_app/providers/cart.dart';
import 'package:roy_app/providers/product.dart';
import 'package:roy_app/screens/payment/payment.dart';
import 'package:roy_app/screens/product/detail.dart';
import 'package:roy_app/utilities/constant.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  late List<dynamic> cartItems = [];
  late List<dynamic> cartItemCount = [];

  double totalPrice = 0.0;
  bool _loading = true;
  bool _isHasData = false;

  Future<void> fetchItems() async {
    Map<String, dynamic> response = await CartProvider.getCart();
    if (this.mounted) {
      if (response['data'].length > 0) {
        setState(() {
          cartItems.addAll(response['data']);
          _loading = false;
          _isHasData = true;
        });
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
    sumTotal();
  }

  sumTotal() {
    setState(() {
      if (this.mounted) {
        cartItems.forEach((product) {
          cartItemCount.add({'productId': product['productId'], 'amount': product['buyAmount']});
          totalPrice = totalPrice + product['grossPrice'] * product['buyAmount'];
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      _isHasData = false;
      _loading = true;
    });
    fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.colorTransparent,
        title: Text('My Cart', style: TextStyle(color: Constant.colorBlack)),
      ),
      body: (_loading && _isHasData == false)
          ? Container(
              padding: EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : (_loading == false && _isHasData == false)
              ? Container(
                  child: Center(
                    child: Text('No Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height * 0.53,
                        child: cartItems.length > 0
                            ? ListView.builder(
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  return cartItem(cartItems[index], index);
                                })
                            : Container()),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Shipping', style: TextStyle(fontSize: 20)),
                          Text('\$0.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: DottedBorder(color: Constant.colorGreyShade400, dashPattern: [10, 10], padding: EdgeInsets.all(0), child: Container()),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total', style: TextStyle(fontSize: 20)),
                          Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
                        },
                        height: 50,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Constant.primaryColor,
                        child: Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(color: Constant.colorWhite, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }

  cartItem(final product, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductViewPage(
              productId: product['productMaster'],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
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
              child: ProductProvider.showImageInCart((product['productImage'] != null) ? product['productImage'] : ''),
            ),
          ),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(
                product['productBrand'],
                style: TextStyle(
                  color: Constant.primaryColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                product['productName'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Text(
                (product['symbol'].length > 0 ? product['symbol'] : '') + (product['grossPrice'] > 0 ? product['grossPrice'] : 0).toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Constant.colorGreyShade800,
                ),
              ),
              SizedBox(height: 10),
            ]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 10,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  if (cartItemCount[index]['amount'] > 0) {
                    setState(() {
                      cartItemCount[index]['amount'] = cartItemCount[index]['amount'] - 1;
                      totalPrice = totalPrice - product['grossPrice'];
                    });
                    updateCart();
                  }

                  if (cartItemCount[index]['amount'] <= 0) {
                    setState(() {
                      cartItemCount.removeAt(index);
                      cartItems.removeAt(index);
                    });
                  }
                },
                shape: CircleBorder(),
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Constant.colorGreyShade400,
                  size: 30,
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    cartItemCount[index]['amount'].toString(),
                    style: TextStyle(fontSize: 20, color: Constant.colorGreyShade800),
                  ),
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.all(0),
                minWidth: 10,
                splashColor: Constant.colorYellow700,
                onPressed: () {
                  setState(() {
                    cartItemCount[index]['amount'] = cartItemCount[index]['amount'] + 1;
                    totalPrice = totalPrice + product['grossPrice'];
                  });
                  updateCart();
                },
                shape: CircleBorder(),
                child: Icon(
                  Icons.add_circle,
                  size: 30,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void updateCart() {
    CartProvider.updateProductCart(cartItemCount);
  }
}
