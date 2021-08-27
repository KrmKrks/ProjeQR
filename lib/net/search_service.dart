import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  seacrhByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('MobilyaTürüSearchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
