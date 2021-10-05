import 'package:boszhan_delivery_app/components/product_card.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:boszhan_delivery_app/widgets/elevated_button_icon.dart';
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: buildAppBar('Выдача заказа')
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.75,
              child: ListView.separated(itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) => index % 2 == 0 ? const ProductCard() : Ink(color: Colors.red[50], child: const ProductCard()),
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
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Общая сумма заказа: 20078', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Общее количество заказов: 25', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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