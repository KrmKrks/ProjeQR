import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QrResult extends StatefulWidget {
  String scanResult;
  QrResult({Key? key, required this.scanResult}) : super(key: key);

  @override
  _QrResultState createState() => _QrResultState();
}

CollectionReference doc = FirebaseFirestore.instance.collection('products');

class _QrResultState extends State<QrResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: doc
              .where('Document ID', isEqualTo: widget.scanResult)
              .snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var docRef = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Mobilya Türü:"
                        " \t${docRef['Mobilya Türü']} ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Adet:"
                          " \t${docRef['Adet']}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 25,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          " Müdürlük:"
                          " \t${docRef['Müdürlük']}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 25,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Not:"
                          " \t${docRef['Not']}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 25,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      //TODO: 2 adet materialbutton ile hem QR görmek istediğinde QR göstericek, Fotoğrafını görmek istediğinde ulaşacağı buttonlar tasarlanmalı
                    ],
                  );
                  //
                  // Card(
                  //   color: Theme.of(context).cardColor,
                  //   shadowColor: Theme.of(context).shadowColor,
                  //   child: ListTile(
                  //     leading: Icon(
                  //       Icons.account_circle_rounded,
                  //       color: Theme.of(context).iconTheme.color,
                  //     ),
                  //     title: Text(
                  //       "Mobilya Türü:" " \t${docRef['Mobilya Türü']} ",
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary),
                  //     ),
                  //     subtitle: Column(
                  //       children: <Widget>[
                  //         Text(
                  //           docRef['Adet'] as String,
                  //           style: TextStyle(
                  //               color: Theme.of(context).colorScheme.primary),
                  //         ),
                  //         Text(
                  //           docRef['Müdürlük'] as String,
                  //           style: TextStyle(
                  //               color: Theme.of(context).colorScheme.primary),
                  //         ),
                  //         Text(
                  //           docRef['Not'] as String,
                  //           style: TextStyle(
                  //               color: Theme.of(context).colorScheme.primary),
                  //         ),
                  //       ],
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //     ),
                  //     trailing: IconButton(
                  //       icon: Icon(Icons.edit),
                  //       color: Theme.of(context).iconTheme.color,
                  //       onPressed: () {
                  //         mobilyaTuruController.text =
                  //             docRef['Mobilya Türü'] as String;
                  //         adetController.text = docRef['Adet'] as String;
                  //         mudurlukController.text =
                  //             docRef['Müdürlük'] as String;
                  //         notController.text = docRef['Not'] as String;

                  //         showDialog(
                  //             context: context,
                  //             builder: (context) => Dialog(
                  //                   child: Container(
                  //                     color: Theme.of(context).primaryColor,
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: ListView(
                  //                         shrinkWrap: true,
                  //                         children: <Widget>[
                  //                           buildTextFormField(
                  //                               mobilyaTuruController,
                  //                               "Mobilya Türü",
                  //                               context) as Widget,
                  //                           SizedBox(
                  //                             height: 20,
                  //                           ),
                  //                           buildTextFormField(
                  //                               adetController,
                  //                               "Adet Giriniz",
                  //                               context) as Widget,
                  //                           SizedBox(
                  //                             height: 20,
                  //                           ),
                  //                           buildTextFormField(
                  //                               mudurlukController,
                  //                               "Gelen veya Giden Müdürlüğü Belirtiniz",
                  //                               context) as Widget,
                  //                           SizedBox(
                  //                             height: 20,
                  //                           ),
                  //                           buildTextFormField(
                  //                               notController,
                  //                               "Eklemek istediğiniz notunuz var ise ekleyiniz",
                  //                               context) as Widget,
                  //                           SizedBox(
                  //                             height: 20,
                  //                           ),
                  //                           FlatButton(
                  //                             child: Padding(
                  //                               padding:
                  //                                   const EdgeInsets.all(8.0),
                  //                               child:
                  //                                   Text("Dökümanı Güncelle"),
                  //                             ),
                  //                             color: logoGreen,
                  //                             onPressed: () {
                  //                               snapshot
                  //                                   .data!.docs[index].reference
                  //                                   .update({
                  //                                 'Mobilya Türü':
                  //                                     mobilyaTuruController
                  //                                         .text,
                  //                                 'Adet': adetController.text,
                  //                                 'Müdürlük':
                  //                                     mudurlukController.text,
                  //                                 'Not': notController.text,
                  //                               }).whenComplete(() =>
                  //                                       Navigator.pop(context));
                  //                             },
                  //                           ),
                  //                           FlatButton(
                  //                             child: Padding(
                  //                               padding:
                  //                                   const EdgeInsets.all(8.0),
                  //                               child: const Text("Ürünü Sil"),
                  //                             ),
                  //                             color: logoGreen,
                  //                             onPressed: () {
                  //                               snapshot
                  //                                   .data!.docs[index].reference
                  //                                   .delete()
                  //                                   .whenComplete(() =>
                  //                                       Navigator.pop(context));
                  //                             },
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ));
                  //       },
                  //     ),
                  //   ),
                  // );
                },
              );
            } else
              return Text('Herhangi bir ürün bulunamadı!');
          }),
    );
  }
}
