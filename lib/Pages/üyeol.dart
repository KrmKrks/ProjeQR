import 'package:projeqr/Pages/anasayfa.dart';
import 'package:projeqr/net/flutterfire.dart';
import 'package:projeqr/pages/main.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/authentication.dart';

class UyeOl extends StatefulWidget {
  @override
  _UyeOlState createState() => _UyeOlState();
}

// TODO: İsim,soy isim , sicilno controllerinin oluşturulması lazım.
// TODO: şifre ve şifre tekrarının kontrol edilmesi gerekiyor.

class _UyeOlState extends State<UyeOl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image(
                            image: NetworkImage(
                                'https://st.depositphotos.com/1038076/5054/i/600/depositphotos_50548309-stock-photo-sign-up.jpg')),
                      ),
                      TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.pending,
                              color: Colors.grey,
                            ),
                            hintText: 'İsminiz',
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
                              Icons.pending,
                              color: Colors.grey,
                            ),
                            hintText: 'Soy isminiz',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        controller: nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.pending,
                              color: Colors.grey,
                            ),
                            hintText: 'Mail Adresiniz',
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
                              Icons.pending,
                              color: Colors.grey,
                            ),
                            hintText: 'Sicil No',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        controller: passwordController,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.pending,
                              color: Colors.grey,
                            ),
                            hintText: 'Şifre',
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
                              Icons.pending,
                              color: Colors.grey,
                            ),
                            hintText: 'Şifre Tekrarı',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () async {
                            bool shouldNavigate = await register(
                                nameController.text, passwordController.text);
                            if (shouldNavigate) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnaSayfa(),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              'Üye Ol',
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
                      )
                    ],
                  ),
                ),
              )
              //Card(
              //elevation: 4.0,
              //color: Colors.white,
              //margin: EdgeInsets.only(left: 20,right: 20),
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

              //)
            ],
          ),
        ),
      ),
    );
  }
}
