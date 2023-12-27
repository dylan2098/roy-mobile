import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roy_app/utilities/constant.dart';
import 'package:roy_app/utilities/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static late String _token;
  static late int _userId;
  static late String _locale;
  static late int _role;
  static late int _status;

  bool get isAuth => _token != null;

  String get token => _token;
  int get userId => _userId;
  String get locale => _locale;
  int get role => _role;
  int get status => _status;

  static void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<Object> register(String firstName, String lastName, String email, String userName, String password, String phoneNumber) async {
    final url = Uri.parse(Constant.API + "/users/");
    try {
      final responseApi = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'username': userName,
          'phone': phoneNumber,
          'firstName': firstName,
          'lastName': lastName,
        }),
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

  static Future<Object> resetPassword(String email) async {
    final url = Uri.parse(Constant.API + "/users/forgot-password");
    try {
      final responseApi = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
        }),
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

  static Future<Object> login(String username, String password) async {
    final url = Uri.parse(Constant.API + "/users/login");

    try {
      final responseApi = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final responseData = jsonDecode(responseApi.body);

      if (responseData['statusCode'] != 200) {
        return Helper.response(responseData);
      }

      final result = responseData['data'];
      _token = result['accessToken'];
      _locale = result['locale'];
      _role = result['role'];
      _status = result['status'];
      _userId = result['id'];

      // set storage
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'locale': _locale,
          'role': _role,
          'status': _status,
        },
      );

      prefs.setString('userData', userData);
      setToken(_token);
      return Helper.response(responseData);
    } catch (e) {
      throw e;
    }
  }

  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
