import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeqr/pages/giris_sayfasi.dart';
<<<<<<< HEAD
=======
//import 'package:projeqr/pages/provider/theme_provider.dart';
>>>>>>> cba96b952608e452fcca816bfe0b52d82c3c9023
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';

Future<dynamic> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QrApp());
}

class QrApp extends StatelessWidget {
  const QrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            home: Girissayfasi(),
          );
        },
      );
}
