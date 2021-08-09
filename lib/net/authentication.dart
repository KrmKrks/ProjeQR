import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO :  Authentication kısmının yeniden tasarlanması gerekiyor daha iyi hale getirlebilinir.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(String name, String surname, String email,
      String sicilno, String password) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection('Users').doc(user.user!.uid).set({
        'isim': name,
        'soyisim': surname,
        'email': email,
        'sicil no': sicilno,
        'UserId': user.user!.uid,
      });
      return user.user;
    } on FirebaseAuthException catch (e) {}
  }
}
