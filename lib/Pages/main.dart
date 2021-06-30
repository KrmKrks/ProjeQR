import 'package:projeqr/pages/%C3%BCyeol.dart';
import 'package:projeqr/pages/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: login(),
  ));
}

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
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
                                'https://www.turizmguncel.com/sites/turizmguncel/uploads/contents/55185/fe0e8d6e690501d2c42fba875eba2aca.jpeg')),
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
                            hintText: 'E-posta',
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
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            hintText: 'Parola',
                            hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnaSayfa()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              'Giriş Yap',
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UyeOl()));
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

              // )
            ],
          ),
        ),
      ),
    );
  }
}
