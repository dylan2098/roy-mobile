import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roy_app/providers/cart.dart';
import 'package:roy_app/providers/payment.dart';
import 'package:roy_app/screens/cart/cart.dart';
import 'package:roy_app/screens/payment/coupon_screen.dart';
import 'package:roy_app/screens/payment/payment_success.dart';
import 'package:roy_app/screens/payment/receiver_screen.dart';
import 'package:roy_app/utilities/constant.dart';

class PaymentPage extends StatefulWidget {
  final coupon;
  final addressReceiver;
  const PaymentPage({this.coupon, this.addressReceiver});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int activeCard = 0;
  double totalPrice = 0.0;
  late dynamic selectedAddress;
  bool _isLoading = false;
  bool _loadingPayment = false;
  late Timer _timer;
  late List<dynamic> cartItems = [];
  String symbol = "";

  late var paymentMethod;

  @override
  void initState() {
    print("call init");
    fetchItems();
    paymentMethod = 0;
    selectedAddress = {};
    _isLoading = true;
    getSelectedAdress();
    super.initState();
  }

  @override
  void dispose() {
    _isLoading = true;
    cartItems = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constant.colorTransparent,
        elevation: 0,
        title: Text(
          'Payment',
          style: TextStyle(color: Constant.colorBlack),
        ),
        leading: BackButton(
          color: Constant.colorBlack,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            )
          },
        ),
      ),
      body: _isLoading
          ? Container(
              padding: EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Choose Payment", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        ListTile(
                          title: const Text('Cash On Delivery'),
                          leading: Radio(
                            value: 0,
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Text("Recipient Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: TextButton(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Constant.colorRed, fontWeight: FontWeight.bold, fontSize: 15),
                                children: [
                                  TextSpan(
                                      text: (widget.addressReceiver != null)
                                          ? widget.addressReceiver["name"] +
                                              "\n" +
                                              widget.addressReceiver["phone"] +
                                              "\n" +
                                              widget.addressReceiver["address"]
                                          : (selectedAddress != null &&
                                                  selectedAddress["name"] != null &&
                                                  selectedAddress["phone"] != null &&
                                                  selectedAddress["address"] != null)
                                              ? selectedAddress["name"] + "\n" + selectedAddress["phone"] + "\n" + selectedAddress["address"]
                                              : "Add receiver",
                                      style: TextStyle(
                                        height: 2,
                                      )),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Icon(Icons.edit, size: 20, color: Constant.colorRed),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiverScreen()));
                        },
                      ),
                    ),
                    SizedBox(height: 30),

                    // list product buy
                    Text("List Product Buy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 30),
                    Container(
                      height: (cartItems.length * 55 <= 300) ? cartItems.length * 55 : 300,
                      padding: EdgeInsets.only(left: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Constant.colorWhite),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        height: MediaQuery.of(context).size.height * 0.53,
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    cartItems[index]["productName"],
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    cartItems[index]["buyAmount"].toString(),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Constant.colorWhite),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Coupon",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CouponScreen()));
                            },
                            child: Row(
                              children: [
                                Text((widget.coupon != null && widget.coupon["code"] != "") ? widget.coupon["code"] : ""),
                                Icon(Icons.keyboard_arrow_down, size: 20),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payment",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(symbol + totalPrice.toStringAsFixed(2), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 30),

                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        child: _loadingPayment
                            ? CircularProgressIndicator(
                                backgroundColor: Constant.colorWhite,
                                strokeWidth: 3,
                                color: Constant.primaryColor,
                              )
                            : MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    _loadingPayment = true;
                                  });
                                  createOrder(cartItems);
                                },
                                height: 50,
                                elevation: 0,
                                splashColor: Constant.primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                color: Constant.primaryColor,
                                child: Center(
                                  child: _isLoading
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Constant.colorWhite,
                                            strokeWidth: 3,
                                            color: Constant.primaryColor,
                                          ),
                                        )
                                      : Text(
                                          "Pay",
                                          style: TextStyle(color: Constant.colorWhite, fontSize: 18),
                                        ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }

  redirectPage() {
    const oneSec = const Duration(seconds: 0);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _isLoading = false;
          timer.cancel();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentSuccess()));
        });
      },
    );
  }

  // get selected address
  Future<void> getSelectedAdress() async {
    Map<String, dynamic> response = await PaymentProvider.getAdressSelected();
    if (this.mounted) {
      setState(() {
        if (response['data'].length > 0) {
          selectedAddress = response['data'];
        }
        _isLoading = false;
      });
    }
  }

  Future<void> fetchItems() async {
    Map<String, dynamic> response = await CartProvider.getCart();
    if (this.mounted) {
      if (response['data'].length > 0) {
        setState(() {
          cartItems.addAll(response['data']);
          _isLoading = false;

          symbol = cartItems[0]['symbol'];

          cartItems.forEach((productInCart) => {totalPrice = totalPrice + productInCart['grossPrice'] * productInCart['buyAmount']});
        });
      } else {
        setState(() {
          _isLoading = true;
        });
      }
    }
  }

  Future<void> createOrder(dynamic carts) async {
    String currencyCode = "GBP";
    String customerEmail = "nguyentri.7264@gmail.com";
    String customerName = "Roy Nguyen";
    String customerPhone = "0949667264";
    String customerAddress = "Nhon Son, Ninh Son, Ninh Thuan";
    String createdBy = "System";
    String customerLocaleID = "en_GB";

    Map<String, dynamic> response = await PaymentProvider.createdOrder(
        currencyCode, customerEmail, customerName, customerPhone, customerAddress, carts, createdBy, customerLocaleID);
    if (this.mounted) {
      setState(() {
        _loadingPayment = false;
      });
      redirectPage();
    }
  }
}
