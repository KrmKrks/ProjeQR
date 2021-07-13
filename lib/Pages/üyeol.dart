import 'package:projeqr/net/authentication.dart';
import 'package:projeqr/pages/anasayfa.dart';
import 'package:flutter/material.dart';

class UyeOl extends StatefulWidget {
  UyeOl({Key? key}) : super(key: key);

  @override
  _UyeOlState createState() => _UyeOlState();
}

// TODO: şifre ve şifre tekrarının kontrol edilmesi gerekiyor.

final Color primaryColor = Color(0xFF1A1752);
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

              // Kullanıcının Sıfırdan üyelik açmak için kullanacağı alan
// TODO: Hem bilgileri register kısmından kaydedicek
// TODO: Hem giriş sayfasına yönlendirecek
// TODO: heme AddUser ile User bilgilerini Database işlenecek
              MaterialButton(
                elevation: 0,
                minWidth: double.minPositive,
                height: 50,
                onPressed: () {
                  _authService
                      .createPerson(
                          nameController.text,
                          surnameController.text,
                          mailController.text,
                          sicilController.text,
                          passwordController.text)
                      .then((value) {
                    return Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AnaSayfa()));
                  });
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
      ),
    );
  }
}
