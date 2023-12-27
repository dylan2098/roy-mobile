import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:roy_app/utilities/helper.dart';

class CartProvider {
  static Future<dynamic> getCart() async {
    final url = Uri.parse(Constant.API + "/cart");
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

  static Future<dynamic> updateProductCart(final data) async {
    final url = Uri.parse(Constant.API + '/cart/update-cart');
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          {'contentCart': data},
        ),
      );

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }
}
