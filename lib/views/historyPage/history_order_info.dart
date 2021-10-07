import 'package:boszhan_delivery_app/components/history_product_card.dart';
import 'package:boszhan_delivery_app/models/history_basket.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HistoryOrderInfoPage extends StatefulWidget {
  const HistoryOrderInfoPage(this.baskets);
  final List<HistoryBasket> baskets;

  @override
  _HistoryOrderInfoPageState createState() => _HistoryOrderInfoPageState();
}

class _HistoryOrderInfoPageState extends State<HistoryOrderInfoPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: buildAppBar('Просмотр заказа')
      ),
      body: ListView.separated(itemCount: widget.baskets.length,
        itemBuilder: (BuildContext context, int index) => index % 2 == 0 ? HistoryProductCard(widget.baskets[index]) : Ink(color: Colors.red[50], child: HistoryProductCard(widget.baskets[index])),
        separatorBuilder: (context, index){
          return const Divider();
        }
      )
    );
  }
}