import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:projeqr/provider/theme_provider.dart';
=======
//import 'package:projeqr/pages/provider/theme_provider.dart';
>>>>>>> cba96b952608e452fcca816bfe0b52d82c3c9023
import 'package:projeqr/net/authentication.dart';
import 'package:projeqr/pages/urun_listeleme.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';

AuthService _authService = AuthService();

class MalzemeEkleme extends StatefulWidget {
  MalzemeEkleme({Key? key}) : super(key: key);

  @override
  _MalzemeEklemeState createState() => _MalzemeEklemeState();
}

class _MalzemeEklemeState extends State<MalzemeEkleme> {
  @override
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('products');

  TextEditingController mobilyaTuruController = TextEditingController();
  TextEditingController adetController = TextEditingController();
  TextEditingController notController = TextEditingController();
  TextEditingController mudurlukController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  Future<String> addProduct(String mobilyaTuru, String adet, String mudurluk,
      String not, String kategori) async {
    String documentID = _firestore.doc().id;
    await _firestore.doc(documentID).set({
      'Mobilya Türü': mobilyaTuru,
      'Adet': adet,
      'Müdürlük': mudurluk,
      'Not': not,
      'Document ID': documentID,
      'Kategori': selectedKategori,
      'CreatedAt': DateTime.now(),
    });

    return _firestore.id;
  }

  var selectedKategori;
  final List<String> _kategori = <String>[
    'Masa',
    'Sandalye',
    'Dolap',
    'Keson',
    'Diğer',
  ];

  final Color logoGreen = Color(0xFF5f59f7);
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio / 0.1,
          horizontal: MediaQuery.of(context).devicePixelRatio / 0.18,
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
          child: ListView(
            children: [
              Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Eklemek istediğiniz malzemenin detaylarını giriniz.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                            mobilyaTuruController, "Mobilya Türü", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(adetController, "Adet Giriniz", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        mudurlukController,
                        "Gelen veya Giden Müdürlüğü Belirtiniz",
                        context) as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        notController,
                        "Eklemek istediğiniz notunuz var ise ekleyiniz",
                        context) as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: DropdownButtonFormField(
                        items: _kategori
                            .map(
                              (value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                value: value,
                              ),
                            )
                            .toList(),
                        dropdownColor: Theme.of(context).primaryColor,
                        onChanged: (selectedKategoriType) {
                          setState(
                            () {
                              selectedKategori = selectedKategoriType;
                            },
                          );
                        },
                        value: selectedKategori,
                        validator: (value) =>
                            value == null ? 'Kategori seçiniz.' : null,
                        hint: Text(
                          'Kategori',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kaydet",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addProduct(
                                  mobilyaTuruController.text,
                                  adetController.text,
                                  mudurlukController.text,
                                  notController.text,
                                  selectedKategori.toString())
                              .then(
                            (value) {
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UrunListeleme(),
                                ),
                              );
                            },
                          );
                          _formKey.currentState!.save();
                        } else {
                          setState(() {
                            _autovalidate = true; //enable realtime validation
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ürün Listelemeye Dön",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UrunListeleme()));
                      },
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

_buildTextFormField(
    TextEditingController controller, String labelText, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        // color: secondaryColor,
        border: Border.all(color: Colors.blue)),
    child: TextFormField(
      validator: (value) =>
          value!.isEmpty ? 'Bu alanı boş geçemezsiniz.' : null,
      controller: controller,
      style: TextStyle(
          color: Theme.of(context as BuildContext).colorScheme.primary),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none),
    ),
  );
}
