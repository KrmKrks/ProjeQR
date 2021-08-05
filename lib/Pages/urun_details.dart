import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
//import 'package:projeqr/pages/provider/theme_provider.dart';
>>>>>>> cba96b952608e452fcca816bfe0b52d82c3c9023
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Provider.of<ThemeProvider>(context).isDarkMode
                ? gradientDarkMode
                : gradientLightMode),
      ),
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
              widget.mobilyaTuru,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 25,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(widget.adet,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: 20,
            ),
            Text(widget.mudurluk,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: 20,
            ),
            Text(widget.not,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

buildTextFormField(
    TextEditingController controller, String labelText, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    child: TextFormField(
      validator: (value) =>
          value!.isEmpty ? 'Bu alanı boş geçemezsiniz.' : null,
      controller: controller,
      style: TextStyle(
          color: Theme.of(context as BuildContext).colorScheme.primary),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none),
    ),
  );
}
