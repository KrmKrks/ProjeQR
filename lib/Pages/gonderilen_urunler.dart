import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/net/search_service.dart';
import 'package:projeqr/pages/qr_result_page.dart';
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
  Map<String, dynamic>? userMap;
  String queryIndex = '';
  bool queryType = true;
  bool searchhing = false;

  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    setState(() {
      searchhing = true;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('products')
        .where('Mobilya Türü', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        searchhing = false;
      });
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: SafeArea(
          child: userMap != null
              ? ListTile(
                  title: Text(userMap!['Mobilya Türü'] as String),
                  subtitle: Text(userMap!['MDV No'] as String),
                )
              : Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onSearch,
                      child: Text('Search'),
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
                                    child: Image.asset(categories[index]
                                        ['iconPath'] as String),
                                  ),
                                ),
                                Text(
                                  categories[index]['name'] as String,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),

                    Flexible(
                      child: searchhing
                          ? CircularProgressIndicator()
                          : StreamBuilder(
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
                              builder:
                                  (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var docRef = snapshot.data!.docs[index];
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.5),
                                        shadowColor:
                                            Theme.of(context).shadowColor,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        docRef['İmage Url']
                                                            as String,
                                                        width: 100,
                                                        height: 100,
                                                        loadingBuilder: (context,
                                                                child,
                                                                progress) =>
                                                            progress == null
                                                                ? child
                                                                : CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  2.0),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            child:
                                                                Image.network(
                                                              docRef['İmage Url']
                                                                  as String,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.loose,
                                              child: GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 5),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Text("Mobilya Türü:",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1),
                                                      Text(
                                                          " \t${docRef['Mobilya Türü']} ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2),
                                                      SizedBox(height: 10),
                                                      Text("MDV No:",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1),
                                                      Text(
                                                          " \t${docRef['MDV No']} ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text("Adet:",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1),
                                                      Text(
                                                          " \t${docRef['Adet']} ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2),
                                                      SizedBox(height: 10),
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => UrunDetailsSend(
                                                            documentID:
                                                                docRef['Document ID']
                                                                    as String,
                                                            mobilyaTuru:
                                                                docRef['Mobilya Türü']
                                                                    as String,
                                                            mdvNo:
                                                                docRef['MDV No']
                                                                    as String,
                                                            adet: docRef['Adet']
                                                                as String,
                                                            geldigiMudurluk:
                                                                docRef['Geldiği Müdürlük']
                                                                    as String,
                                                            gonderildigiMudurluk:
                                                                docRef['Gönderildiği Müdürlük']
                                                                    as String,
                                                            gelisTarihi:
                                                                docRef['CreatedAt']
                                                                    as String,
                                                            gonderilmeTarihi:
                                                                docRef['UpdatedDate']
                                                                    as String,
                                                            not: docRef['Not'] as String)),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
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

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
        data['Mobilya Türü'] as String,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}
