import 'dart:convert';

import 'package:boszhan_delivery_app/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider {
  String API_URL = AppConstants.baseUrl;

  Future<Map<String, dynamic>> getDeliveredOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
        Uri.parse(API_URL + 'api/delivery-order/get-delivered-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['data'] != null) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      final result = {'data': 'Error'};
      return result;
    }
  }
}
