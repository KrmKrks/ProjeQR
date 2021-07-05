import 'package:flutter/material.dart';
import 'package:projeqr/pages/qrGenerate.dart';

import 'malzemeekleme.dart';
import 'urunListeleme.dart';

//sa merhaba
//bugün baya bir şey öğrendik
class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
  final Color primaryColor = Color(0xFF1A1752);
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  final Color logoGreen = Color(0xFF5f59f7);

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset('assets/THY-LOGO-DARK.png'),
                height: 220,
              ),
              SizedBox(height: 10),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MalzemeEkleme(),
                    ),
                  );
                },
                color: logoGreen,
                child: Text('Yeni ürün ekle',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => urunListeleme(),
                    ),
                  );
                },
                color: logoGreen,
                child: Text('Ürün çıkar',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => urunListeleme(),
                    ),
                  );
                },
                color: logoGreen,
                child: Text('Listele',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrGenerator(),
                    ),
                  );
                },
                color: logoGreen,
                child: Text('Deneme Kısmı',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              Align(
                alignment: Alignment.bottomCenter,
              )
            ]),
      ),
    );
  }
}
