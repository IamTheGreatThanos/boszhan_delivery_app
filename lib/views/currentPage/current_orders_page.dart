import 'package:boszhan_delivery_app/components/order_card.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: buildAppBar('Текущие заказы')
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