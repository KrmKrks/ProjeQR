import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TODO :  Authentication kısmının yeniden tasarlanması gerekiyor daha iyi hale getirlebilinir.

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool?> signIn(String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (message) {
      return Fluttertoast.showToast(
          msg: message.message as String,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 10);
    }
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<bool?> signUp(String name, String surname, String email,
      String sicilno, String password) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection('Users').doc(user.user!.uid).set({
        'isim': name,
        'soyisim': surname,
        'email': email,
        'THY sicil no': sicilno,
        'UserId': user.user!.uid,
        'Password': password,
        'Role': 'Member',
      });
    } on FirebaseAuthException catch (e) {
      return Fluttertoast.showToast(
          msg: e.message as String,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 10);
    }
  }
}
