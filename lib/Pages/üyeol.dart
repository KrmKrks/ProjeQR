import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeqr/Pages/anasayfa.dart';
import 'package:projeqr/Pages/main.dart';
import 'package:projeqr/net/flutterfire.dart';
import 'package:projeqr/pages/authentication.dart';
import 'package:projeqr/pages/main.dart';
import 'package:flutter/material.dart';
import 'malzemeekleme.dart';

class UyeOl extends StatefulWidget {
  UyeOl({Key? key}) : super(key: key);

  @override
  _UyeOlState createState() => _UyeOlState();
}

// TODO: İsim,soy isim , sicilno controllerinin oluşturulması lazım.
// TODO: şifre ve şifre tekrarının kontrol edilmesi gerekiyor.

final Color primaryColor = Color(0xFF1A1752);
final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController mailController = TextEditingController();
final TextEditingController sicilController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpasswordController = TextEditingController();

late Map<String, dynamic> usersToAdd;

CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('users');

addUser() {
  usersToAdd = {
    'İsim': nameController.text,
    'Soyisim': surnameController.text,
    'Email': mailController.text,
    'Sicil no': sicilController.text,
  };
  collectionReference
      .add(usersToAdd)
      .whenComplete(() => print('Added to database'));
}

class _UyeOlState extends State<UyeOl> {
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

              TextFormField(
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "İsim",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: surnameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Soyisim",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),

              TextFormField(
                controller: mailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Mail Adresi",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),

              TextFormField(
                controller: sicilController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Sicil Numarası",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),

              TextFormField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Yeni Şifre Yarat",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),

              TextFormField(
                obscureText: true,
                controller: confirmpasswordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Şifre Tekrarı",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Kullanıcının bir hesabı var ise kullanacağı alan

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
// TODO: Hem bilgileri register kısmından kaydedicek
// TODO: Hem giriş sayfasına yönlendirecek
// TODO: heme AddUser ile User bilgilerini Database işlenecek
              MaterialButton(
                elevation: 0,
                minWidth: double.minPositive,
                height: 50,
                onPressed: () async {
                  bool shouldNavigate = await register(
                      nameController.text, passwordController.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Authentication(),
                      ),
                    );
                  }
                },

                /*{addUser();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Authentication(),
                      ),
                  );
                }*/
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
      ),
    );
  }
}
