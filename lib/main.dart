import 'package:boszhan_delivery_app/views/authorizationPage/authorization_page.dart';
import 'package:boszhan_delivery_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // getRegistrationStatus() == false ? HomePage() :
      const LoginPage()
    );
  }

  Future<bool> getRegistrationStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isRegistered') == true) return true;
    return false;
  }

}
