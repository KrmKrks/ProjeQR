import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/girissayfasi.dart';
import 'package:projeqr/pages/urunListeleme.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatefulWidget {
  QrGenerator({Key? key}) : super(key: key);

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

CollectionReference docu = FirebaseFirestore.instance.collection('products');

class _QrGeneratorState extends State<QrGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(10),
                data: 'FOtKj5Jk29VkVE7FUv6Y',
                size: 300,
                embeddedImage: AssetImage('assets/Mini_logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(40, 40),
                ),
              ),
              // MaterialButton(
              //   onPressed: () {
              //     print(QrImage);
              //   },)
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Malzeme Listesine Dön'),
                ),
                color: logoGreen,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => urunListeleme(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
