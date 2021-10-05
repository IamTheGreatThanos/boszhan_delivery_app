import 'package:boszhan_delivery_app/views/currentPage/order_info_page.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget{
  const OrderCard();
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
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0))
          ),
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Что вы хотите сделать?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 400,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.open_in_full, color: Colors.white),
                        label: const Text("ОТКРЫТЬ ЗАКАЗ"),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderInfoPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 400,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.location_pin, color: Colors.white),
                        label: const Text("ПОКАЗАТЬ НА КАРТЕ"),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderInfoPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 400,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.print, color: Colors.white),
                        label: const Text("ПЕЧАТЬ"),
                        onPressed: (){
                          print('Printing');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(color: Colors.white,fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}