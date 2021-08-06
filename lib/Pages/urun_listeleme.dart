import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/category.dart';
import 'package:projeqr/pages/urun_details.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class UrunListeleme extends StatefulWidget {
  UrunListeleme({Key? key}) : super(key: key);

  @override
  UrunListelemeState createState() => UrunListelemeState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');

TextEditingController mobilyaTuruController = TextEditingController();
TextEditingController adetController = TextEditingController();
TextEditingController notController = TextEditingController();
TextEditingController mudurlukController = TextEditingController();

final Color logoGreen = Color(0xFF5f59f7);

class UrunListelemeState extends State<UrunListeleme> {
  @override
  build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Provider.of<ThemeProvider>(context).isDarkMode
                  ? gradientDarkMode
                  : gradientLightMode),
        ),
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
//----------------------------------------------------------------------------------------------
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search),
                    Text(
                      'Search',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20),
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
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            width: 90,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Categories(
                                        categoriesGet: categories[index]['name']
                                            as String),
                                  ),
                                );
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
                  stream:
                      ref.orderBy('CreatedAt', descending: true).snapshots(),
                  builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var docRef = snapshot.data!.docs[index];
                          return Card(
                            color: Theme.of(context).cardColor,
                            shadowColor: Theme.of(context).shadowColor,
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle_rounded,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              title: Text(
                                "Mobilya Türü:"
                                " \t${docRef['Mobilya Türü']} ",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .fontSize),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text(
                                    "Adet:"
                                    " \t${docRef['Adet']}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Müdürlük:",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .fontWeight,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    " \t${docRef['Müdürlük']}",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .fontWeight,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Not:"
                                    " \t${docRef['Not']}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Theme.of(context).iconTheme.color,
                                onPressed: () {
                                  mobilyaTuruController.text =
                                      docRef['Mobilya Türü'] as String;
                                  adetController.text =
                                      docRef['Adet'] as String;
                                  mudurlukController.text =
                                      docRef['Müdürlük'] as String;
                                  notController.text = docRef['Not'] as String;

                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .isDarkMode
                                                        ? gradientDarkMode
                                                        : gradientLightMode),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                        adetController,
                                                        "Adet",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    buildTextFormField(
                                                        mudurlukController,
                                                        "Müdürlük",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    buildTextFormField(
                                                        notController,
                                                        "Not",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    MaterialButton(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Dökümanı Güncelle",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .button,
                                                        ),
                                                      ),
                                                      color: Theme.of(context)
                                                          .buttonColor,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      onPressed: () {
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference
                                                            .update({
                                                          'Mobilya Türü':
                                                              mobilyaTuruController
                                                                  .text,
                                                          'Adet': adetController
                                                              .text,
                                                          'Müdürlük':
                                                              mudurlukController
                                                                  .text,
                                                          'Not': notController
                                                              .text,
                                                        }).whenComplete(() =>
                                                                Navigator.pop(
                                                                    context));
                                                      },
                                                    ),
                                                    MaterialButton(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Ürünü Sil",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .button,
                                                        ),
                                                      ),
                                                      color: Theme.of(context)
                                                          .buttonColor,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      onPressed: () {
                                                        snapshot
                                                            .data!
                                                            .docs[index]
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UrunDetails(
                                          documentID:
                                              docRef['Document ID'] as String,
                                          mobilyaTuru:
                                              docRef['Mobilya Türü'] as String,
                                          adet: docRef['Adet'] as String,
                                          mudurluk:
                                              docRef['Müdürlük'] as String,
                                          not: docRef['Not'] as String)),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else
                      return Text('Herhangi bir veri bulunamadı');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
