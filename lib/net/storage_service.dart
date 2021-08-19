import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';




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
