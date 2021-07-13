import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/girissayfasi.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrunListeleme extends StatefulWidget {
  UrunListeleme({Key? key}) : super(key: key);

  @override
  UrunListelemeState createState() => UrunListelemeState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('products');

_buildTextField(TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: secondaryColor, border: Border.all(color: Colors.blue)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
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
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   height: 30,
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   margin: EdgeInsets.symmetric(vertical: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Icon(Icons.search),
            //       Text('Search'),
            //       Icon(Icons.settings),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: 30,
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   margin: EdgeInsets.symmetric(vertical: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [],
            //   ),
            // ),
            // SizedBox(height: 10),
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
                            color: Colors.black,
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Container(
                                      color: primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                QrImage(
                                                  backgroundColor: Colors.white,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  data: docRef['Document ID'],
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
                                            Text(docRef['Mobilya Türü'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(docRef['Adet'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(docRef['Müdürlük'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(docRef['Not'],
                                                style: TextStyle(
                                                    color: Colors.white,
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
                                color: Colors.yellow,
                              ),
                              title: Text(
                                docRef['Mobilya Türü'],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  // Text(
                                  //   docRef['Mobilya Türü'],
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                  Text(
                                    docRef['Adet'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    docRef['Müdürlük'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    docRef['Not'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.yellow,
                                onPressed: () {
                                  mobilyaTuruController.text =
                                      docRef['Mobilya Türü'];
                                  adetController.text = docRef['Adet'];
                                  mudurlukController.text = docRef['Müdürlük'];
                                  notController.text = docRef['Not'];

                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Container(
                                              color: primaryColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    _buildTextField(
                                                        mobilyaTuruController,
                                                        "Mobilya Türü"),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    _buildTextField(
                                                        adetController,
                                                        "Adet Giriniz"),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    _buildTextField(
                                                        mudurlukController,
                                                        "Gelen veya Giden Müdürlüğü Belirtiniz"),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    _buildTextField(
                                                        notController,
                                                        "Eklemek istediğiniz notunuz var ise ekleyiniz"),
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
                                                        child:
                                                            Text("Ürünü Sil"),
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
    );
  }
}
