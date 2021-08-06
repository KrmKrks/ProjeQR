import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/urun_details.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/widget/build_textformfield_widget.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  String categoriesGet;
  Categories({Key? key, required this.categoriesGet}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');

TextEditingController mobilyaTuruController = TextEditingController();
TextEditingController adetController = TextEditingController();
TextEditingController notController = TextEditingController();
TextEditingController mudurlukController = TextEditingController();

final Color logoGreen = Color(0xFF5f59f7);

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).devicePixelRatio / 0.1,
        horizontal: MediaQuery.of(context).devicePixelRatio / 0.18,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Provider.of<ThemeProvider>(context).isDarkMode
                ? gradientDarkMode
                : gradientLightMode),
      ),
      child: SafeArea(
        child: StreamBuilder(
          stream: ref
              .where('Kategori', isEqualTo: widget.categoriesGet)
              .orderBy('CreatedAt', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        "Mobilya Türü:" " \t${docRef['Mobilya Türü']} ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                            docRef['Adet'] as String,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            docRef['Müdürlük'] as String,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            docRef['Not'] as String,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
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
                          adetController.text = docRef['Adet'] as String;
                          mudurlukController.text =
                              docRef['Müdürlük'] as String;
                          notController.text = docRef['Not'] as String;

                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Container(
                                      color: Theme.of(context).primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                "Adet Giriniz",
                                                context) as Widget,
                                            SizedBox(
                                              height: 20,
                                            ),
                                            buildTextFormField(
                                                mudurlukController,
                                                "Gelen veya Giden Müdürlüğü Belirtiniz",
                                                context) as Widget,
                                            SizedBox(
                                              height: 20,
                                            ),
                                            buildTextFormField(
                                                notController,
                                                "Eklemek istediğiniz notunuz var ise ekleyiniz",
                                                context) as Widget,
                                            SizedBox(
                                              height: 20,
                                            ),
                                            FlatButton(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    Text("Dökümanı Güncelle"),
                                              ),
                                              color: logoGreen,
                                              onPressed: () {
                                                snapshot
                                                    .data!.docs[index].reference
                                                    .update({
                                                  'Mobilya Türü':
                                                      mobilyaTuruController
                                                          .text,
                                                  'Adet': adetController.text,
                                                  'Müdürlük':
                                                      mudurlukController.text,
                                                  'Not': notController.text,
                                                }).whenComplete(() =>
                                                        Navigator.pop(context));
                                              },
                                            ),
                                            FlatButton(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: const Text("Ürünü Sil"),
                                              ),
                                              color: logoGreen,
                                              onPressed: () {
                                                snapshot
                                                    .data!.docs[index].reference
                                                    .delete()
                                                    .whenComplete(() =>
                                                        Navigator.pop(context));
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
                                  documentID: docRef['Document ID'] as String,
                                  mobilyaTuru: docRef['Mobilya Türü'] as String,
                                  adet: docRef['Adet'] as String,
                                  mudurluk: docRef['Müdürlük'] as String,
                                  not: docRef['Not'] as String)),
                        );
                      },
                    ),
                  );
                },
              );
            } else
              return Text('Herhangi bir ürün bulunamadı!');
          },
        ),
      ),
    );
  }
}
