import 'package:flutter/material.dart';
import 'package:roy_app/providers/product.dart';
import 'package:roy_app/screens/product/detail.dart';
import 'package:roy_app/screens/widgets/modal_bottom.dart';
import 'package:roy_app/utilities/constant.dart';

class WidgetProductCart {
  static productCart(final product, context, colors, selectedColor, size, selectedSize, asThis) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductViewPage(
              productId: product['productId'],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 5, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Constant.colorWhite,
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 10),
              blurRadius: 15,
              color: Constant.colorGreyShade200,
            )
          ],
        ),
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ProductProvider.showImage((product['productImage'] != null) ? product['productImage'] : ''),
                    ),
                  ),
                  // Add to cart button
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: MaterialButton(
                      color: Constant.colorBlack,
                      minWidth: 45,
                      height: 45,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        ModalBottom.addToCartModal(
                          context: context,
                          colors: colors,
                          selectedColor: selectedColor,
                          size: size,
                          selectedSize: selectedSize,
                          asThis: asThis,
                        );
                      },
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Icon(
                        Icons.shopping_cart,
                        color: Constant.colorWhite,
                        size: 20,
                      )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              product['productName'],
              style: TextStyle(
                color: Constant.colorBlack,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['productBrand'],
                  style: TextStyle(
                    color: Constant.primaryColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  ProductProvider.showPrice(grossPrice: product['grossPrice'], currencyCode: product['currencyCode'], symbol: product['symbol']),
                  style: TextStyle(
                    color: Constant.colorBlack54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static wishList(final product) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20, bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Constant.colorWhite,
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 10),
              blurRadius: 15,
              color: Constant.colorGreyShade200,
            )
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: ProductProvider.showImage((product['productImage'] != null) ? product['productImage'] : ''),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  product['productName'],
                  style: TextStyle(
                    color: Constant.colorBlack,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  product['productBrand'],
                  style: TextStyle(
                    color: Constant.primaryColor,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\$ " + product['grossPrice'].toString(),
                  style: TextStyle(color: Constant.colorBlack, fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  static Widget promotionProduct({text, products}) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      height: 180,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: Constant.colorBlack, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                'See all ',
                style: TextStyle(color: Constant.colorBlack, fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return wishList(products[index]);
              }),
        )
      ]),
    );
  }

  static Widget productViewHome({text, products, colors, selectedColor, size, selectedSize, asThis}) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      height: 330,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: Constant.colorBlack, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                'See all ',
                style: TextStyle(color: Constant.colorBlack, fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 1 / 1,
                child: WidgetProductCart.productCart(products[index], context, colors, selectedColor, size, selectedSize, asThis),
              );
            },
          ),
        )
      ]),
    );
  }
}
