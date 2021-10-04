import 'package:boszhan_delivery_app/components/product_card.dart';
import 'package:flutter/material.dart';

class OrderInfoPage extends StatefulWidget {
  // OrderInfoPage(this.product);
  // final Product product;

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {

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
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Выдача заказа', style: TextStyle(color: Colors.white, fontSize: 18)),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          shadowColor: Colors.white,
          bottomOpacity: 1,
          iconTheme: IconThemeData(color: Colors.white)
        ),
        body: ListView.separated(itemCount: products.length,
            itemBuilder: (BuildContext context, int index) => index % 2 == 0 ? const ProductCard() : Ink(color: Colors.red[50], child: const ProductCard()),
            separatorBuilder: (context, index){
              return const Divider();
            }
          ),
        )
    );
  }
}