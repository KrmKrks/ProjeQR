import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeqr/net/authentication.dart';
import 'package:projeqr/pages/giris_sayfasi.dart';
import 'package:projeqr/pages/urun_listeleme.dart';

AuthService _authService = AuthService();

class MalzemeEkleme extends StatefulWidget {
  MalzemeEkleme({Key? key}) : super(key: key);

  @override
  _MalzemeEklemeState createState() => _MalzemeEklemeState();
}

class _MalzemeEklemeState extends State<MalzemeEkleme> {
  @override
  CollectionReference _firestore =
      FirebaseFirestore.instance.collection('products');

  TextEditingController mobilyaTuruController = TextEditingController();
  TextEditingController adetController = TextEditingController();
  TextEditingController notController = TextEditingController();
  TextEditingController mudurlukController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  Future<String> addProduct(
      String mobilyaTuru, String adet, String mudurluk, String not) async {
    String documentID = _firestore.doc().id;
    await _firestore.doc(documentID).set({
      'Mobilya Türü': mobilyaTuru,
      'Adet': adet,
      'Müdürlük': mudurluk,
      'Not': not,
      'Document ID': documentID,
    });

    return _firestore.id;
  }

  final Color logoGreen = Color(0xFF5f59f7);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "Eklemek istediğiniz malzemenin detaylarını giriniz.",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              _buildTextField(mobilyaTuruController, "Mobilya Türü", context),
              SizedBox(
                height: 20,
              ),
              _buildTextField(adetController, "Adet Giriniz", context),
              SizedBox(
                height: 20,
              ),
              _buildTextField(mudurlukController,
                  "Gelen veya Giden Müdürlüğü Belirtiniz", context),
              SizedBox(
                height: 20,
              ),
              _buildTextField(notController,
                  "Eklemek istediğiniz notunuz var ise ekleyiniz", context),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Kaydet"),
                ),
                color: logoGreen,
                onPressed: () {
                  addProduct(
                    mobilyaTuruController.text,
                    adetController.text,
                    mudurlukController.text,
                    notController.text,
                  ).then(
                    (value) {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UrunListeleme(),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ürün Listelemeye Dön"),
                ),
                color: logoGreen,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UrunListeleme()));
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}

_buildTextField(TextEditingController controller, String labelText, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: secondaryColor, border: Border.all(color: Colors.blue)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none),
    ),
  );
}