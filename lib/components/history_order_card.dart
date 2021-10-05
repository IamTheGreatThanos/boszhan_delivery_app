import 'package:boszhan_delivery_app/views/currentPage/order_info_page.dart';
import 'package:boszhan_delivery_app/views/historyPage/history_order_info.dart';
import 'package:flutter/material.dart';

class HistoryOrderCard extends StatelessWidget{
  const HistoryOrderCard();
  // final Entry entry;

  @override
  Widget build(BuildContext context) {
    // return _buildTiles(entry);
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.location_pin, color: Colors.white,)
      ),
      title: const Text("Название: Чудо,    Адрес: Жаскент 14/1", style: TextStyle(fontSize: 20)),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryOrderInfoPage()));
      }
    );
  }
}