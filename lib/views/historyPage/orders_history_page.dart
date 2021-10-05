import 'package:boszhan_delivery_app/components/history_order_card.dart';
import 'package:boszhan_delivery_app/components/order_card.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class OrdersHistoryPage extends StatefulWidget {
  // OrdersHistoryPage(this.product);
  // final Product product;

  @override
  _OrdersHistoryPageState createState() => _OrdersHistoryPageState();
}

class _OrdersHistoryPageState extends State<OrdersHistoryPage> {

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
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: buildAppBar('Выполненные заказы')
          ),
          body: ListView.separated(itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) => HistoryOrderCard(),
              separatorBuilder: (context, index){
                return Divider();
              }
          ),
        )
    );
  }
}