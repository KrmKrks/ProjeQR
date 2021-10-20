import 'package:flutter/material.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrunDetails extends StatefulWidget {
  final String documentID, mobilyaTuru, mdvNo, geldigiMudurluk, not, imageUrl;

  UrunDetails({
    Key? key,
    required this.documentID,
    required this.mobilyaTuru,
    required this.mdvNo,
    required this.geldigiMudurluk,
    required this.not,
    required this.imageUrl,
  }) : super(key: key);

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
                child: Text(
                  "Qr' ı görmek için dokunun!",
                  style: Theme.of(context).textTheme.headline2,
                ),
                color: Theme.of(context).textTheme.button!.backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: QrImage(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              data: widget.documentID,
                              size: 300,
                              embeddedImage: AssetImage('assets/Mini_logo.png'),
                              embeddedImageStyle: QrEmbeddedImageStyle(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: MaterialButton(
                  child: Text(
                    "Fotografi goster",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  color: Theme.of(context).textTheme.button!.backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                            widget.imageUrl,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
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
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
