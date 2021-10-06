import 'package:boszhan_delivery_app/components/order_card.dart';
import 'package:boszhan_delivery_app/models/order.dart';
import 'package:boszhan_delivery_app/services/orders_api_provider.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CurrentOrdersPage extends StatefulWidget {

  @override
  _CurrentOrdersPageState createState() => _CurrentOrdersPageState();
}

class _CurrentOrdersPageState extends State<CurrentOrdersPage> {

  List<Order> orders = <Order>[];
  int orderCount = 0;

  @override
  void initState() {
    getOrders();
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: buildAppBar('Текущие заказы')
        ),
        body: ListView.separated(itemCount: orderCount,
            itemBuilder: (BuildContext context, int index) => OrderCard(orders[index]),
            separatorBuilder: (context, index){
              return Divider();
            }
          ),
        )
    );
  }

  void getOrders() async {
    Future<Map<String, dynamic>> response = OrdersProvider().getDeliveryOrders();
    Map<String, dynamic> responseData = {};

    response.then((value) {
      setState(() {
        responseData = value;
      });
    }).whenComplete((){
      if (responseData['data'] != 'Error'){
        List<Order> list = <Order>[];

        for (Map<String, dynamic> i in responseData['data']){
          Order order = Order.fromJson(i);
          list.add(order);
        }

        setState(() {
          orders = list;
          orderCount = list.length;
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong.", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }
}