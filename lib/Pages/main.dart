import 'package:projeqr/pages/%C3%BCyeol.dart';
import 'package:projeqr/pages/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeqr/pages/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Authentication(),
  ));
}

// TODO:  main.dart içindeki login kısmını tamamen iptal ettim.
// TODO: login ile alakalı kısımların buradan temizlenmesi lazım örnek olması adına şimdilik tutuyorum.
