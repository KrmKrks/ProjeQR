import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeqr/pages/models.dart';

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

class FilterService {
  Future<List<Product>> getProduct() async {
    var documents = await _firestore.get();

    return documents.docs
        .map((snapshot) => Product.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Product>> getProductMap(String query) async {
    var productMap = await getProduct();

    var filteredProduct = productMap
        .where(
          (product) => product.mobilyaTuru.startsWith(query),
        )
        .toList();

    return filteredProduct;
  }
}
