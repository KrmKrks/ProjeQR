import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;

//DENEME KISMI

// class Database {

//   static Future<String?> uploadingImage(File imageFile) async {
//     String fileName = basename(imageFile.toString());

//     firebase_storage.Reference ref =
//         firebase_storage.FirebaseStorage.instance.ref().child(fileName);
//     firebase_storage.UploadTask task = ref.putFile(imageFile);
//     firebase_storage.TaskSnapshot snapshot = await task.whenComplete(() {} );
//   }
// }
final CollectionReference _firestore =
    FirebaseFirestore.instance.collection('products');
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> addProduct(
    String mobilyaTuru,
    String m,
    String mdvno,
    String adet,
    String geldigiMudurluk,
    /*String g,*/
    String not,
    String kategori,
    String createdAt,
    String updatedDate,
    String url,
    bool mevcut) async {
  String documentID = _firestore.doc().id;

  await _firestore.doc(documentID).set({
    'Mobilya Türü': mobilyaTuru,
    'MobilyaTürüSearchKey': m,
    'MDV No': mdvno,
    'Adet': adet,
    'Geldiği Müdürlük': geldigiMudurluk,
    //'GeldiğiMüdürlüksearchKey':g,
    'Gönderildiği Müdürlük': '',
    'Not': not,
    'Document ID': documentID,
    'Kategori': kategori,
    'CreatedAt': createdAt,
    'UpdatedDate': updatedDate,
    'UserId': _auth.currentUser!.email,
    'İmage Url': url,
    'Ürün Mevcut': mevcut
  });

  return _firestore.id;
}

// final ImagePicker _picker = ImagePicker();
// String? imageUrl;

// Future<dynamic> pickImage(ImageSource source) async {
//   final pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
//   if (pickedFile == null) {
//     return;
//   }

//   var file = await ImageCropper.cropImage(
//       sourcePath: pickedFile.path,
//       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

//   if (file == null) {
//     return;
//   }

//   file = await compressImage(file.path, 35);

//   await _uploadFile(file.path);
// }

// Future<File> compressImage(String path, int quality) async {
//   final newPath = p.join((await getTemporaryDirectory()).path,
//       '${DateTime.now()}.${p.extension(path)}');

//   final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
//       quality: quality);
//   return result!;
// }

// Future<dynamic> _uploadFile(String path) async {
//   final ref = storage.FirebaseStorage.instance
//       .ref()
//       .child('images')
//       .child('${DateTime.now().toIso8601String() + p.basename(path)}');

//   final result = await ref.putFile(File(path));
//   final fileUrl = await result.ref.getDownloadURL();
//   setState(() {
//     imageUrl = fileUrl;
//   });
// }
