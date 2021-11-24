import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:boszhan_delivery_app/utils/const.dart';
import 'package:flutter/material.dart';

class ChangeableProductCard extends StatefulWidget {
  const ChangeableProductCard(this.basket, this.indexOfTile);
  final Basket basket;
  final int indexOfTile;

  @override
  State<StatefulWidget> createState() {
    return ChangeableProductCardState();
  }
}

class ChangeableProductCardState extends State<ChangeableProductCard> {
  TextEditingController countController = TextEditingController();

  Color color = Colors.white;

  @override
  void initState() {
    countController.text = widget.basket.count.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.basket.isChecked == true ? Colors.green[200]! : color,
      leading: const CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          )),
      title: Text(widget.basket.name, style: const TextStyle(fontSize: 20)),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Text('Сумма:  ' + widget.basket.price.toString() + ' ₸',
              style: TextStyle(fontSize: 18)),
          Spacer(),
          SizedBox(
            width: 60,
            child: TextFormField(
                controller: countController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 18),
                onChanged: (value) {
                  AppConstants.index = widget.indexOfTile;
                  AppConstants.value = value;
                  MyNotification().dispatch(context);
                }),
          ),
          Text((widget.basket.measureId == 1 ? ' шт' : ' кг'),
              style: const TextStyle(fontSize: 20)),
          TextButton(
            onPressed: () {
              setState(() {
                widget.basket.isChecked = !widget.basket.isChecked;
              });
            },
            child: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          )
        ]),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification();
}
