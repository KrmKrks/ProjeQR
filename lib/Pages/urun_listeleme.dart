import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/net/database_service.dart';
import 'package:projeqr/pages/urun_details.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'models.dart';

class UrunListeleme extends StatefulWidget {
  UrunListeleme({
    Key? key,
  }) : super(key: key);

  @override
  UrunListelemeState createState() => UrunListelemeState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');
final FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController mobilyaTuruController = TextEditingController();
TextEditingController mdvNoController = TextEditingController();
TextEditingController geldigiMudurlukController = TextEditingController();
TextEditingController gonderildigiMudurlukController = TextEditingController();
TextEditingController notController = TextEditingController();

class UrunListelemeState extends State<UrunListeleme> {
  @override
  void initState() {
    getUserRole();

    super.initState();
  }

  String userRole = '';

  getUserRole() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          userRole = value.data()!['Role'].toString();
        });
      }
    });
  }

  String queryIndex = '';
  bool queryType = true;
  String now = DateTime.now().toString().substring(0, 18);

  bool loading = false;
  int count = 0;

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
              showSearch(context: context, delegate: ProductSearch());
            }),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ProductSearch());
            },
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Theme.of(context).iconTheme.color,
          )
        ],
      ),

      //-------------------------------------------------------------------------------------------------

      body: Container(
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
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
                            style: Theme.of(context).textTheme.headline2,
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
                            .where("Ürün Mevcut", isEqualTo: true)
                            .orderBy('CreatedAt', descending: true)
                            .snapshots()
                        : ref
                            .where('Kategori', isEqualTo: queryIndex)
                            .where("Ürün Mevcut", isEqualTo: true)
                            .orderBy('CreatedAt', descending: true)
                            .snapshots(),
                    builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data == null) {
                        return Text(
                          'Herhangi bir ürün bulunamadı',
                          style: Theme.of(context).textTheme.headline1,
                        );
                      }
                      if (snapshot.hasData && userRole == 'Admin') {
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var docRef = snapshot.data!.docs[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.5),
                                    shadowColor: Theme.of(context).shadowColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: GestureDetector(
                                              child: ClipOval(
                                                child: Image.network(
                                                  docRef['İmage Url'] as String,
                                                  width: 100,
                                                  height: 100,
                                                  loadingBuilder: (context,
                                                          child, progress) =>
                                                      progress == null
                                                          ? child
                                                          : CircularProgressIndicator(),
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: Center(
                                                        child: Text(
                                                          'Fotoğraf \nmevcut değil',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline2!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2.0),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      child: Image.network(
                                                        docRef['İmage Url']
                                                            as String,
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Text(
                                                            'Fotoğraf \nbulunamadı',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline2!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .red),
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
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: GestureDetector(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Text("Mobilya Türü:",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                                Text(
                                                    " \t${docRef['Mobilya Türü']} ",
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
                                                  builder: (context) =>
                                                      UrunDetails(
                                                    documentID:
                                                        docRef['Document ID']
                                                            as String,
                                                    mobilyaTuru:
                                                        docRef['Mobilya Türü']
                                                            as String,
                                                    mdvNo: docRef['MDV No']
                                                        as String,
                                                    geldigiMudurluk: docRef[
                                                            'Geldiği Müdürlük']
                                                        as String,
                                                    not:
                                                        docRef['Not'] as String,
                                                    imageUrl:
                                                        docRef['İmage Url']
                                                            as String,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          alignment: Alignment.centerRight,
                                          icon: Icon(Icons.edit),
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          onPressed: () {
                                            mobilyaTuruController.text =
                                                docRef['Mobilya Türü']
                                                    as String;

                                            notController.text =
                                                docRef['Not'] as String;

                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            themeDecoration(
                                                          context,
                                                          BorderRadius.circular(
                                                              20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: <Widget>[
                                                              buildTextFormField(
                                                                  mobilyaTuruController,
                                                                  "Mobilya Türü",
                                                                  context) as Widget,
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              buildTextFormField(
                                                                  gonderildigiMudurlukController,
                                                                  "Gönderildiği Müdürlük",
                                                                  context) as Widget,
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              buildTextFormField(
                                                                      notController,
                                                                      "Not",
                                                                      context)
                                                                  as Widget,
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              MaterialButton(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Dökümanı Güncelle",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .button,
                                                                  ),
                                                                ),
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .button!
                                                                    .backgroundColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                onPressed: () {
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .reference
                                                                      .update({
                                                                    'Mobilya Türü':
                                                                        mobilyaTuruController
                                                                            .text,
                                                                    'Gönderildiği Müdürlük':
                                                                        gonderildigiMudurlukController
                                                                            .text,
                                                                    'Not':
                                                                        notController
                                                                            .text,
                                                                    'UpdatedDate':
                                                                        now,
                                                                    'UserId': _auth
                                                                        .currentUser!
                                                                        .email,
                                                                    'Ürün Mevcut':
                                                                        false
                                                                  }).whenComplete(() =>
                                                                          Navigator.pop(
                                                                              context));
                                                                },
                                                              ),
                                                              MaterialButton(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Ürünü Sil",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .button,
                                                                  ),
                                                                ),
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .button!
                                                                    .backgroundColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                onPressed: () {
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .reference
                                                                      .delete()
                                                                      .whenComplete(() =>
                                                                          Navigator.pop(
                                                                              context));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasData && userRole == 'Member') {
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var docRef = snapshot.data!.docs[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.5),
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
                                                    docRef['İmage Url']
                                                        as String,
                                                    width: 100,
                                                    height: 100,
                                                    loadingBuilder: (context,
                                                            child, progress) =>
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
                                                            BorderRadius.all(
                                                          Radius.circular(2.0),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        child: Image.network(
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
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Text("Mobilya Türü:",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                                Text(
                                                    " \t${docRef['Mobilya Türü']} ",
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
                                                  builder: (context) =>
                                                      UrunDetails(
                                                    documentID:
                                                        docRef['Document ID']
                                                            as String,
                                                    mobilyaTuru:
                                                        docRef['Mobilya Türü']
                                                            as String,
                                                    mdvNo: docRef['MDV No']
                                                        as String,
                                                    geldigiMudurluk: docRef[
                                                            'Geldiği Müdürlük']
                                                        as String,
                                                    not:
                                                        docRef['Not'] as String,
                                                    imageUrl:
                                                        docRef['İmage Url']
                                                            as String,
                                                  ),
                                                ),
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
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------------------------------------------------------------------------
class ProductSearch extends SearchDelegate<dynamic> {
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
                if (product.mevcut == true) {
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
                                    loadingBuilder:
                                        (context, child, progress) =>
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
                                    style:
                                        Theme.of(context).textTheme.headline1),
                                Text(" \t${product.mobilyaTuru} ",
                                    style:
                                        Theme.of(context).textTheme.headline2),
                                SizedBox(height: 10),
                                Text("MDV No:",
                                    style:
                                        Theme.of(context).textTheme.headline1),
                                Text(" \t${product.mdvno} ",
                                    style:
                                        Theme.of(context).textTheme.headline2),
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
            ).toList(),
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
              if (product.mevcut == false) {
                return Visibility(
                    visible: false,
                    child: Text('Aradığınız ürün Gönderilmiş sekmesindedir.'));
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
              // return Visibility(
              //     visible: true, child: Text('Herhangi Bir Sonuç Yok'));
            }).toList(),
            //),
          ),
        );
      },
    );
  }
}
