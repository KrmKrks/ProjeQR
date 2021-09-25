import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/gonderilen_urunler.dart';
import 'package:projeqr/pages/malzeme_ekleme.dart';
import 'package:projeqr/pages/urun_listeleme.dart';
import 'package:projeqr/pages/qrtarama.dart';
import 'package:projeqr/widget/change_theme_button_widget.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int pageIndex = 1;
  List<Widget> pageList = <Widget>[
    MalzemeEkleme(),
    UrunListeleme(),
    ScanQR(),
    GonderilenUrunler(),
  ];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [ChangeThemeButtonWidget()],
        ),
        body: pageList[pageIndex],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          activeColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          style: TabStyle.reactCircle,
          height: 60,
          initialActiveIndex: 1,
          items: [
            TabItem(
              title: "Malzeme Ekle",
              icon: Icon(
                Icons.add,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme!
                    .color,
                size: 30,
              ),
            ),
            TabItem(
              title: "Liste",
              icon: Icon(
                Icons.list,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme!
                    .color,
                size: 30,
              ),
            ),
            TabItem(
              icon: Icon(
                Icons.qr_code,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme!
                    .color,
                size: 27,
              ),
              title: "Qr Tara",
            ),
            TabItem(
              title: "Stoktan Giden",
              icon: Icon(
                Icons.folder,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme!
                    .color,
                size: 27,
              ),
            ),
          ],
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
        ));
  }
}
