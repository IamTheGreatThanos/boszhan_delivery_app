import 'package:boszhan_delivery_app/utills/const.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  String API_URL = AppConstants.baseUrl;
  Dio dio = Dio();

  login(String email, String password) async {
    dio.options.headers['content-Type'] = 'application/json';
    try {
      var response = await dio.post("${API_URL}api/auth/login", data: {
        "email": email,
        "password": password,
        "role" : 2
      });
      print('Success');
      return response.data['data'];
    } catch (e) {
      print('Error');
      return null;
    }
  }

  getOrders() async {
    dio = setDefaultHeaders(dio: dio, token: "");
    return await dio.get("${API_URL}api/order/store-for-store");
  }

  setDefaultHeaders({required Dio dio, String token = ""}) {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token}";
    dio.options.headers["Accept"] = "application/json";
    return dio;
  }
}
