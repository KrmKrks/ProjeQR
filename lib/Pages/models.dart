import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<Map> categories = [
  {'name': 'Sandalye', 'iconPath': 'assets/images/chair.png'},
  {'name': 'Masa', 'iconPath': 'assets/images/table.png'},
  {'name': 'Dolap', 'iconPath': 'assets/images/file-cabinet.png'},
  {'name': 'Keson', 'iconPath': 'assets/images/office-cabinet.png'},
  {'name': 'Diğer', 'iconPath': 'assets/images/magnifying-glass.png'},
];
FirebaseAuth _auth = FirebaseAuth.instance;

var userRoles = "";

getRole() {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((userRole) {
    userRoles = userRole.data()!['Role'].toString();
  });
}
