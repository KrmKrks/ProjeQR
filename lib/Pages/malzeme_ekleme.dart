import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeqr/net/database_service.dart';
import 'package:projeqr/pages/models.dart';
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
  TextEditingController mobilyaTuruController = TextEditingController();
  TextEditingController adetController = TextEditingController();
  TextEditingController notController = TextEditingController();
  TextEditingController mudurlukController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  var selectedKategori;
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
  getImage2() async {
    var img = await image.pickImage(source: ImageSource.camera);
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
    
    //url = await  snapshot.ref.getDownloadURL();  
    
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
                        items: kategori
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
                          uploadFile();
                          addProduct(
                            mobilyaTuruController.text,
                            adetController.text,
                            mudurlukController.text,
                            notController.text,
                            selectedKategori.toString(),
                            url,
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
                          "Fotograf yukle",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      onPressed: () {
                       _secim(context); 
                      },
                    ),
                    //SizedBox(
                      //height: 8,
                    //),
                    //MaterialButton(
                      //child: Padding(
                        //padding: const EdgeInsets.all(8.0),
                        //child: Text(
                          //"Kameradan Fotograf Cek",
                          //style: Theme.of(context).textTheme.button,
                        //),
                      //),
                      //color: Theme.of(context).buttonColor,
                      //shape: RoundedRectangleBorder(
                          //borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      //onPressed: () {
                       //getImage2(); 
                      //},
                    //),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _secim(BuildContext context) {
    showDialog(context: context, builder: (context)=> AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Galeriden Fotograf Sec'),
            onTap: () {
            getImage();
            },
          ),
          ListTile(
            title: Text('Kameradan Fotograf Cek'),
            onTap: () {
              getImage2();
            },
          ),
        ],
      ),
    ),
    );
  }
  //void getImage(ImageSource source) async{
    //final picker  = ImagePicker();
    //final choosen = await picker.pickImage(source: source);
    //setState(() {
      //if (choosen != null){
        //file = File(choosen.path);
      //}
    //}
    //);
  //}
}
