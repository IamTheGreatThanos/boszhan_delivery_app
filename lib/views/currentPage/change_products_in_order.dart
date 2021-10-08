import 'package:boszhan_delivery_app/components/changeable_product_card.dart';
import 'package:boszhan_delivery_app/components/product_card.dart';
import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:boszhan_delivery_app/models/order.dart';
import 'package:boszhan_delivery_app/services/orders_api_provider.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class ChangeProductsInOrderPage extends StatefulWidget {
  const ChangeProductsInOrderPage(this.order);
  final Order order;

  @override
  _ChangeProductsInOrderPageState createState() => _ChangeProductsInOrderPageState();
}

class _ChangeProductsInOrderPageState extends State<ChangeProductsInOrderPage> {

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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: buildAppBar('Выдача заказа')
          ),
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: ListView.separated(
                    itemCount: widget.order.basket.length,
                    itemBuilder: (BuildContext context, int index) =>
                    widget.order.basket[index].type == 0 ? InkWell(child: ChangeableProductCard(widget.order.basket[index], index), onTap: () => displayAlertDialog(widget.order.basket[index].name, index))
                        : Ink(color: Colors.red[50], child: InkWell(child: ChangeableProductCard(widget.order.basket[index], index), onTap: () => displayAlertDialog(widget.order.basket[index].name, index))),
                    separatorBuilder: (context, index){
                      return const Divider();
                    },
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.width*0.1,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.assignment_rounded, color: Colors.white),
                          label: const Text('Отправить на сервер'),
                          onPressed: () {

                            // saveProducts();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: const TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Пока вы не отправите заказ на сервер, изменения не сохранятся.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        )
    );
  }

  void saveProducts(List<Basket> list) async{
    String status = '';
    OrdersProvider().changeBasket(widget.order.orderId.toString(), list).then((value) => status = value).whenComplete((){
      if (status == 'Success'){
        Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomePage(),
        ), (route) => false);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong.", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }

  Future<void> displayAlertDialog(String name, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Внимание'),
            content:
            Text('Удалить продукт ' + name + ' из заказа?'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Нет'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Да'),
                onPressed: () {
                  deleteProductAction(index);
                  Navigator.pop(context);
                }
              ),
          ]);
        }
    );
  }

  void deleteProductAction(int index){
    setState(() {
      widget.order.basket.removeAt(index);
    });
  }

}

