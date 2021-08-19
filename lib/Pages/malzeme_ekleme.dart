import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeqr/pages/urun_listeleme.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';

class MalzemeEkleme extends StatefulWidget {
  MalzemeEkleme({Key? key}) : super(key: key);

  @override
  _MalzemeEklemeState createState() => _MalzemeEklemeState();
}

class _MalzemeEklemeState extends State<MalzemeEkleme> {
  @override
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('products');
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      'UpdatedDate': DateTime.now(),
      'UserId': _auth.currentUser!.uid,
      'İmage Url': url,
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
  ImagePicker image = ImagePicker();
  File? file;
  String url = "";
  //Fotoğrafı Bu kısımda alıcaz buraya cameraya erişim işlemleride yazılacak sonrasında son haline gelicek.
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

// Fotoğrafı bizim Products kısmına bu method ile erişim sağlayacağız.
  uploadFile() async {
    var imageFile = FirebaseStorage.instance.ref().child("İmages");
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;

    // url i addproduct klasörünen içine yazdığırıyorum her kaydet dediğinde

    url = await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio / 0.1,
          horizontal: MediaQuery.of(context).devicePixelRatio / 0.18,
        ),
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: SafeArea(
          child: ListView(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Eklemek istediğiniz malzemenin detaylarını giriniz.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    buildTextFormField(
                            mobilyaTuruController, "Mobilya Türü", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(adetController, "Adet", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(mudurlukController, "Müdürlük", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(notController, "Not", context) as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: DropdownButtonFormField(
                        items: _kategori
                            .map(
                              (value) => DropdownMenuItem(
                                child: Text(value,
                                    style:
                                        Theme.of(context).textTheme.headline2),
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
                        hint: Text('  Kategori',
                            style: Theme.of(context).textTheme.headline1),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kaydet",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addProduct(
                            mobilyaTuruController.text,
                            adetController.text,
                            mudurlukController.text,
                            notController.text,
                            selectedKategori.toString(),
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
                          _formKey.currentState!.save();
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Fotoğraf Seç veya Çek",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      onPressed: () {
                        getImage();
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
