import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeqr/net/authentication.dart';
import 'package:projeqr/pages/anasayfa.dart';
import 'package:projeqr/pages/uye_ol.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/widget/change_theme_button_widget.dart';
import 'package:provider/provider.dart';

class Girissayfasi extends StatefulWidget {
  Girissayfasi({Key? key}) : super(key: key);

  @override
  _GirissayfasiState createState() => _GirissayfasiState();
}

final Color secondaryColor = Color(0xFF69900);

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

AuthService _authService = AuthService();

class _GirissayfasiState extends State<Girissayfasi> {
  final Color logoGreen = Color(0xFF5f59f7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio / 20,
          horizontal: MediaQuery.of(context).devicePixelRatio / 0.3,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Provider.of<ThemeProvider>(context).isDarkMode
                  ? gradientDarkMode
                  : gradientLightMode),
        ),
        
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //alignment: Alignment.topCenter,
            margin: EdgeInsets.all(15),
            child: ListView(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                              Provider.of<ThemeProvider>(context).isDarkMode
                                  ? 'assets/THY-LOGO-DARK.png'
                                  : 'assets/THY-LOGO-WHITE.png',
                              height: 220),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 170),
                              child: ChangeThemeButtonWidget()),
                        ],
                      ),
                    ),

                    Text(
                      'Kullanıcı adınızı ve e-mail adresinizi girerek Qrcode depo uygulamasına erişebilirsiniz.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize:
                            Theme.of(context).textTheme.headline1?.fontSize,
                      ),
                    ),

                    TextFormField(
                      controller: emailController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Mail Adresi",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.account_circle,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),

                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Parola",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).iconTheme.color,
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
                        _authService
                            .signIn(
                                emailController.text, passwordController.text)
                            .then((value) {
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnaSayfa(),
                            ),
                          );
                        });
                      },
                      color: Theme.of(context).buttonColor,
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16),
                      ),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    SizedBox(height: 20),

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
                      color: Theme.of(context).buttonColor,
                      child: Text('Üye ol',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16)),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    SizedBox(height: 20),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.minPositive,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnaSayfa(),
                            ));
                      },
                      color: Theme.of(context).buttonColor,
                      child: Text(
                        'Smoking Break..!',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12),
                      ),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
