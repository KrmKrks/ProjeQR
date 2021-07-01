import 'package:projeqr/pages/authentication.dart';

import 'package:projeqr/pages/main.dart';
import 'package:flutter/material.dart';

//sa merhaba
//bugün baya bir şey öğrendik
class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

final Color primaryColor = Color(0xff18203d);

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        color: Colors.grey[1000],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //Card(
                //elevation: 4.0,
                //color: Colors.white,
                //margin: EdgeInsets.only(left: 20,right: 20),
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(child: Image.asset('assets/THY-LOGO-DARK.png')),
                      TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            hintText: 'Malzeme Adı',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            hintText: 'Alınan Yer',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      TextFormField(
                        style: TextStyle(color: Color(0xFF070707)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            hintText: 'SERİ NO',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              'QR KOD ÜRET',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.blue[500],
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10)),
                        ),
                      ),

                      // Giriş Sayfası yani Authentication sayfasına  yönlendiren kısım
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Authentication()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              'Anasayfaya Dön',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.blue[500],
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //)
            ],
          ),
        ),
      ),
    );
  }
}
