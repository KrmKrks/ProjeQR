import 'package:flutter/material.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrunDetails extends StatefulWidget {
  String documentID, mobilyaTuru, adet, mudurluk, not;

  UrunDetails(
      {Key? key,
      required this.documentID,
      required this.mobilyaTuru,
      required this.adet,
      required this.mudurluk,
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
              "Mobilya Türü:"
              " \n${widget.mobilyaTuru} ",
              style: TextStyle(
                
                color: Theme.of(context).colorScheme.primary,
                fontSize: 25,
                decoration: TextDecoration.none,
              ),
              
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Adet:"
                " \t${widget.adet}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
                "Müdürlük:"
                " \t${widget.mudurluk}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
                "Not:"
                " \t${widget.not}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                      height: 8,
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
                      onPressed: () {
                      }
                    ),
          ],
        ),
        
      ),
    );
  }
}
