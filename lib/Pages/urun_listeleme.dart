import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/provider/theme_provider.dart';
import 'package:provider/provider.dart';


import 'package:qr_flutter/qr_flutter.dart';
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
                            child: Image.asset(
                                categories[index]['iconPath'] as String),
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
                  stream: ref.snapshots(),
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
                                onTap: () {
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
                                              Column(
                                                children: [
                                                  QrImage(
                                                    backgroundColor:
                                                        Colors.white,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    data: docRef['Document ID']
                                                        as String,
                                                    size: 300,
                                                    embeddedImage: AssetImage(
                                                        'assets/Mini_logo.png'),
                                                    embeddedImageStyle:
                                                        QrEmbeddedImageStyle(
                                                      size: Size(40, 40),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  docRef['Mobilya Türü']
                                                      as String,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 25)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(docRef['Adet'] as String,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 25)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(docRef['Müdürlük'] as String,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 25)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(docRef['Not'] as String,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 25)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.account_circle_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                title: Text(
                                  docRef['Mobilya Türü'] as String,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    // Text(
                                    //   docRef['Mobilya Türü'],
                                    //   style: TextStyle(color: Colors.white),
                                    // ),
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
                                    notController.text =
                                        docRef['Not'] as String;

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
                                                            'Adet':
                                                                adetController
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
                              ),
                            );
                          });
                    } else
                      return Text('');
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
