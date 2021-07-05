import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StatusService {
  final FirebaseStorage _firestoreStorage = FirebaseStorage.instance;

  uploadMedia(File file) async {
    var uploadTask = _firestoreStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    var storageRef = await uploadTask;
    return await storageRef.ref.getDownloadURL();
  }
}
