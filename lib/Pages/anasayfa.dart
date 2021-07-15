import 'package:flutter/material.dart';
import 'package:projeqr/pages/malzemeekleme.dart';
import 'package:projeqr/pages/provider/theme_provider.dart';
import 'package:projeqr/pages/qrGenerate.dart';
import 'package:projeqr/pages/urunListeleme.dart';
import 'package:provider/provider.dart';

//sa merhaba
//bugün baya bir şey öğrendik
class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  final Color logoGreen = Color(0xFF5f59f7);

  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Image.asset(Provider.of<ThemeProvider>(context).isDarkMode
                  ? 'assets/THY-LOGO-DARK.png'
                  : 'assets/THY-LOGO-WHITE.png'),
              height: 220,
            ),
            SizedBox(height: 100),
            Wrap(
              direction: Axis.horizontal,
              spacing: 30,
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
