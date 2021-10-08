import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:boszhan_delivery_app/utills/const.dart';
import 'package:flutter/material.dart';

class ChangeableProductCard extends StatefulWidget {
  const ChangeableProductCard(this.basket, this.indexOfTile);
  final Basket basket;
  final int indexOfTile;

  @override
  State<StatefulWidget> createState() {
    return new ChangeableProductCardState();
  }
}

class ChangeableProductCardState extends State<ChangeableProductCard> {
  TextEditingController countController = TextEditingController();

  @override
  void initState() {
    countController.text = widget.basket.count.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.location_pin, color: Colors.white,)
      ),
      title: Text(widget.basket.name, style: const TextStyle(fontSize: 20)),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Text('Сумма:  ' + widget.basket.price.toString() + ' ₸', style: TextStyle(fontSize: 18)),
          Spacer(),
          SizedBox(
            width: 60,
            child: TextFormField(
              controller: countController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {

              }
            ),
          ),
          Text((widget.basket.measureId == 1 ? ' шт' : ' кг'), style: const TextStyle(fontSize: 20)),
        ]),
      ),
    );
  }
}