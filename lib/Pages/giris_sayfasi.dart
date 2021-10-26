import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeqr/net/authentication.dart';
import 'package:projeqr/pages/anasayfa.dart';
import 'package:projeqr/pages/uye_ol.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/shared/loading.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/change_theme_button_widget.dart';
import 'package:provider/provider.dart';

class Girissayfasi extends StatefulWidget {
  Girissayfasi({Key? key}) : super(key: key);

  @override
  _GirissayfasiState createState() => _GirissayfasiState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

AuthService _authService = AuthService();
bool _loading = false;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _GirissayfasiState extends State<Girissayfasi> {
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            //resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).devicePixelRatio / 20,
                horizontal: MediaQuery.of(context).devicePixelRatio / 0.3,
              ),
              decoration: themeDecoration(context, BorderRadius.circular(0)),
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  //alignment: Alignment.topCenter,
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                      Provider.of<ThemeProvider>(context)
                                              .isDarkMode
                                          ? 'assets/THY-LOGO-DARK.png'
                                          : 'assets/THY-LOGO-WHITE.png',
                                      height: 220),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 170),
                                      child: ChangeThemeButtonWidget()),
                                ],
                              ),
                            ),

                            Text(
                              'Kullanıcı adınızı ve e-mail adresinizi girerek Qrcode depo uygulamasına erişebilirsiniz.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.fontSize,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              controller: emailController,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                labelText: "Mail Adresi",
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Bu Alan Boş Birakilamaz';
                                } else {
                                  return null;
                                }
                              },
                            ),

                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                labelText: "Parola",
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                icon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Bu Alan Boş Birakilamaz';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 30),

                            // Kullanıcının bir hesabı var ise kullanacağı alan

                            MaterialButton(
                              elevation: 0,
                              minWidth: double.maxFinite,
                              height: 50,
                              onPressed: () {
                                setState(() {
                                  _loading = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  _authService
                                      .signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    context,
                                  )
                                      .then((result) {
                                    if (result != null) {
                                      setState(() {
                                        _loading = false;
                                      });
                                    } else if (result == null) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnaSayfa()));
                                    }
                                  });
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                }
                              },
                              color: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text(
                                'Giriş Yap',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),

                            SizedBox(height: 20),

                            // Kullanıcının Sıfırdan üyelik açmak için kullanacağı alan
                            MaterialButton(
                              elevation: 0,
                              minWidth: double.maxFinite,
                              height: 50,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => UyeOl()));

                                _formKey.currentState!.reset();
                              },
                              color: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text('Üye ol',
                                  style: Theme.of(context).textTheme.headline2),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
