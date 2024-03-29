import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projeqr/net/database_service.dart';
import 'package:projeqr/pages/anasayfa.dart';
import 'package:projeqr/models/models.dart';
import 'package:projeqr/shared/loading.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;

class MalzemeEkleme extends StatefulWidget {
  MalzemeEkleme({Key? key}) : super(key: key);

  @override
  _MalzemeEklemeState createState() => _MalzemeEklemeState();
}

class _MalzemeEklemeState extends State<MalzemeEkleme> {
  TextEditingController mobilyaTuruController = TextEditingController();
  TextEditingController mdvNoController = TextEditingController();
  TextEditingController adetController = TextEditingController();
  TextEditingController geldigiMudurlukController = TextEditingController();
  TextEditingController notController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  var selectedKategori;
  final _formKey = GlobalKey<FormState>();
  String now = DateTime.now().toString().substring(0, 18);
  String imageUrl = '';
  final ImagePicker _picker = ImagePicker();
  File? file;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                            "Eklemek istediğiniz malzemenin bilgilerini giriniz.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          groupTextFormField(
                              mobilyaTuruController,
                              mdvNoController,
                              'Malzeme Bilgileri',
                              'Mobilya Türü',
                              'MDV No',
                              context) as Widget,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 0, 0),
                                      child: Text('Malzeme Detayları',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1),
                                    ),
                                  ],
                                ),
                                //  Padding(
                                //  padding:
                                //    const EdgeInsets.fromLTRB(15, 0, 15, 7),
                                // child: customTextFormField(
                                //      adetController, 'Adet', context)
                                //as Widget,
                                //),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 7),
                                  child: customTextFormField(
                                      geldigiMudurlukController,
                                      'Geldiği Müdürlük',
                                      context) as Widget,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 7),
                                  child: customTextFormField(
                                      notController, 'Not', context) as Widget,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: EdgeInsets.all(2),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              items: kategori
                                  .map(
                                    (value) => DropdownMenuItem(
                                      child: Text(value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2),
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
                            height: 15,
                          ),
                          MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Fotograf yukle",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            color: Theme.of(context)
                                .textTheme
                                .button!
                                .backgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            onPressed: () {
                              _secim(context);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Kaydet",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            color: Theme.of(context)
                                .textTheme
                                .button!
                                .backgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            onPressed: () async {
                              setState(() => loading = true);
                              if (_formKey.currentState!.validate()) {
                                if (file != null) {
                                  await _uploadFile(file!.path);
                                  addProduct(
                                          mobilyaTuruController.text
                                              .trim()
                                              .toLowerCase(),
                                          mdvNoController.text.trim(),
                                          geldigiMudurlukController.text.trim(),
                                          notController.text.trim(),
                                          selectedKategori.toString(),
                                          now,
                                          now,
                                          imageUrl,
                                          true)
                                      .then(
                                    (value) {
                                      return Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AnaSayfa(),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      content: Text(
                                        'Fotoğraf eklemeden ürünü kaydetmek istediğinize emin misiniz ? ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: TextButton(
                                                child: Text(
                                                  'Evet Eminim',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .button!
                                                            .backgroundColor),
                                                onPressed: () {
                                                  addProduct(
                                                          mobilyaTuruController
                                                              .text
                                                              .trim()
                                                              .toLowerCase(),
                                                          mdvNoController.text
                                                              .trim(),
                                                          geldigiMudurlukController
                                                              .text
                                                              .trim(),
                                                          notController.text
                                                              .trim(),
                                                          selectedKategori
                                                              .toString(),
                                                          now,
                                                          now,
                                                          imageUrl,
                                                          true)
                                                      .then(
                                                    (value) {
                                                      return Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AnaSayfa(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: TextButton(
                                                child: Text(
                                                  'Fotoğraf seç',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .button!
                                                            .backgroundColor),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _secim(context);
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                _formKey.currentState?.save();
                              } else {
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                          ),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          'Eklemek istediğiniz ürünün fotoğrafını çekin veya galeriden seçin',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).textTheme.button!.backgroundColor),
                  onPressed: () => Navigator.pop(
                    context,
                    pickImage(ImageSource.camera),
                  ),
                  child: Text(
                    'Kamera',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).textTheme.button!.backgroundColor),
                  onPressed: () => Navigator.pop(
                    context,
                    pickImage(ImageSource.gallery),
                  ),
                  child: Text(
                    'Galeri',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return null;
    }

    file = await compressImage(pickedFile.path, 35);
    setState(() {
      this.file = file;
    });
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  Future<dynamic> _uploadFile(String path) async {
    try {
      final ref = storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now().toIso8601String() + p.basename(path)}');

      final result = await ref.putFile(File(path));
      final fileUrl = await result.ref.getDownloadURL();
      setState(() {
        imageUrl = fileUrl;
      });
    } on storage.FirebaseException catch (e) {
      print('$e');
    }
  }
}
