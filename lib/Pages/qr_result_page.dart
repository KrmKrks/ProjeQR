import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrResult extends StatefulWidget {
  final String scanResult;
  QrResult({Key? key, required this.scanResult}) : super(key: key);

  @override
  _QrResultState createState() => _QrResultState();
}

CollectionReference doc = FirebaseFirestore.instance.collection('products');

class _QrResultState extends State<QrResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: themeDecoration(context, BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: doc
                .where('Document ID', isEqualTo: widget.scanResult)
                .snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var docRef = snapshot.data!.docs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_back,
                                size: 30,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: MaterialButton(
                            minWidth: 300,
                            child: Text(
                              "Qr' ı görmek için dokunun!",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            color: Theme.of(context)
                                .textTheme
                                .button!
                                .backgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: QrImage(
                                          backgroundColor: Colors.white,
                                          padding: const EdgeInsets.all(10),
                                          data: docRef['Document ID'] as String,
                                          size: 300,
                                          embeddedImage: AssetImage(
                                              'assets/Mini_logo.png'),
                                          embeddedImageStyle:
                                              QrEmbeddedImageStyle(
                                            size: Size(40, 40),
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Mobilya Türü:",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          " \t${docRef['Mobilya Türü']} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "MDV No:",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          " \t${docRef['MDV No']} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Geldiği Müdürlük",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          " \t${docRef['Geldiği Müdürlük']} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Gönderildiği Müdürlük",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          "\t${docRef['Gönderildiği Müdürlük']}",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Not",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          " \t${docRef['Not']} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: MaterialButton(
                              minWidth: 300,
                              child: Text(
                                "Fotografi goster",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              color: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              onPressed: () {
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
                                        docRef['İmage Url'] as String,
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
                              }),
                        ),
                      ],
                    );
                  },
                );
              } else
                return Text('Herhangi bir ürün bulunamadı!');
            }),
      ),
    );
  }
}
