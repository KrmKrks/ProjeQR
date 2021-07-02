import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:projeqr/Pages/malzemeekleme.dart';
import 'package:projeqr/net/authentication.dart';

import 'package:projeqr/pages/üyeol.dart';
import 'anasayfa.dart';

class Girissayfasi extends StatefulWidget {
  Girissayfasi({Key? key}) : super(key: key);

  @override
  _GirissayfasiState createState() => _GirissayfasiState();
}

final Color primaryColor = Color(0xFF1A1752);
final Color secondaryColor = Color(0xFF69900);

final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

AuthService _authService = AuthService();

class _GirissayfasiState extends State<Girissayfasi> {
  final Color logoGreen = Color(0xFF5f59f7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
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
                    labelText: "Mail Adresi",
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
                  onPressed: () {
                    _authService.signIn(nameController.text, passwordController.text).then((value) {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnaSayfa(),
                        ),
                      );
                    });
                     
                      
                    
                  },
                  color: logoGreen,
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),

                /* MaterialButton(
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
                SizedBox(height: 20),*/

                // Kullanıcının Sıfırdan üyelik açmak için kullanacağı alan
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UyeOl(),
                      ),
                    );
                  },
                  color: logoGreen,
                  child: Text('Üye ol',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.minPositive,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MalzemeEkleme(),
                        ));
                  },
                  color: logoGreen,
                  child: Text(
                    'Smoking Break..!',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  textColor: Colors.white,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          ),
        ));
  }
}
