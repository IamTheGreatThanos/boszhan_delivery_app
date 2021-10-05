import 'dart:io';
import 'package:boszhan_delivery_app/views/currentPage/current_orders_page.dart';
import 'package:boszhan_delivery_app/views/historyPage/orders_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  // HomePage(this.product);
  // final Product product;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
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
                      print("Clicked!");
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
}