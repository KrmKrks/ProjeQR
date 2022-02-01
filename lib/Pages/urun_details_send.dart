import 'package:flutter/material.dart';
import 'package:projeqr/shared/theme_decoration.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrunDetailsSend extends StatefulWidget {
  final String documentID,
      mobilyaTuru,
      mdvNo,
      geldigiMudurluk,
      gonderildigiMudurluk,
      gelisTarihi,
      gonderilmeTarihi,
      not,
      url;

  UrunDetailsSend({
    Key? key,
    required this.documentID,
    required this.mobilyaTuru,
    required this.mdvNo,
    required this.geldigiMudurluk,
    required this.gonderildigiMudurluk,
    required this.gelisTarihi,
    required this.gonderilmeTarihi,
    required this.not,
    required this.url,
  }) : super(key: key);

  @override
  _UrunDetailsSendState createState() => _UrunDetailsSendState();
}

class _UrunDetailsSendState extends State<UrunDetailsSend> {
  @override
  Widget build(BuildContext context) {
    var _themeHeadline1 = Theme.of(context).textTheme.headline1;
    var _themeHeadline2 = Theme.of(context).textTheme.headline2;
    return Scaffold(
      body: Container(
        decoration: themeDecoration(context, BorderRadius.circular(0)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.url,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      _textWidget(context, 'Mobilya Türü', _themeHeadline1!)),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.mobilyaTuru}',
                  _themeHeadline2!.copyWith(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  'MDV No:',
                  _themeHeadline1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.mdvNo}',
                  _themeHeadline2,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  'Geldiği Müdürlük',
                  _themeHeadline1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.geldigiMudurluk}',
                  _themeHeadline2,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  'Gönderildiği Müdürlük',
                  _themeHeadline1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.gonderildigiMudurluk}',
                  _themeHeadline2.copyWith(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  'Geliş Tarihi',
                  _themeHeadline1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.gelisTarihi}',
                  _themeHeadline2.copyWith(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  'Gönderilme Tarihi',
                  _themeHeadline1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.gonderilmeTarihi}',
                  _themeHeadline2.copyWith(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  'Not',
                  _themeHeadline1,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: _textWidget(
                  context,
                  '${widget.not}',
                  _themeHeadline2.copyWith(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: MaterialButton(
                  height: 45,
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
                                embeddedImage:
                                    AssetImage('assets/Mini_logo.png'),
                                embeddedImageStyle: QrEmbeddedImageStyle(
                                  size: Size(40, 40),
                                ),
                              ),
                            ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _textWidget(BuildContext context, String string, TextStyle style) {
    return Text(
      string,
      style: style,
    );
  }
}
