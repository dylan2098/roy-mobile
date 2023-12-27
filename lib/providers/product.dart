import 'package:flutter/material.dart';
import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:roy_app/utilities/helper.dart';

class ProductProvider {
  static Future<Map<String, dynamic>> getProductsCategory(categoryId, scroll) async {
    final url = Uri.parse(Constant.API + "/product?productType=master&categoryId=" + categoryId.toString() + "&offset=" + scroll.toString());
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  static Future<dynamic> getProduct(productId) async {
    final url = Uri.parse(Constant.API + "/product/" + productId.toString());
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  static showImage(String imageString) {
    if (imageString.isEmpty || imageString.length <= 0) {
      return Container();
    }

    final image = json.decode(imageString);
    if (image.length <= 0 || image['url'].length <= 0) {
      return Container();
    }

    return Image.network(image['url'], fit: BoxFit.cover);
  }

  static showPrice({dynamic grossPrice, dynamic currencyCode, dynamic symbol}) {
    if (grossPrice == null) {
      return 'Contact';
    }

    if (grossPrice > 0 && !currencyCode.isEmpty && !symbol.isEmpty) {
      return symbol + grossPrice.toString();
    }

    return 'Contact';
  }

  static dynamic getGrossPrice(String _valueSelectedColor, String _valueSelectedSize, List<dynamic> productVariants, dynamic productPriceMaster) {
    for (int i = 0; i < productVariants.length; i++) {
      final productVariant = productVariants[i];
      if (productVariant['productColor'] == _valueSelectedColor && productVariant['productSize'] == _valueSelectedSize) {
        if (productVariant['grossPrice'] > 0) {
          return {'price': productVariant['grossPrice'], 'symbol': productVariant['symbol']};
        }
      }
    }
    return {'price': 0.0, 'symbol': ''};
  }

  static dynamic getIdProductVariant(
      String _valueSelectedColor, String _valueSelectedSize, List<dynamic> productVariants, dynamic productPriceMaster) {
    for (int i = 0; i < productVariants.length; i++) {
      final productVariant = productVariants[i];
      if (productVariant['productColor'] == _valueSelectedColor && productVariant['productSize'] == _valueSelectedSize) {
        return productVariant['productId'];
      }
    }
    return 0;
  }

  // get product hot and new
  static Future<Map<String, dynamic>> getProductHotNew(String typeGet) async {
    final url = Uri.parse(Constant.API + "/product/hotnew?typeGet=" + typeGet.toString());
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  // get product wishlist
  static Future<Map<String, dynamic>> getProductWishlist() async {
    final url = Uri.parse(Constant.API + "/product/product-wishlist");
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  // get product search
  static Future<Map<String, dynamic>> getProducts(
    String searchString,
    int sortDisplayType,
    String size,
    double rangeStart,
    double rangeEnd,
    String brand,
    String supplier,
    int offset,
  ) async {
    String urlString = Constant.API + "/product?productType=master";

    if (searchString.length > 0) {
      urlString += "&search=" + searchString;
    }

    if (offset > 0) {
      urlString += "&offset=" + offset.toString();
    }

    if (size.length > 0) {
      urlString += "&size=" + size;
    }

    if (sortDisplayType == 0) {
      urlString += "&isLowPrice=true";
    }

    if (sortDisplayType == 1) {
      urlString += "&isHighPrice=true";
    }

    if (rangeStart > 0) {
      urlString += "&priceRangeStart=" + rangeStart.toString();
    }

    if (rangeEnd > 0) {
      urlString += "&priceRangeEnd=" + rangeEnd.toString();
    }

    if (brand.length > 0) {
      urlString += "&brand=" + brand;
    }

    if (supplier.length > 0) {
      urlString += "&manuFacturer=" + supplier;
    }

    final url = Uri.parse(urlString);

    try {
      String? token = await Auth.getToken();
      final responseApi = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  static showImageInCart(String imageString) {
    if (imageString.isEmpty || imageString.length <= 0) {
      return Container();
    }

    final image = json.decode(imageString);
    if (image.length <= 0 || image['url'].length <= 0) {
      return Container();
    }

    return Image.network(image['url'], fit: BoxFit.cover, height: 100, width: 100);
  }
}
