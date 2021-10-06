import 'package:boszhan_delivery_app/models/basket.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  const ProductCard(this.basket);
  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.location_pin, color: Colors.white,)
      ),
      title: Text(basket.name, style: TextStyle(fontSize: 20),),
      subtitle: Row(
        children: [
          Text('Количество: ' + basket.count.toString(), style: TextStyle(fontSize: 18)),
          Spacer(),
          Text('Сумма:  ' + basket.price.toString() + ' ₸', style: TextStyle(fontSize: 18))
        ],
      ),
      onTap: (){}
    );
  }
}