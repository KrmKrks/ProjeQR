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

Future<String> addProduct(
    String mobilyaTuru,
    String mdvno,
    String adet,
    String geldigiMudurluk,
    String not,
    String kategori,
    String createdAt,
    String updatedDate,
    String url,
    bool mevcut) async {
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
    'CreatedAt': createdAt,
    'UpdatedDate': updatedDate,
    'UserId': _auth.currentUser!.email,
    'İmage Url': url,
    'Ürün Mevcut': mevcut
  });

  return _firestore.id;
}
