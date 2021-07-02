import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeqr/Pages/%C3%BCr%C3%BCn%C3%A7%C4%B1karmasayfas%C4%B1.dart';
import 'package:projeqr/Pages/malzemeekleme.dart';
import 'package:projeqr/net/flutterfire.dart';
import 'package:projeqr/pages/üyeol.dart';
import 'anasayfa.dart';


class ikincisayfa extends StatefulWidget {
  ikincisayfa({Key? key}) : super(key: key);

  @override
  _ikincisayfaState createState() => _ikincisayfaState();
  final Color primaryColor = Color(0xFF1A1752);
}

class _ikincisayfaState extends State<ikincisayfa> {
  
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
                        builder: (context) => uruncikarma(),
                      ),
                    );
                  },
                  color: logoGreen,
                  child: Text('Ürün çıkar',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                )

              ]
            ),
          ),
    );
  }
}
