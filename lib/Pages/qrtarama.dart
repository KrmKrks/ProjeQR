import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projeqr/pages/qr_result_page.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio / 20,
          horizontal: MediaQuery.of(context).devicePixelRatio / 0.3,
        ),
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(15),
            child: ListView(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              Provider.of<ThemeProvider>(context).isDarkMode
                                  ? 'assets/THY-LOGO-DARK.png'
                                  : 'assets/THY-LOGO-WHITE.png',
                              height: 220),
                        ],
                      ),
                    ),

                    Text(
                      'THY Logolu QR Kodu Tarayiniz',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    MaterialButton(
                      child: Text('QR Kodu Tara',
                          style: Theme.of(context).textTheme.button),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 70,

                      onPressed: scan, //TIKLANAN YER BURASI
                    ),

                    //SizedBox(width: width),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scan() async {
    try {
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
    }
  }
}
