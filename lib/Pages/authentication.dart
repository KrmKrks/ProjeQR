import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeqr/net/flutterfire.dart';

import 'anasayfa.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

final Color primaryColor = Color(0xff18203d);
final Color secondaryColor = Color(0xff232c51);

class _AuthenticationState extends State<Authentication> {
  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset('assets/CIFT-SATIR-DIKEY-TIRE.jpg'),
                  height: 220,
                ),
                SizedBox(height: 10),
                Text(
                  'Kullanıcı adınızı ve e-mail adresinizi girerek Qrcode depo uygulamasına erişebilirsiniz.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Kullanıcı Adı",
                    labelStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Parola",
                    labelStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Kullanıcının bir hesabı var ise kullanacağı alan

                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    bool shouldNavigate = await signIn(
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
                  color: logoGreen,
                  child: Text('Giriş Yap',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    //Here goes the logic for Google SignIn discussed in the next section
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text('Google hesabın ile üye ol',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),

                // Kullanıcının Sıfırdan üyelik açmak için kullanacağı alan
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
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
                  color: logoGreen,
                  child: Text('Üye ol',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          ),
        ));
  }
}
