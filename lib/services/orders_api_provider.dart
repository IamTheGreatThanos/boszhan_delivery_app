import 'package:boszhan_delivery_app/models/basket.dart';
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

    if (response.statusCode == 200 && jsonDecode(response.body)['data'] != null) {
      final result = jsonDecode(response.body);
      return result['data'];
    }
    else {
      final result = {'data' : 'Error'};
      return result;
    }
  }


  Future<String> changeStatus(String id, int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(API_URL + 'api/delivery-order/' + id + '/change-status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "status": status,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return 'Success';
    }
    else {
      return 'Error';
    }
  }

  Future<String> reject(String id, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(API_URL + 'api/delivery-order/' + id + '/reject'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "comment": comment,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return 'Success';
    }
    else {
      return 'Error';
    }
  }


  Future<String> changePaymentType(String id, int type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(API_URL + 'api/delivery-order/' + id + '/change-payment-type'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "payment_type": type,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return 'Success';
    }
    else {
      return 'Error';
    }
  }


  Future<String> changeBasket(String id, List<Basket> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(API_URL + 'api/delivery-order/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "order_id": id,
        "basket" : list
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return 'Success';
    }
    else {
      return 'Error';
    }
  }
}
