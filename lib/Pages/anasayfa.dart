import 'package:flutter/material.dart';
import 'package:projeqr/pages/girissayfasi.dart';
import 'package:projeqr/pages/malzemeekleme.dart';
import 'package:projeqr/pages/qrGenerate.dart';
import 'package:projeqr/pages/urunListeleme.dart';

//sa merhaba
//bugün baya bir şey öğrendik
class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
  final Color primaryColor = Color(0xFF232b38);
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  final Color logoGreen = Color(0xFF5f59f7);

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(5),
      color: primaryColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Image.asset('assets/THY-LOGO-DARK.png'),
              height: 220,
            ),
            SizedBox(height: 100),
            Wrap(
              direction: Axis.horizontal,
              spacing: 40,
              runSpacing: 50,
              children: [
                MaterialButton(
                  elevation: 0,
                  minWidth: 160,
                  height: 70,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MalzemeEkleme(),
                      ),
                    );
                  },
                  color: logoGreen,
                  child: Text('Yeni Ürün Ekle',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  textColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                MaterialButton(
                  elevation: 0,
                  minWidth: 160,
                  height: 70,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UrunListeleme(),
                      ),
                    );
                  },
                  color: logoGreen,
                  child: Text('Listeye Git',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  textColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                MaterialButton(
                  elevation: 0,
                  minWidth: 160,
                  height: 70,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UrunListeleme(),
                      ),
                    );
                  },
                  color: logoGreen,
                  child: Text('Qr Tara',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  textColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                MaterialButton(
                  elevation: 0,
                  minWidth: 160,
                  height: 70,
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
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  textColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      ),
    );
  }
}
