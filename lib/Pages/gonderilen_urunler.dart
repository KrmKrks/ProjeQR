import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/net/database_service.dart';
import 'package:projeqr/pages/urun_details.dart';
import 'package:projeqr/pages/urun_details_send.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/pages/models.dart';

class GonderilenUrunler extends StatefulWidget {
  GonderilenUrunler({
    Key? key,
  }) : super(key: key);

  @override
  GonderilenUrunlerState createState() => GonderilenUrunlerState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');

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
  String query = "";
  int count = 0;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    setState(() {
      searchhing = true;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('products')
        .where('Mobilya Türü', isGreaterThanOrEqualTo: _search.text)
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
      appBar: AppBar(
        title: TextButton(
            child: Text(
              'Search',
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
            ),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchSend());
            }),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              color: Theme.of(context).iconTheme.color,
              iconSize: 30,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchSend(),
                );
              })
        ],
      ),

//-------------------------------------------------------------------------------------------------
      body: Container(
        decoration: themeDecoration(context, BorderRadius.circular(0)),

        child: Column(
          children: [
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      queryIndex = categories[index]['name'] as String;
                      setState(
                        () {
                          queryType = false;
                        },
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      shadowColor: Theme.of(context).shadowColor,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 60,
                            width: 60,
                            child: Image.asset(
                                categories[index]['iconPath'] as String),
                          ),
                          Text(
                            categories[index]['name'] as String,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
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
                      count = snapshot.data!.docs.length;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ürün Sayısı: \t$count',
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemExtent: 120,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var docRef = snapshot.data!.docs[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.5),
                                  elevation: 10,
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  shadowColor: Theme.of(context).shadowColor,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: GestureDetector(
                                          child: ClipOval(
                                            child: Image.network(
                                              docRef['İmage Url'] as String,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fill,
                                              loadingBuilder: (context, child,
                                                      progress) =>
                                                  progress == null
                                                      ? child
                                                      : CircularProgressIndicator(),
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: Center(
                                                    child: Text(
                                                      'Fotoğraf \nbulunamadı',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          onTap: () {
                                            dialogmethod(context, docRef);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Column(
                                            children: [
                                              Text("Mobilya Türü:",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1),
                                              Text("${docRef['Mobilya Türü']} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2),
                                              Divider(
                                                thickness: 1,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.color,
                                                endIndent: 10,
                                              ),
                                              Text("MDV No:",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1),
                                              Text("${docRef['MDV No']} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                      mdvNo: docRef['MDV No']
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
                                                      url: docRef['İmage Url']
                                                          as String,
                                                      not:
                                                          docRef['Not'] as String)),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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

        //---------
      ),
    );
  }

  Future<dynamic> dialogmethod(
      BuildContext context, QueryDocumentSnapshot<Object?> docRef) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2.0),
          ),
        ),
        child: Container(
          child: Image.network(
            docRef['İmage Url'] as String,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    'Fotoğraf \nbulunamadı',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.red),
                  ),
                ),
              );
            },
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
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}

//------------------------------------------------------------------
class ProductSearchSend extends SearchDelegate<dynamic> {
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     primaryColor: Theme.of(context).backgroundColor,
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var model = FilterService();
    return FutureBuilder(
      future: model.getProductMap(query),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot.error.toString()),
          );

        if (!snapshot.hasData) return CircularProgressIndicator();

        if (snapshot.data!.length == 0)
          return Center(
            child: Text("Not result found"),
          );

        return SingleChildScrollView(
          child: Column(
              children: snapshot.data!.map(
            (product) {
              if (product.mevcut == false) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  shadowColor: Theme.of(context).shadowColor,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              child: ClipOval(
                                child: Image.network(
                                  product.url,
                                  width: 100,
                                  height: 100,
                                  loadingBuilder: (context, child, progress) =>
                                      progress == null
                                          ? child
                                          : CircularProgressIndicator(),
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          'Fotoğraf \nbulunamadı',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
                                        product.url,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Container(
                                            width: 100,
                                            height: 100,
                                            child: Center(
                                              child: Text(
                                                'Fotoğraf \nbulunamadı',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            ),
                                          );
                                        },
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
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Text("Mobilya Türü:",
                                  style: Theme.of(context).textTheme.headline1),
                              Text(" \t${product.mobilyaTuru} ",
                                  style: Theme.of(context).textTheme.headline2),
                              SizedBox(height: 10),
                              Text("MDV No:",
                                  style: Theme.of(context).textTheme.headline1),
                              Text(" \t${product.mdvno} ",
                                  style: Theme.of(context).textTheme.headline2),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UrunDetails(
                                  documentID: product.documnetId,
                                  mobilyaTuru: product.mobilyaTuru,
                                  mdvNo: product.mdvno,
                                  geldigiMudurluk: product.geldigiMudurluk,
                                  not: product.not,
                                  imageUrl: product.url,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Visibility(
                  visible: false,
                  child: Text('ürün mevcutta değil gönderilmiş'));
            },
          ).toList()
              //),
              ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var model = FilterService();

    return FutureBuilder(
      future: model.getProductMap(query),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot.error.toString()),
          );

        if (!snapshot.hasData) return CircularProgressIndicator();

        if (snapshot.data!.length == 0)
          return Center(
            child: Text("Not result found"),
          );

        return SingleChildScrollView(
          child: Column(
            children: snapshot.data!.map((product) {
              if (product.mevcut == true) {
                return Visibility(
                    visible: false,
                    child: Text('Aradığınız Ürün Hala Elinizde Mevcuttur.'));
              }
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                color: Theme.of(context).cardColor.withOpacity(0.5),
                shadowColor: Theme.of(context).shadowColor,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: ClipOval(
                              child: Image.network(
                                product.url,
                                width: 100,
                                height: 100,
                                loadingBuilder: (context, child, progress) =>
                                    progress == null
                                        ? child
                                        : CircularProgressIndicator(),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        'Fotoğraf \nmevcut değil',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(color: Colors.red),
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                                      product.url,
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
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text("Mobilya Türü:",
                                style: Theme.of(context).textTheme.headline1),
                            Text(" \t${product.mobilyaTuru} ",
                                style: Theme.of(context).textTheme.headline2),
                            SizedBox(height: 10),
                            Text("MDV No:",
                                style: Theme.of(context).textTheme.headline1),
                            Text(" \t${product.mdvno} ",
                                style: Theme.of(context).textTheme.headline2),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UrunDetails(
                                documentID: product.documnetId,
                                mobilyaTuru: product.mobilyaTuru,
                                mdvNo: product.mdvno,
                                geldigiMudurluk: product.geldigiMudurluk,
                                not: product.not,
                                imageUrl: product.url,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
