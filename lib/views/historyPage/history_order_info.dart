import 'package:boszhan_delivery_app/components/history_product_card.dart';
import 'package:boszhan_delivery_app/models/history_order.dart';
import 'package:flutter/material.dart';

class HistoryOrderInfoPage extends StatefulWidget {
  const HistoryOrderInfoPage(this.order);
  final HistoryOrder order;

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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Выполненные заказы', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: <Widget>[
          widget.order.status == 3 ? Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                toPrint();
              },
              child: const Icon(
                  Icons.print
              ),
            )
          ) : const SizedBox(),
        ],
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        shadowColor: Colors.white,
        bottomOpacity: 1,
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: ListView.separated(itemCount: widget.order.basket.length,
        itemBuilder: (BuildContext context, int index) => widget.order.basket[index].type == 0 ? HistoryProductCard(widget.order.basket[index]) : Ink(color: Colors.red[50], child: HistoryProductCard(widget.order.basket[index])),
        separatorBuilder: (context, index){
          return const Divider();
        }
      )
    );
  }

  void toPrint(){
    print('Printing');
  }
}