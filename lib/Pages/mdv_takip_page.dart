import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projeqr/net/authentication.dart';
import 'package:projeqr/pages/urun_listeleme.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'models.dart';

AuthService _authService = AuthService();

class MdvTakip extends StatefulWidget {
  MdvTakip({Key? key}) : super(key: key);

  @override
  _MdvTakipState createState() => _MdvTakipState();
}

class _MdvTakipState extends State<MdvTakip> {
  TextEditingController mobilyaTuruController = TextEditingController();
  TextEditingController mdvNo = TextEditingController();
  TextEditingController gelisTarihi = TextEditingController();
  TextEditingController mailAtilacakKisi = TextEditingController();
  TextEditingController getirenMimar = TextEditingController();
  TextEditingController geldigiUnite = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var selectedKategori;

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
                      "MDV detaylarını giriniz.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    buildTextFormField(
                            mobilyaTuruController, "Malzeme Türü", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(mdvNo, "MDV No", context) as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(gelisTarihi, "Geliş Tarihi", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                            mailAtilacakKisi, "Mail Atılacak Kişi", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(getirenMimar, "Getiren Mimar", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(geldigiUnite, "Geldiği Ünite", context)
                        as Widget,
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
                          // addProduct(
                          //         mobilyaTuruController.text,
                          //         adetController.text,
                          //         mudurlukController.text,
                          //         notController.text,
                          //         selectedKategori.toString())
                          //     .then(
                          //   (value) {
                          //     return Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => UrunListeleme(),
                          //       ),
                          //     );
                          //   },
                          // );
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
                          "Ürün Listelemeye Dön",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
