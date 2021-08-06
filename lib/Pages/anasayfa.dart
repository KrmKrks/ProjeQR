import 'package:flutter/material.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/pages/malzeme_ekleme.dart';
import 'package:projeqr/pages/urun_listeleme.dart';
import 'package:projeqr/pages/qrtarama.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  final Color logoGreen = Color(0xFF5f59f7);

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      //alignment: Alignment.topCenter,
      margin: EdgeInsets.all(5),
      decoration: themeDecoration(context),
      //
      // BoxDecoration(
      //   gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: Provider.of<ThemeProvider>(context).isDarkMode
      //           ? gradientDarkMode
      //           : gradientLightMode),
      // ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Container(
            child: Image.asset(Provider.of<ThemeProvider>(context).isDarkMode
                ? 'assets/THY-LOGO-DARK.png'
                : 'assets/THY-LOGO-WHITE.png'),
            height: 210,
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio / 0.2,
                vertical: MediaQuery.of(context).devicePixelRatio / 0.1,
              ),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MalzemeEkleme(),
                      ),
                    );
                  },
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Yeni Ürün Ekle',
                    style: Theme.of(context).textTheme.button,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UrunListeleme(),
                      ),
                    );
                  },
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Listeye Git',
                    style: Theme.of(context).textTheme.button,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScanQR(),
                      ),
                    );
                  },
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Qr Tara',
                    style: Theme.of(context).textTheme.button,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => QrGenerator (),
                    //   ),
                    // );
                  },
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Deneme Kısmı',
                    style: Theme.of(context).textTheme.button,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
