import 'dart:convert';

import 'package:boszhan_delivery_app/utils/const.dart';
import 'package:http/http.dart' as http;

class VersionCheckProvider {
  String API_URL = AppConstants.baseUrl;

  Future<Map<String, dynamic>> check() async {
    final response = await http
        .get(Uri.parse(API_URL + 'api/version'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    // print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      final result = {'data': 'Error'};
      return result;
    }
  }
}
