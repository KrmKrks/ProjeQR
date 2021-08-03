//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projeqr/pages/qr_generate.dart';

class ScanQR extends StatefulWidget {
  //ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  late double height, width;
  String qrString = 'Tarama Yapılmadı';

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Kodu Tara'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            qrString,
            style: TextStyle(color: Colors.blue, fontSize: 30),
          ),
          ElevatedButton(
            onPressed: scan, //TIKLANAN YER BURASI
            child: Text('QR Kodu Tara'),
          ),
          SizedBox(width: width),
        ],
      ),
    );
  }

  Future<void> scan() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Cencel', true, ScanMode.QR);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QrGenerator(scanResult: ScanMode.values as String),
        ),
      );
    } catch (e) {
      setState(() {
        qrString = 'QR okunmadı';
      });
    }
  }
}
