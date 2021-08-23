import 'package:flutter/material.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrunDetails extends StatefulWidget {
  String documentID, mobilyaTuru, mdvNo, adet, geldigiMudurluk, not;

  UrunDetails(
      {Key? key,
      required this.documentID,
      required this.mobilyaTuru,
      required this.mdvNo,
      required this.adet,
      required this.geldigiMudurluk,
      required this.not})
      : super(key: key);

  @override
  _UrunDetailsState createState() => _UrunDetailsState();
}

class _UrunDetailsState extends State<UrunDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: themeDecoration(context, BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: [
                QrImage(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                  data: widget.documentID,
                  size: 300,
                  embeddedImage: AssetImage('assets/Mini_logo.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(40, 40),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Mobilya Türü:",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              " \t${widget.mobilyaTuru} ",
              style:
                  Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20),
            ),
            SizedBox(height: 15),
            Text(
              "MDV No:",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              " \t${widget.mdvNo} ",
              style:
                  Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Adet",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              " \t${widget.adet} ",
              style:
                  Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Geldiği Müdürlük",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              " \t${widget.geldigiMudurluk} ",
              style:
                  Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Not",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              " \t${widget.not} ",
              style:
                  Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fotografi goster",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
