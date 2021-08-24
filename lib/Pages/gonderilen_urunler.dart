import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/urun_details_send.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'models.dart';

class GonderilenUrunler extends StatefulWidget {
  GonderilenUrunler({
    Key? key,
  }) : super(key: key);

  @override
  GonderilenUrunlerState createState() => GonderilenUrunlerState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');
final FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController mobilyaTuruController = TextEditingController();
TextEditingController mdvNo = TextEditingController();
TextEditingController gelisTarihi = TextEditingController();
TextEditingController geldigiMudurluk = TextEditingController();
TextEditingController gonderildigiTarih = TextEditingController();
TextEditingController gonderildigiMudurluk = TextEditingController();
TextEditingController not = TextEditingController();

class GonderilenUrunlerState extends State<GonderilenUrunler> {
  @override
  // void initState() {
  //   getUserRole();
  //   super.initState();
  // }

  // String userRole = '';

  // getUserRole() async {
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(_auth.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     if (mounted) {
  //       setState(() {
  //         userRole = value.data()!['Role'].toString();
  //       });
  //     }
  //   });
  // }

  String queryIndex = '';
  bool queryType = true;
  @override
  build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.settings),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
//-------------------------------------------------------------------------------------------------
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            width: 90,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  queryIndex =
                                      categories[index]['name'] as String;
                                  queryType = false;
                                });
                              },
                              child: Image.asset(
                                  categories[index]['iconPath'] as String),
                            ),
                          ),
                          Text(
                            categories[index]['name'] as String,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),

