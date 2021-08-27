import 'package:projeqr/net/authentication.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/giris_sayfasi.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'package:provider/provider.dart';

class UyeOl extends StatefulWidget {
  UyeOl({Key? key}) : super(key: key);

  @override
  _UyeOlState createState() => _UyeOlState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController mailController = TextEditingController();
final TextEditingController sicilController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpasswordController = TextEditingController();

AuthService _authService = AuthService();

late Map<String, dynamic> usersToAdd;

class _UyeOlState extends State<UyeOl> {
  final Color logoGreen = Color(0xFF5f59f7);
  final _formKey2 = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          Provider.of<ThemeProvider>(context).isDarkMode
                              ? 'assets/THY-LOGO-DARK.png'
                              : 'assets/THY-LOGO-WHITE.png',
                        ),
                        height: 210,
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: themeDecorationForm(context),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Text(
                                    'Kişisel Bilgiler',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            color: Color(0xFF83D2D4)
                                                .withOpacity(0.8)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                              child: customTextFormField(
                                  nameController, 'İsim', context) as Widget,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                              child: customTextFormField(
                                      surnameController, 'Soyİsim', context)
                                  as Widget,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: themeDecorationForm(context),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Text(
                                    'Kullanıcı Bilgileri',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            color: Color(0xFF83D2D4)
                                                .withOpacity(0.8)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                              child: customTextFormField(
                                      mailController, 'Mail Adresi', context)
                                  as Widget,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                              child: customTextFormField(
                                      sicilController, 'THY Sicil No', context)
                                  as Widget,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: themeDecorationForm(context),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Text(
                                    'Şifre Alanı',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            color: Color(0xFF83D2D4)
                                                .withOpacity(0.8)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                style: Theme.of(context).textTheme.headline2,
                                decoration: themeInputDecoration(
                                        context, 'Şifre Giriniz')
                                    .copyWith(
                                  icon: Icon(
                                    Icons.lock,
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                              child: TextFormField(
                                obscureText: true,
                                controller: confirmpasswordController,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                decoration: themeInputDecoration(
                                        context, 'Şifreyi Tekrar Giriniz.')
                                    .copyWith(
                                  icon: Icon(
                                    Icons.lock,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Bu Alan Bos Birakilamaz';
                                  } else if (confirmpasswordController.value !=
                                      passwordController.value) {
                                    return 'Şifreleriniz uyuşmamaktadır.';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          if (_formKey2.currentState!.validate()) {
                            setState(() => loading = true);
                            _authService
                                .signUp(
                                    nameController.text.trim(),
                                    surnameController.text.trim(),
                                    mailController.text.trim(),
                                    sicilController.text.trim(),
                                    passwordController.text.trim())
                                .then((value) {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Girissayfasi()));
                            });

                            _formKey2.currentState!.save();
                          } else {}
                        },
                        color: Theme.of(context).buttonColor,
                        child: Text(
                          'ÜYE OL',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomCenter,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
