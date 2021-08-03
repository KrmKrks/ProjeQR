//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
<<<<<<< HEAD
import 'package:projeqr/pages/qr_generate.dart';
=======
import 'package:projeqr/pages/qr_result_page.dart';
>>>>>>> 4572e48884b6e2aefb013ddf9b05fa20abd02d7d

class ScanQR extends StatefulWidget {
  //ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  late double height, width;

  String qrCode = '';

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
<<<<<<< HEAD
            qrString,
=======
            'Qr Tara',
>>>>>>> 4572e48884b6e2aefb013ddf9b05fa20abd02d7d
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
<<<<<<< HEAD
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
=======
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#2A99CF', 'Cencel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrResult(scanResult: qrCode),
          ),
        );
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
>>>>>>> 4572e48884b6e2aefb013ddf9b05fa20abd02d7d
    }
  }
}
