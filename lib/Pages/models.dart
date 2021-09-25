import 'package:cloud_firestore/cloud_firestore.dart';

List<Map<dynamic, dynamic>> categories = [
  {'name': 'Sandalye', 'iconPath': 'assets/images/chair.png'},
  {'name': 'Masa', 'iconPath': 'assets/images/table.png'},
  {'name': 'Dolap', 'iconPath': 'assets/images/file-cabinet.png'},
  {'name': 'Keson', 'iconPath': 'assets/images/office-cabinet.png'},
  {'name': 'Diğer', 'iconPath': 'assets/images/magnifying-glass.png'},
];

final List<String> kategori = <String>[
  'Masa',
  'Sandalye',
  'Dolap',
  'Keson',
  'Diğer',
];

class Product {
  final String mobilyaTuru;
  final String m;
  final String mdvno;
  final String adet;
  final String geldigiMudurluk;
  final String not;
  final String documnetId;
  final String kategori;
  final String createdAt;
  final String updatedDate;
  final String userId;
  final String url;
  bool mevcut;

  Product({
    required this.mobilyaTuru,
    required this.m,
    required this.mdvno,
    required this.adet,
    required this.geldigiMudurluk,
    required this.not,
    required this.documnetId,
    required this.kategori,
    required this.createdAt,
    required this.updatedDate,
    required this.userId,
    required this.mevcut,
    required this.url,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
        mobilyaTuru: snapshot['Mobilya Türü'] as String,
        m: snapshot['MobilyaTürüSearchKey'] as String,
        mdvno: snapshot['MDV No'] as String,
        adet: snapshot['Adet'] as String,
        geldigiMudurluk: snapshot['Geldiği Müdürlük'] as String,
        not: snapshot['Not'] as String,
        documnetId: snapshot['Document ID'] as String,
        kategori: snapshot['Kategori'] as String,
        createdAt: snapshot['CreatedAt'] as String,
        updatedDate: snapshot['UpdatedDate'] as String,
        userId: snapshot['UserId'] as String,
        mevcut: snapshot['Ürün Mevcut'] as bool,
        url: snapshot['İmage Url'] as String);
  }
}

// var userRole ;

// getRole() {
//   FirebaseFirestore.instance
//       .collection('Users')
//       .doc(_auth.currentUser!.uid)
//       .get()
//       .then((value) {
//     userRole = value.data()!['Role'].toString();
//   });
// }
