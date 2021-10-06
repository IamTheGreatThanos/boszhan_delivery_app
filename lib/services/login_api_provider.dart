import 'package:boszhan_delivery_app/utills/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginProvider{
  String API_URL = AppConstants.baseUrl;

  Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(API_URL + 'api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
        "role": 2
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> status = jsonDecode(response.body);
      return status['data'];
    }
    else {
      return 'Error';
    }
  }
}