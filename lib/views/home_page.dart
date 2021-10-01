import 'dart:io';
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
          title: Text('Доставка', style: TextStyle(color: Colors.white, fontSize: 18)),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          bottomOpacity: 1,
          iconTheme: IconThemeData(color: Colors.black)
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
              Image.asset("assets/images/logo.png"),
              ElevatedButton(
                child: const Text("Rock & Roll"),
                onPressed: (){
                  print("Clicked!");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                ),
              )
            ],
          )
          ),
        )
    );
  }
}