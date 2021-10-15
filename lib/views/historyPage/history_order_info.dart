import 'package:boszhan_delivery_app/components/history_product_card.dart';
import 'package:boszhan_delivery_app/models/history_order.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';

class HistoryOrderInfoPage extends StatefulWidget {
  const HistoryOrderInfoPage(this.order);
  final HistoryOrder order;

  @override
  _HistoryOrderInfoPageState createState() => _HistoryOrderInfoPageState();
}

class _HistoryOrderInfoPageState extends State<HistoryOrderInfoPage> {

  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  BluetoothManager bluetoothManager = BluetoothManager.instance;
  List<PrinterBluetooth> _devices = [];

  @override
  void initState() {
    initPrinter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Выполненные заказы', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: <Widget>[
          widget.order.status == 3 ? Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                toPrint();
              },
              child: const Icon(
                  Icons.print
              ),
            )
          ) : const SizedBox(),
        ],
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        shadowColor: Colors.white,
        bottomOpacity: 1,
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: ListView.separated(itemCount: widget.order.basket.length,
        itemBuilder: (BuildContext context, int index) => widget.order.basket[index].type == 0 ? HistoryProductCard(widget.order.basket[index]) : Ink(color: Colors.red[50], child: HistoryProductCard(widget.order.basket[index])),
        separatorBuilder: (context, index){
          return const Divider();
        }
      )
    );
  }

  void toPrint(){
    print('Printing');
    if (_devices.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Нет подключенных принтеров!", style: TextStyle(fontSize: 20)),
      ));
    }
  }

  void initPrinter() async {
    _printerManager.startScan(const Duration(seconds: 5));
    _printerManager.scanResults.listen((event) {
      if (!mounted) return;
      setState(() => _devices = event);

      if (_devices.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Нет подключенных принтеров!", style: TextStyle(fontSize: 20)),
        ));
      }

    });
    print(_devices);
  }

}