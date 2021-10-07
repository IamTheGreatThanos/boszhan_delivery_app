import 'package:boszhan_delivery_app/components/history_product_card.dart';
import 'package:boszhan_delivery_app/models/history_basket.dart';
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
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('Выполненные заказы', style: TextStyle(color: Colors.white, fontSize: 20)),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    toPrint();
                  },
                  child: const Icon(
                      Icons.print
                  ),
                )
            ),
          ],
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          shadowColor: Colors.white,
          bottomOpacity: 1,
          iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: ListView.separated(itemCount: widget.baskets.length,
        itemBuilder: (BuildContext context, int index) => widget.baskets[index].type == 0 ? HistoryProductCard(widget.baskets[index]) : Ink(color: Colors.red[50], child: HistoryProductCard(widget.baskets[index])),
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