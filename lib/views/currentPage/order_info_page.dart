import 'package:boszhan_delivery_app/components/product_card.dart';
import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:boszhan_delivery_app/models/order.dart';
import 'package:boszhan_delivery_app/services/change_status_api_provider.dart';
import 'package:boszhan_delivery_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage(this.order);
  final Order order;

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {

  TextEditingController commentController = TextEditingController();
  Object? _value = 1;
  bool isButtonDisabled = false;

  @override
  void initState() {
    print(widget.order.status);
    widget.order.status != 2 ? isButtonDisabled = true : isButtonDisabled = false;
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
          preferredSize: const Size.fromHeight(60.0),
          child: buildAppBar('Выдача заказа')
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              child: ListView.separated(itemCount: widget.order.basket.length,
                  itemBuilder: (BuildContext context, int index) => widget.order.basket[index].type == 0 ? ProductCard(widget.order.basket[index]) : Ink(color: Colors.red[50], child: ProductCard(widget.order.basket[index])),
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
                      onPressed: isButtonDisabled ? null : displayPaymentTypeDialog,
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
                      onPressed: isButtonDisabled ? null : displayTextInputDialog,
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
                      label: const Text('Изменить'),
                      onPressed: isButtonDisabled ? null : addToOrder,
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
              child: Text('Общая сумма заказа: ' + widget.order.totalCost.toString() + ' ₸', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Общее количество заказов: ' + widget.order.basket.length.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      )
    );
  }


  void finishOrder() async{
    String status = '';
    ChangeStatusProvider().changeStatus(widget.order.orderId.toString(), 5).then((value) => status = value).whenComplete((){
      if (status == 'Success'){
        Navigator.pop(context);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong.", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }

  void cancelOrder() async{
    String status = '';
    ChangeStatusProvider().changeStatus(widget.order.orderId.toString(), 4).then((value) => status = value).whenComplete((){
      if (status == 'Success'){
        Navigator.pop(context);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong.", style: TextStyle(fontSize: 20)),
        ));
      }
    });
  }

  void addToOrder(){
    print('Add');
  }

  Future<void> displayTextInputDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Комментарий'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(hintText: "Введите причину"),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Отмена'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('Сохранить'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> displayPaymentTypeDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Выберите способ оплаты'),
            content: SizedBox(
              height: 60,
              child: DropdownButton(
                value: _value,
                items: const [
                  DropdownMenuItem(
                    child: Text("Наличный"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Без наличный"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("Рассрочка платежа"),
                    value: 3,
                  )
                ],
                onChanged: (value){
                  setState((){
                    _value = value;
                    Navigator.pop(context);
                    displayPaymentTypeDialog();
                  });
                },
                hint:const Text("Select item")
              )
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Отмена'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Сохранить'),
                onPressed: () {
                  setState(() {
                    finishOrder();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        }
    );
  }

}