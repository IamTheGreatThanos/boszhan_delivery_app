import 'dart:convert';
import 'dart:typed_data';

import 'package:boszhan_delivery_app/models/history_basket.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;

import 'package:image/image.dart';

class Print extends StatefulWidget {
  final List<HistoryBasket> data;
  Print(this.data);
  @override
  _PrintState createState() => _PrintState();
}

class _PrintState extends State<Print> {

  final PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String? _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((val) {
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() => _devicesMsg = 'Bluetooth отключен!');
        }
      });
    } else {
      initPrinter();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Печать')),
        backgroundColor: Colors.red,
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: const Icon(Icons.print),
            title: Text(_devices[i].name.toString()),
            subtitle: Text(_devices[i].address.toString()),
            onTap: () {
              _startPrint(_devices[i]);
            },
          );
        },
      ),
    );
  }

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final result = await _printerManager.printTicket(await getRealTicket());
    String statusMSG = '';
    result.msg == 'Success' ? statusMSG = 'Распечатано успешно!' : statusMSG = 'Ошибка распечатки!';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(statusMSG),
        actions: [
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            child: const Text('OK'),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }

  Future<List<int>> testTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> ticket = [];

    ticket += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');

    ticket += generator.text('Bold text', styles: const PosStyles(bold: true));
    ticket += generator.text('Reverse text', styles: const PosStyles(reverse: true));
    ticket += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    ticket += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
    ticket += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
    ticket += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    ticket += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    ticket += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    // Image assets
    // final ByteData data = await rootBundle.load('assets/images/logo.png');
    // final Uint8List bytes = data.buffer.asUint8List();
    // final Image? image = decodeImage(bytes);
    // // Image thumbnail = copyResize(image!, width: 200);
    // ticket += generator.image(image!);

    ticket += generator.feed(1);
    ticket += generator.cut();
    return ticket;
  }

  Future<List<int>> testTicket2() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> ticket = [];
    int amount = 0;

    // for (HistoryBasket basket in widget.data) {
    //   List<int> list = (basket.name + '  ---  ' + basket.price.toString() + ' тг   ---   ' + basket.count.toString() + ' шт.').codeUnits;
    //   Uint8List bytes = Uint8List.fromList(list);
    //   ticket += generator.textEncoded(bytes);
    //   amount += basket.price;
    // }

    // ticket += generator.text('Итого: ', styles: const PosStyles(bold: true, align: PosAlign.left));
    // ticket += generator.text(amount.toString() + ' тг', styles: const PosStyles(bold: true, align: PosAlign.right));

    ticket += generator.feed(1);
    ticket += generator.cut();
    return ticket;
  }

  Future<List<int>> getRealTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> ticket = [];
    // TODO: Adding data to ticket.



    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }

}