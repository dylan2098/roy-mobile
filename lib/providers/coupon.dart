import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:roy_app/utilities/helper.dart';

class CouponProvider {
  static Future<Map<String, dynamic>> getCouponSearch(String searchString, int offset) async {
    String urlString = Constant.API + "/coupon?search=" + searchString;

    if (offset > 1) {
      urlString += "&offset=" + offset.toString();
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
}