//-------------------------------------------------------------------------
              Flexible(
                child: StreamBuilder(
                    stream: queryType
                        ? ref
                            .where("Ürün Mevcut", isEqualTo: false)
                            .orderBy('CreatedAt', descending: true)
                            .snapshots()
                        : ref
                            .where('Kategori', isEqualTo: queryIndex)
                            .where("Ürün Mevcut", isEqualTo: false)
                            .orderBy('CreatedAt', descending: true)
                            .snapshots(),
                    builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
//                         if (userRole == 'Admin') {
//                           return ListView.builder(
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (context, index) {
//                               var docRef = snapshot.data!.docs[index];
//                               return Card(
//                                 margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                 color: Theme.of(context)
//                                     .cardColor
//                                     .withOpacity(0.5),
//                                 shadowColor: Theme.of(context).shadowColor,
//                                 child: ListTile(
//                                   leading: Icon(
//                                     Icons.account_circle_rounded,
//                                     color: Theme.of(context).iconTheme.color,
//                                   ),
//                                   subtitle: Column(
//                                     children: <Widget>[
//                                       SizedBox(height: 10),
//                                       Text("Mobilya Türü:",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline1),
//                                       Text(" \t${docRef['Mobilya Türü']} ",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline2),
//                                       SizedBox(height: 10),
//                                       Text("MDV No:",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline1),
//                                       Text(" \t${docRef['MDV No']} ",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline2),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text("Adet:",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline1),
//                                       Text(" \t${docRef['Adet']} ",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headline2),
//                                       SizedBox(height: 10),
//--------------------------- Şuanda Gerekli bilgiler dışında card kısmında olabildiğince az şey gözüksün
                        // Text("Geldiği Müdürlük:",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline1),
                        // Text(
                        //   " \t${docRef['Geldiği Müdürlük']}",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headline2,
                        // ),
                        // SizedBox(height: 10),
                        // Text("Not:",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline1),
                        // Text(" \t${docRef['Not']}",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline2),
//                                     ],
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                   ),
//                                   trailing: IconButton(
//                                     icon: Icon(Icons.edit),
//                                     color: Theme.of(context).iconTheme.color,
//                                     onPressed: () {
//                                       mobilyaTuruController.text =
//                                           docRef['Mobilya Türü'] as String;
//                                       adetController.text =
//                                           docRef['Adet'] as String;

//                                       notController.text =
//                                           docRef['Not'] as String;

//                                       showDialog(
//                                           context: context,
//                                           builder: (context) => Dialog(
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                     Radius.circular(20.0),
//                                                   ),
//                                                 ),
//                                                 child: Container(
//                                                   decoration: themeDecoration(
//                                                     context,
//                                                     BorderRadius.circular(20),
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: ListView(
//                                                       shrinkWrap: true,
//                                                       children: <Widget>[
//                                                         buildTextFormField(
//                                                             mobilyaTuruController,
//                                                             "Mobilya Türü",
//                                                             context) as Widget,
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         buildTextFormField(
//                                                             adetController,
//                                                             "Adet",
//                                                             context) as Widget,
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         buildTextFormField(
//                                                             gonderildigiMudurlukController,
//                                                             "Gönderildiği Müdürlük",
//                                                             context) as Widget,
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         buildTextFormField(
//                                                             notController,
//                                                             "Not",
//                                                             context) as Widget,
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         MaterialButton(
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(8.0),
//                                                             child: Text(
//                                                               "Dökümanı Güncelle",
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .button,
//                                                             ),
//                                                           ),
//                                                           color:
//                                                               Theme.of(context)
//                                                                   .buttonColor,
//                                                           shape: RoundedRectangleBorder(
//                                                               borderRadius: BorderRadius
//                                                                   .all(Radius
//                                                                       .circular(
//                                                                           10.0))),
//                                                           onPressed: () {
//                                                             snapshot
//                                                                 .data!
//                                                                 .docs[index]
//                                                                 .reference
//                                                                 .update({
//                                                               'Mobilya Türü':
//                                                                   mobilyaTuruController
//                                                                       .text,
//                                                               'Adet':
//                                                                   adetController
//                                                                       .text,
//                                                               'Gönderildiği Müdürlük':
//                                                                   gonderildigiMudurlukController
//                                                                       .text,
//                                                               'Not':
//                                                                   notController
//                                                                       .text,
//                                                               'UpdatedDate':
//                                                                   DateTime
//                                                                       .now(),
//                                                               'UserId': _auth
//                                                                   .currentUser!
//                                                                   .email,
//                                                             }).whenComplete(() =>
//                                                                     Navigator.pop(
//                                                                         context));
//                                                           },
//                                                         ),
//                                                         MaterialButton(
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(8.0),
//                                                             child: Text(
//                                                               "Ürünü Sil",
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .button,
//                                                             ),
//                                                           ),
//                                                           color:
//                                                               Theme.of(context)
//                                                                   .buttonColor,
//                                                           shape: RoundedRectangleBorder(
//                                                               borderRadius: BorderRadius
//                                                                   .all(Radius
//                                                                       .circular(
//                                                                           10.0))),
//                                                           onPressed: () {
//                                                             snapshot
//                                                                 .data!
//                                                                 .docs[index]
//                                                                 .reference
//                                                                 .delete()
//                                                                 .whenComplete(() =>
//                                                                     Navigator.pop(
//                                                                         context));
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ));
//                                     },
//                                   ),
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => UrunDetails(
//                                               documentID: docRef['Document ID']
//                                                   as String,
//                                               mobilyaTuru:
//                                                   docRef['Mobilya Türü']
//                                                       as String,
//                                               mdvNo: docRef['MDV No'] as String,
//                                               adet: docRef['Adet'] as String,
//                                               geldigiMudurluk:
//                                                   docRef['Geldiği Müdürlük']
//                                                       as String,
//                                               not: docRef['Not'] as String)),
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           );
//                         }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var docRef = snapshot.data!.docs[index];
                            return Card(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5),
                              shadowColor: Theme.of(context).shadowColor,
                              child: ListTile(
                                leading: Icon(
                                  Icons.account_circle_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text("Mobilya Türü:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1),
                                    Text(" \t${docRef['Mobilya Türü']} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    SizedBox(height: 10),
                                    Text("MDV No:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1),
                                    Text(" \t${docRef['MDV No']} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Adet:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1),
                                    Text(" \t${docRef['Adet']} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    SizedBox(height: 10),
//----------------------- Şuanda Gerekli bilgiler dışında card kısmında olabildiğince az şey gözüksün
                                    // Text("Geldigi Müdürlük:",
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .headline1),
                                    // Text(
                                    //   " \t${docRef['Geldiği Müdürlük']}",
                                    //   style:
                                    //       Theme.of(context).textTheme.headline2,
                                    // ),
                                    // SizedBox(height: 10),
                                    // Text("Not:",
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .headline1),
                                    // Text(" \t${docRef['Not']}",
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .headline2),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UrunDetailsSend(
                                            documentID:
                                                docRef['Document ID'] as String,
                                            mobilyaTuru: docRef['Mobilya Türü']
                                                as String,
                                            mdvNo: docRef['MDV No'] as String,
                                            adet: docRef['Adet'] as String,
                                            geldigiMudurluk:
                                                docRef['Geldiği Müdürlük']
                                                    as String,
                                            gonderildigiMudurluk:
                                                docRef['Gönderildiği Müdürlük']
                                                    as String,
                                            gelisTarihi:
                                                docRef['CreatedAt'] as String,
                                            gonderilmeTarihi:
                                                docRef['UpdatedDate'] as String,
                                            not: docRef['Not'] as String)),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                      return Text(
                        'Herhangi bir veri bulunamadı',
                        style: Theme.of(context).textTheme.headline1,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
