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

  List<int> listOfCodeInts = [28, 46, 27, 116, 6, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
    31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
    71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
    109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
    141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172,
    173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204,
    205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236,
    237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255];

  List<int> listOfChars = [];

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

    var list = [];
    for (int i = 221; i < 255; i++) list.add(i);
    print(list);

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
    result.msg == 'Success' ? statusMSG = 'Распечатано успешно!' : statusMSG = 'Ошибка распечатки: ' + result.msg;
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
    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    final generator = Generator(PaperSize.mm58, profile);
    List<int> ticket = [];
    ticket += generator.setGlobalCodeTable('CP1252');
    ticket += generator.printCodeTable(codeTable: 'CP1252');
    // var result = await CapabilityProfile.getAvailableProfiles();
    // print(result);

    // TODO: Adding data to ticket.
    // var tst = utf8.encode('ывафываdhjdfgdfghdfgh');
    // ticket+= generator.rawBytes(tst);
    // ticket += [28];
        // Utf8Encoder().convert('ывапыва');
    // ticket += generator.text('АБВ!', styles: PosStyles(codeTable: 'CP1252'));
    ticket += generator.text('Special 2: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    ticket += generator.feed(1);
    ticket += generator.cut();
    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }

}