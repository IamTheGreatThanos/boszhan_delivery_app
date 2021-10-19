import 'dart:io';
import 'package:boszhan_delivery_app/services/version_check_provider.dart';
import 'package:boszhan_delivery_app/utils/const.dart';
import 'package:boszhan_delivery_app/views/authorizationPage/authorization_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class CheckingVersionPage extends StatefulWidget {

  @override
  _CheckingVersionPageState createState() => _CheckingVersionPageState();
}

class _CheckingVersionPageState extends State<CheckingVersionPage> {

  bool isNotValidVersion = false;

  @override
  void initState() {
    checking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text('Проверка',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              automaticallyImplyLeading: true,
              backgroundColor: Colors.red,
              bottomOpacity: 1,
              iconTheme: IconThemeData(color: Colors.white)
          ),
          body: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/images/logo.png",
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                        'Версия: 1.0',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)
                    ),
                  ),
                  isNotValidVersion ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: ElevatedButton(
                        child: const Text("СКАЧАТЬ"),
                        onPressed: () {
                          downloadAction();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 20),
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ) : Container()
                ],
              )
          ),
        )
    );
  }

  void downloadAction() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      launch(AppConstants.baseUrl + 'api/version/download?application_type=2');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      launch(AppConstants.baseUrl + 'api/version/download?application_type=2');
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Соединение с интернетом отсутствует.",
            style: TextStyle(fontSize: 20)),
      ));
    }
  }

  void checking() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        sendRequest();
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        sendRequest();
      });
    }
    else{
      Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LoginPage(),
      ), (route) => false);
    }

  }

  void sendRequest(){
    Future<Map<String, dynamic>> response = VersionCheckProvider().check();
    Map<String, dynamic> responseData = {};

    response.then((value) {
      setState(() {
        responseData = value;
      });
    }).whenComplete(() {
      if (responseData['data'] != 'Error' && responseData['data'][1]['version'] == '1') {
        Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginPage(),
        ), (route) => false);
      }
      else {
        setState(() {
          isNotValidVersion = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Скачайте актуальную версию", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }
}