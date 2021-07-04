import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class uruncikarma extends StatefulWidget {
  uruncikarma({Key? key}) : super(key: key);

  @override
  uruncikarmaState createState() => uruncikarmaState();
}

class uruncikarmaState extends State<uruncikarma> {
  @override
  build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/THY-LOGO-DARK.png'),
              height: 220,
            ),
            SizedBox(height: 10),
            Text(
              '',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      ),
    ));
  }
}
