import 'package:boszhan_delivery_app/utils/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VersionCheckProvider{
  String API_URL = AppConstants.baseUrl;

  Future<Map<String, dynamic>> check() async {
    final response = await http.get(
      Uri.parse(API_URL + 'api/version'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    // print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    }
    else {
      final result = {'data' : 'Error'};
      return result;
    }
  }

  // Future<String> downloadAPK() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //
  //   final response = await http.post(
  //     Uri.parse(API_URL + 'api/device-token'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization' : "Bearer $token"
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "device_token": '',
  //     }),
  //   );
  //
  //   // print(response.body);
  //
  //   if (response.statusCode == 200) {
  //     return 'Success';
  //   }
  //   else {
  //     return 'Error';
  //   }
  // }
}