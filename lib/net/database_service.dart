import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<String> addProduct(String mobilyaTuru, String mdvno, String adet,
    String geldigiMudurluk, String not, String kategori, String url) async {
  String documentID = _firestore.doc().id;

  await _firestore.doc(documentID).set({
    'Mobilya Türü': mobilyaTuru,
    'MDV No': mdvno,
    'Adet': adet,
    'Geldiği Müdürlük': geldigiMudurluk,
    'Gönderildiği Müdürlük': '',
    'Not': not,
    'Document ID': documentID,
    'Kategori': kategori,
    'CreatedAt': DateTime.now(),
    'UpdatedDate': DateTime.now(),
    'UserId': _auth.currentUser!.email,
    'İmage Url': url,
  });

  return _firestore.id;
}
