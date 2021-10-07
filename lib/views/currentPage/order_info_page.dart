import 'package:boszhan_delivery_app/components/product_card.dart';
import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage(this.baskets, this.totalCost);
  final List<Basket> baskets;
  final double totalCost;

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {

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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: buildAppBar('Выдача заказа')
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              child: ListView.separated(itemCount: widget.baskets.length,
                  itemBuilder: (BuildContext context, int index) => widget.baskets[index].type == 0 ? ProductCard(widget.baskets[index]) : Ink(color: Colors.red[50], child: ProductCard(widget.baskets[index])),
                  separatorBuilder: (context, index){
                    return const Divider();
                  }
                ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.width*0.1,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.assignment_rounded, color: Colors.white),
                      label: const Text('Выполнить'),
                      onPressed: () {
                        finishOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: const TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.width*0.1,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cancel, color: Colors.white),
                      label: const Text('Отказ'),
                      onPressed: () {
                        cancelOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        textStyle: const TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.width*0.1,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_circle, color: Colors.white),
                      label: const Text('Добавить'),
                      onPressed: () {
                        addToOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: const TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Общая сумма заказа: ' + widget.totalCost.toString() + ' ₸', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Общее количество заказов: ' + widget.baskets.length.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
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