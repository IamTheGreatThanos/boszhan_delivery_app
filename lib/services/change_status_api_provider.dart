import 'package:boszhan_delivery_app/utills/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeStatusProvider{
  String API_URL = AppConstants.baseUrl;

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
    print(response.statusCode);

    if (response.statusCode == 200) {
      return 'Success';
    }
    else {
      return 'Error';
    }
  }
}