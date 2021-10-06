import 'package:boszhan_delivery_app/utills/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HistoryProvider {
  String API_URL = AppConstants.baseUrl;

  Future<dynamic> getDeliveredOrders() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
        Uri.parse(API_URL + 'api/delivery-order/get-delivered-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : "Bearer $token"
        }
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return result['data'];
    }
    else {
      return 'Error';
    }
  }
}
