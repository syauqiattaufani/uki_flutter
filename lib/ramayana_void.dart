import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:uki_flutter/ramayana_home.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:uki_flutter/ramayana_print_%20harga.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class RamayanaVoid extends StatefulWidget {
  const RamayanaVoid({super.key});

  @override
  State<RamayanaVoid> createState() => _RamayanaVoidState();
}

class _RamayanaVoidState extends State<RamayanaVoid> {
  TextEditingController _editingController = TextEditingController();
  String _scanBarcode = '';

  Future<void> startBarcodeScanStream2() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  // List<ScanResult>? scanResult;

  @override
  void initState() {
    super.initState();
    // findDevices();
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Void',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          backgroundColor: Color.fromARGB(250, 236, 7, 7),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.print),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Harga();
                  }));
                }
            )
          ],
          elevation: 20,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 18),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RamayanaHome();
                }));
              })),

      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 350, 30, 0),
                child: Center(
                  child: QrImage(
                    data: '$_scanBarcode',
                    version: QrVersions.auto,
                    size: 250,
                  ),
                ),
              )
            ],
          ),

          Container(
            child: Text(
              'Form Void',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            margin: EdgeInsets.only(left: 11, top: 15),
            height: 50,
            width: 450,
            padding: EdgeInsets.only(top: 14, bottom: 14, left: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 239, 237, 237),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: ListView(
              children: <Widget>[
                Text(
                  'Code',
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
                TextField(
                  controller: _editingController..text = '$_scanBarcode',
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 180, left: 0, right: 0),
            alignment: Alignment.center,
            color: Color.fromARGB(255, 255, 17, 17),
            height: 50,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _scanBarcode = _editingController.text;
                });
              },
              child: Text(
                'GENERATE QR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),

          Container(
            color: Color.fromARGB(255, 239, 237, 237),
            width: 500,
            height: 50,
            margin: EdgeInsets.fromLTRB(10, 260,10, 0),
            child:
            Container(
              child:
              TextButton(
                onPressed: () => scanBarcode(),
                child:
                Text(
                  'Scan Barcode', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),

        ],
      ),
    );
  }
}
