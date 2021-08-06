import 'package:projeqr/net/authentication.dart';

import 'package:flutter/material.dart';
import 'package:projeqr/pages/giris_sayfasi.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class UyeOl extends StatefulWidget {
  UyeOl({Key? key}) : super(key: key);

  @override
  _UyeOlState createState() => _UyeOlState();
}

// TODO: şifre ve şifre tekrarının kontrol edilmesi gerekiyor.

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
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey2,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? 'assets/THY-LOGO-DARK.png'
                            : 'assets/THY-LOGO-WHITE.png',
                      ),
                      height: 220,
                    ),
                    SizedBox(height: 10),

                    TextFormField(
                      autovalidate: false,
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "İsim",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.account_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu Alan Bos Birakilamaz';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: surnameController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Soyisim",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu Alan Bos Birakilamaz';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      controller: mailController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Mail Adresi",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu Alan Bos Birakilamaz';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      controller: sicilController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Sicil Numarası",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu Alan Bos Birakilamaz';
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 30),

                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Yeni Şifre Yarat",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu Alan Bos Birakilamaz';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      obscureText: true,
                      controller: confirmpasswordController,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Şifre Tekrarı",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bu Alan Bos Birakilamaz';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),

                    // Kullanıcının Sıfırdan üyelik açmak için kullanacağı alan
// TODO: Hem bilgileri register kısmından kaydedicek
// TODO: Hem giriş sayfasına yönlendirecek
// TODO: heme AddUser ile User bilgilerini Database işlenecek
<<<<<<< HEAD
              MaterialButton(
                elevation: 0,
                minWidth: double.minPositive,
                height: 50,
                onPressed: () {
                  if(_formKey2.currentState!.validate()){
                    
                  
                  _authService
                      .createPerson(
                          nameController.text,
                          surnameController.text,
                          mailController.text,
                          sicilController.text,
                          passwordController.text)
                      .then((value) {
                    return Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Girissayfasi()));
                  });
                  _formKey2.currentState!.save();
=======
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.minPositive,
                      height: 50,
                      onPressed: () {
                        if (_formKey2.currentState!.validate()) {
                          _authService
                              .createPerson(
                                  nameController.text,
                                  surnameController.text,
                                  mailController.text,
                                  sicilController.text,
                                  passwordController.text)
                              .then((value) {
                            return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Girissayfasi()));
                          });
                          _formKey2.currentState!.save();
>>>>>>> 895acf29cf20340b0d64604c10f59f7cfc1d3065
                        } else {
                          setState(() {
                            _autovalidate = true; //enable realtime validation
                          });
                        }
                      },
                      color: logoGreen,
                      child: Text(
                        'ÜYE OL',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
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
    );
  }
}
