import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  const ProductCard();
  // final Entry entry;

  @override
  Widget build(BuildContext context) {
    // return _buildTiles(entry);
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.location_pin, color: Colors.white,)
      ),
      title: const Text('Сосиска к ужину'),
      subtitle: Row(
        children: const [
          Text('Количество: 1'),
          Spacer(),
          Text('Сумма: 380.0 ')
        ],
      ),
      onTap: (){}
    );
  }
}