import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/net/authentication.dart';

import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'models.dart';
import "package:velocity_x/velocity_x.dart";

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
                    groupTextFormField(
                        mobilyaTuruController,
                        mdvNo,
                        'Malzeme bilgileri',
                        'Mobilya Türü',
                        'MDV No',
                        context) as Widget,
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFF243B55).withOpacity(0.95),
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(
                    //       color: Colors.blue,
                    //       width: 1,
                    //     ),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Padding(
                    //             padding:
                    //                 const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    //             child: Text(
                    //               'Malzeme bilgi alanı',
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .headline1
                    //                   ?.copyWith(
                    //                       color: Color(0xFF83D2D4)
                    //                           .withOpacity(0.8)),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    //         child: TextFormField(
                    //           // controller: controller,
                    //           decoration: InputDecoration(
                    //             enabledBorder: UnderlineInputBorder(
                    //                 borderSide: BorderSide(color: Colors.blue)),
                    //             focusedBorder: UnderlineInputBorder(
                    //                 borderSide: BorderSide(color: Colors.blue)),
                    //             contentPadding:
                    //                 EdgeInsets.symmetric(horizontal: 10),
                    //             // fillColor: Colors.white,
                    //             labelStyle: TextStyle(
                    //                 color:
                    //                     Theme.of(context).colorScheme.primary),
                    //             labelText: 'Malzeme Türü',
                    //           ),
                    //           style: Theme.of(context).textTheme.headline2,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 20,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
                    //         child: TextFormField(
                    //           decoration: InputDecoration(
                    //             enabledBorder: UnderlineInputBorder(
                    //                 borderSide: BorderSide(color: Colors.blue)),
                    //             focusedBorder: UnderlineInputBorder(
                    //                 borderSide: BorderSide(color: Colors.blue)),
                    //             contentPadding:
                    //                 EdgeInsets.symmetric(horizontal: 10),
                    //             hintText: 'MDV No',
                    //             labelStyle: TextStyle(
                    //                 color:
                    //                     Theme.of(context).colorScheme.primary),
                    //             hintStyle: TextStyle(
                    //                 color:
                    //                     Theme.of(context).colorScheme.primary),
                    //           ),
                    //           style: Theme.of(context).textTheme.headline2,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(gelisTarihi, "Geliş Tarihi", context)
                        as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                        gelisTarihi, "Gönderildiği Tarihi", context) as Widget,
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
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                        getirenMimar, "Gönderildiği Ünite", context) as Widget,
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(getirenMimar, "Durumu", context)
                        as Widget,
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
                      onPressed: () {},
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



//  CupertinoFormSection(
//                       header: "Personal Details".text.make(),
//                       children: [
//                         CupertinoFormRow(
//                           child: CupertinoTextFormFieldRow(
//                             placeholder: "Enter name",
//                           ),
//                           prefix: "Name".text.make(),
//                         ),
//                         CupertinoFormRow(
//                           child: CupertinoTextFormFieldRow(
//                             placeholder: "Enter phone",
//                           ),
//                           prefix: "Phone".text.make(),
//                         )
//                       ]),
//                   CupertinoFormSection(header: "User".text.make(), children: [
//                     CupertinoFormRow(
//                       child: CupertinoTextFormFieldRow(
//                         placeholder: "Enter email",
//                       ),
//                       prefix: "Email".text.make(),
//                     ),
//                     CupertinoFormRow(
//                       child: CupertinoTextFormFieldRow(
//                         obscureText: true,
//                       ),
//                       prefix: "Password".text.make(),
//                     ),
//                     CupertinoFormRow(
//                       child: CupertinoTextFormFieldRow(
//                         obscureText: true,
//                       ),
//                       prefix: "Confirm Password".text.make(),
//                     )
//                   ]),
//                   CupertinoFormSection(
//                       header: "Terms & Conditions".text.make(),
//                       children: [
//                         CupertinoFormRow(
//                           child: CupertinoSwitch(
//                             value: true,
//                             onChanged: (value) {},
//                           ),
//                           prefix: "I Agree".text.make(),
//                         ),
//                       ]),
//                   20.heightBox,
//                   Material(
//                     color: context.theme.buttonColor,
//                     borderRadius: BorderRadius.circular(8),
//                     child: InkWell(
//                       child: AnimatedContainer(
//                         duration: Duration(seconds: 1),
//                         width: 150,
//                         height: 50,
//                         alignment: Alignment.center,
//                         child: Text(
//                           "SignUp",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ).centered(),