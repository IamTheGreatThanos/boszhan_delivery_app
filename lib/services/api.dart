import 'package:boszhan_delivery_app/utills/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
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

  // getOrders() async {
  //   dio = setDefaultHeaders(dio: dio, token: "");
  //   return await dio.get("${API_URL}api/order/store-for-store");
  // }
  //
  // setDefaultHeaders({required Dio dio, String token = ""}) {
  //   dio.options.headers['content-Type'] = 'application/json';
  //   dio.options.headers["authorization"] = "Bearer ${token}";
  //   dio.options.headers["Accept"] = "application/json";
  //   return dio;
  // }
}
