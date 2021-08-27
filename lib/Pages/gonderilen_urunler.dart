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
  @override
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring();

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService()
          .seacrhByName(capitalizedValue as String)
          .then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Mobilya Türü'].startsWith(capitalizedValue) != null) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

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
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.count(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  primary: false,
                  shrinkWrap: true,
                  children: tempSearchStore.map((element) {
                    return buildResultCard(element);
                  }).toList()),

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
                                leading: GestureDetector(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Image.network(
                                        docRef['İmage Url'] as String),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2.0),
                                          ),
                                        ),
                                        child: Container(
                                          child: Image.network(
                                              docRef['İmage Url'] as String),
                                        ),
                                      ),
                                    );
                                  },
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
