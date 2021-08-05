import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/category.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/pages/urun_details.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class UrunListeleme extends StatefulWidget {
  UrunListeleme({Key? key}) : super(key: key);

  @override
  UrunListelemeState createState() => UrunListelemeState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');

_buildTextField(TextEditingController controller, String labelText, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    child: TextField(
      controller: controller,
      style: TextStyle(
          color: Theme.of(context as BuildContext).colorScheme.primary),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          labelText: labelText,
          border: InputBorder.none),
    ),
  );
}

TextEditingController mobilyaTuruController = TextEditingController();
TextEditingController adetController = TextEditingController();
TextEditingController notController = TextEditingController();
TextEditingController mudurlukController = TextEditingController();

final Color logoGreen = Color(0xFF5f59f7);

// fireStore_Get_Products() {
//   List<String> prodList = [];
//   FirebaseFirestore.instance
//       .collection('products')
//       .orderBy('Kategori', Equalto, categories['name']);
// }

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
                                docRef['Mobilya Türü'] as String,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Text(
                                    docRef['Adet'] as String,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  Text(
                                    docRef['Müdürlük'] as String,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  Text(
                                    docRef['Not'] as String,
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
                                            child: Container(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    _buildTextField(
                                                        mobilyaTuruController,
                                                        "Mobilya Türü",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    _buildTextField(
                                                        adetController,
                                                        "Adet Giriniz",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    _buildTextField(
                                                        mudurlukController,
                                                        "Gelen veya Giden Müdürlüğü Belirtiniz",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    _buildTextField(
                                                        notController,
                                                        "Eklemek istediğiniz notunuz var ise ekleyiniz",
                                                        context) as Widget,
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    FlatButton(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            "Dökümanı Güncelle"),
                                                      ),
                                                      color: logoGreen,
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
                                                    FlatButton(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Text(
                                                            "Ürünü Sil"),
                                                      ),
                                                      color: logoGreen,
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
