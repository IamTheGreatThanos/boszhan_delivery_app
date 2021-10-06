import 'package:boszhan_delivery_app/utills/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class OrdersProvider {
  String API_URL = AppConstants.baseUrl;

  Future<Map<String, dynamic>> getDeliveryOrders() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(API_URL + 'api/delivery-order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : "Bearer $token"
      }
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    }
    else {
      final result = {'data' : 'Error'};
      return result;
    }
  }
}
