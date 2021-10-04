import 'package:boszhan_delivery_app/components/order_card.dart';
import 'package:flutter/material.dart';

class CurrentOrdersPage extends StatefulWidget {
  // CurrentOrdersPage(this.product);
  // final Product product;

  @override
  _CurrentOrdersPageState createState() => _CurrentOrdersPageState();
}

class _CurrentOrdersPageState extends State<CurrentOrdersPage> {

  List<String> orders = ['asdf','asdf'];

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
          title: Text('Текущие заказы', style: TextStyle(color: Colors.white, fontSize: 18)),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          shadowColor: Colors.white,
          bottomOpacity: 1,
          iconTheme: IconThemeData(color: Colors.white)
        ),
        body: ListView.separated(itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) => OrderCard(),
            separatorBuilder: (context, index){
              return Divider();
            }
          ),
        )
    );
  }
}