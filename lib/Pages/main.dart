import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeqr/pages/girissayfasi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Girissayfasi(),
  ));
}
