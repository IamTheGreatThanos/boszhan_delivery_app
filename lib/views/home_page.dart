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
        // appBar: AppBar(
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text('Title', style: TextStyle(color: Colors.black, fontSize: 18)),
        //   automaticallyImplyLeading: true,
        //   backgroundColor: Colors.white,
        //   shadowColor: Colors.white,
        //   bottomOpacity: 1,
        //   iconTheme: IconThemeData(color: Colors.black)
        // ),
        body: Container(
          child: Center(child:Text('Hello Boszhan!'))
          ),
        )
    );
  }
}