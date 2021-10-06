import 'package:boszhan_delivery_app/components/product_card.dart';
import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:boszhan_delivery_app/widgets/elevated_button_icon.dart';
import 'package:flutter/material.dart';

class HistoryOrderInfoPage extends StatefulWidget {
  const HistoryOrderInfoPage(this.baskets);
  final List<Basket> baskets;

  @override
  _HistoryOrderInfoPageState createState() => _HistoryOrderInfoPageState();
}

class _HistoryOrderInfoPageState extends State<HistoryOrderInfoPage> {

  List<String> products = ['asdf','asdf'];

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
              child: buildAppBar('Просмотр заказа')
          ),
          body: ListView.separated(itemCount: products.length,
            itemBuilder: (BuildContext context, int index) => index % 2 == 0 ? ProductCard(widget.baskets[index]) : Ink(color: Colors.red[50], child: ProductCard(widget.baskets[index])),
            separatorBuilder: (context, index){
              return const Divider();
            }
          )
        )
    );
  }

  void finishOrder(){
    print('Finish');
  }

  void cancelOrder(){
    print('Cancel');
  }

  void addToOrder(){
    print('Add');
  }
}