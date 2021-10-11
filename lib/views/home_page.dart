import 'dart:convert';
import 'package:boszhan_delivery_app/models/history_order.dart';
import 'package:boszhan_delivery_app/services/history_api_provider.dart';
import 'package:boszhan_delivery_app/services/orders_api_provider.dart';
import 'package:boszhan_delivery_app/views/currentPage/current_orders_page.dart';
import 'package:boszhan_delivery_app/views/historyPage/orders_history_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  // HomePage(this.product);
  // final Product product;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    downloadAction();
    super.initState();

    // flutterLocalNotificationsPlugin.show(0, "Testing", "Hello user?",
    //   NotificationDetails(
    //       android: AndroidNotificationDetails(channel.id, channel.name,
    //           importance: Importance.high,
    //           color: Colors.blue,
    //           playSound: true,
    //           icon: '@mipmap/ic_launcher')
    //   )
    // );
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
          title: Text('Доставка', style: TextStyle(color: Colors.white, fontSize: 20)),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          bottomOpacity: 1,
          iconTheme: IconThemeData(color: Colors.white)
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Имя водителя: Водитель №1.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Text(
                  'Версия: 1.0.0',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                width: MediaQuery.of(context).size.width*0.5
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: ElevatedButton(
                    child: const Text("ТЕКУЩИЕ"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentOrdersPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: ElevatedButton(
                    child: const Text("ВЫПОЛНЕННЫЕ"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersHistoryPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: ElevatedButton(
                    child: const Text("ЗАГРУЗИТЬ"),
                    onPressed: (){
                      downloadAction();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          )
          ),
        )
    );
  }

  void downloadAction() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      downloadProcess();
      downloadProcessForHistory();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      downloadProcess();
      downloadProcessForHistory();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Соединение с интернетом отсутствует.", style: TextStyle(fontSize: 20)),
      ));
    }
  }

  void downloadProcess() async{
    Future<Map<String, dynamic>> response = OrdersProvider().getDeliveryOrders();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> responseData = {};

    response.then((value) {
      setState(() {
        responseData = value;
      });
    }).whenComplete((){
      if (responseData['data'] != 'Error'){
        if (responseData['data'] != null){
          var jsonString = jsonEncode(responseData['data']);
          prefs.setString('DownloadedData', jsonString);
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong.", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }

  void downloadProcessForHistory() async{
    Future<Map<String, dynamic>> response = HistoryProvider().getDeliveredOrders();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> responseData = {};

    response.then((value) {
      setState(() {
        responseData = value;
      });
    }).whenComplete((){
      if (responseData['data'] != 'Error'){
        if (responseData['data'] != null){
          List<HistoryOrder> list = <HistoryOrder>[];

          for (Map<String, dynamic> i in responseData['data']){
            HistoryOrder order = HistoryOrder.fromJson(i);
            list.add(order);
          }

          var jsonString = jsonEncode(responseData['data']);
          prefs.setString('DownloadedHistoryData', jsonString);
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong.", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }
}