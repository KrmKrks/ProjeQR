import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/girissayfasi.dart';

class urunListeleme extends StatefulWidget {
  urunListeleme({Key? key}) : super(key: key);

  @override
  urunListelemeState createState() => urunListelemeState();
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

class urunListelemeState extends State<urunListeleme> {
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var docRef = snapshot.data!.docs[index];
                    return ListTile(
                      leading: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.yellow,
                      ),
                      title: Text(
                        docRef['Document ID'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                            docRef['Mobilya Türü'],
                            style: TextStyle(color: Colors.white),
                          ),
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
                          mobilyaTuruController.text = docRef['Mobilya Türü'];
                          adetController.text = docRef['Adet'];
                          mudurlukController.text = docRef['Müdürlük'];
                          notController.text = docRef['Not'];

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
                                            _buildTextField(
                                                mobilyaTuruController,
                                                "Mobilya Türü"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            _buildTextField(
                                                adetController, "Adet Giriniz"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            _buildTextField(mudurlukController,
                                                "Gelen veya Giden Müdürlüğü Belirtiniz"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            _buildTextField(notController,
                                                "Eklemek istediğiniz notunuz var ise ekleyiniz"),
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
                                                child: Text("Ürünü Sil"),
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
                    );
                  });
            } else
              return Text('');
          }),
    );
  }
}