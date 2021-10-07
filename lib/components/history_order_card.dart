import 'package:boszhan_delivery_app/models/history_order.dart';
import 'package:boszhan_delivery_app/views/historyPage/history_order_info.dart';
import 'package:flutter/material.dart';

class HistoryOrderCard extends StatelessWidget{
  const HistoryOrderCard(this.order);
  final HistoryOrder order;

  @override
  Widget build(BuildContext context) {
    // return _buildTiles(entry);
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.location_pin, color: Colors.white,)
      ),
      title: Text('Название: ' + order.name, style: const TextStyle(fontSize: 20)),
      subtitle: Text('Адрес: ' + order.address.latitude, style: const TextStyle(fontSize: 20)),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryOrderInfoPage(order.basket)));
      }
    );
  }
}