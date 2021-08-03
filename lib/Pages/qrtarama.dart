//import 'dart:html';
//import 'dart:ui';



//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:barcode_scan/barcode_scan.dart';

/*class Scan extends StatefulWidget {

  
  
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  String result = 'Heyoo';

  Future ScanQr() async{

    try{
      String qrResult = (await BarcodeScanner.scan()) as String; 
      setState(() {
        result = qrResult;
      });
      
    } on PlatformException catch (ex) {
      if(ex.code = BarcodeScanner.cameraAccessDenied != null){
        setState(() {
          result = 'Camera Permission was Denied';
        });
        
      }else{
        setState(() {
          result = 'Bilinmeyen Hata $ex';
        });
      }
    } on FormatException{
      setState(() {
        result = 'Geri Tusuna Bastiniz';
      });
    } catch(ex){
      setState(() {
          result = 'Bilinmeyen Hata $ex';
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR SCANNER'),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      
    );
  }
}*/


/*class QRscan extends StatefulWidget {
  
  @override
  _QRscanState createState() => _QRscanState();
}

class _QRscanState extends State<QRscan> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

@override
void dispose(){
  controller?.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
        ],
      ),
    ),
  );
   
   Widget buildQrView(BuildContext context) => QRView(
     key: qrKey,
     onQRViewCreated: onQRViewCreated,
   );

   void onQRViewCreated(QRViewController controller){
     setState(() => this.controller = controller);
  
   }
}*/






 /*class ScanQR extends StatefulWidget {
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
    Future <void> scan() async{
      try{
        
        FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Cencel', true, ScanMode.QR);
      } catch (e) {
        setState(() {
          qrString = 'QR okunmadı';
        }

        );
      }
    }
  
}*/

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR/Bar Code Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter QR/Bar Code Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: _camState
          ? Center(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Text(_qrInfo!),
            ),
    );
  }
}

