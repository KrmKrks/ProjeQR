import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeqr/pages/qr_result_page.dart';

List<Map> categories = [
  {'name': 'Sandalye', 'iconPath': 'assets/images/chair.png'},
  {'name': 'Masa', 'iconPath': 'assets/images/table.png'},
  {'name': 'Dolap', 'iconPath': 'assets/images/file-cabinet.png'},
  {'name': 'Keson', 'iconPath': 'assets/images/office-cabinet.png'},
  {'name': 'Diğer', 'iconPath': 'assets/images/magnifying-glass.png'},
];

// Future<dynamic> _fetch() async {
//   CollectionReference users =
//       await FirebaseFirestore.instance.collection('Users');

//   QuerySnapshot snapshot = await users.doc().get() as QuerySnapshot;

//   var userList= snapshot.docs()
// }
