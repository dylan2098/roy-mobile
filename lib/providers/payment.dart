import 'package:roy_app/providers/auth.dart';
import 'package:roy_app/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:roy_app/utilities/helper.dart';

class PaymentProvider {
  static Future<Map<String, dynamic>> addReciverAddress(String name, String phone, String email, String address, String zipCode) async {
    String urlString = Constant.API + "/customer-address";

    final url = Uri.parse(urlString);
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "selected": false,
            "name": name,
            "phone": phone,
            "email": email,
            "address": address,
            "zipCode": zipCode,
          }));

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> getListAddress() async {
    String urlString = Constant.API + "/customer-address";

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

  static Future<Map<String, dynamic>> updateSelectedAddress(int id, bool selected) async {
    String urlString = Constant.API + "/customer-address";

    final url = Uri.parse(urlString);
    try {
      String? token = await Auth.getToken();

      final responseApi = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "selected": selected,
            "id": id,
          }));

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> getAdressSelected() async {
    String urlString = Constant.API + "/customer-address/selected";

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

  static Future<Map<String, dynamic>> createdOrder(String currencyCode, String customerEmail, String customerName, String customerPhone,
      String customerAddress, dynamic carts, String createdBy, String customerLocaleID,
      {String customerZipcode = ""}) async {
    String urlString = Constant.API + "/orders";

    final url = Uri.parse(urlString);
    try {
      String? token = await Auth.getToken();
      final responseApi = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "currencyCode": currencyCode,
            "customerEmail": customerEmail,
            "customerName": customerName,
            "customerPhone": customerPhone,
            "customerAddress": customerAddress,
            "customerZipCode": customerZipcode,
            "customerLocaleID": customerLocaleID,
            "carts": carts,
            "createdBy": createdBy
          }));

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
