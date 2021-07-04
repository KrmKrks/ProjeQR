import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projeqr/net/authentication.dart';
import 'girissayfasi.dart';

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

/*late Map<String, dynamic> productToAdd;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("products");

  addProdct() {
    productToAdd = {
      "Mobilya Türü": mobilyaTuruController.text,
      "Adet": adetController.text,
      "Gelen veya Giden Müdürlük": mudurlukController.text,
      "Not": notController.text,
      'Document ID': data[documetID]
    };
    ;
    collectionReference
        .add(productToAdd)
        .whenComplete(() => print("Added to Database"));
  }*/

  Future<void> addProduct(
      String mobilyaTuru, String adet, String mudurluk, String not) async {
    String documnetID = _firestore.doc().id;
    await _firestore.doc(documnetID).set({
      'Mobilya Türü': mobilyaTuru,
      'Adet': adet,
      'Müdürlük': mudurluk,
      'Not': not,
      'Document ID': documnetID,
    });

    return;
  }

  final Color logoGreen = Color(0xFF5f59f7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
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
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),

                /* dökümanın ID sini almaya çalıştığımız deneme yeri  şuanda burası
                Text(
                  ,
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 15),
                ),

                */
                SizedBox(
                  height: 20,
                ),
                _buildTextField(mobilyaTuruController, "Adet Giriniz"),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(adetController, "Adet Giriniz"),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(mudurlukController,
                    "Gelen veya Giden Müdürlüğü Belirtiniz"),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(notController,
                    "Eklemek istediğiniz notunuz var ise ekleyiniz"),
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
                    ).then((value) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MalzemeEkleme()));
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Döküman Id Göster"),
                  ),
                  color: logoGreen,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ));
  }
}

_buildTextField(TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: secondaryColor, border: Border.all(color: Colors.blue)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    ),
  );
}
