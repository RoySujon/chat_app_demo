import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firstore = FirebaseFirestore.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //add document for the user in users collection if it dosen't already exist
      _firstore
          .collection('users')
          .doc(userCredential.user!.uid.toString())
          .set({
        'uid': userCredential.user!.uid.toString(),
        'email': userCredential.user!.email.toString()
      }, SetOptions(merge: true));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Signup---------------------------->
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //add document for the user in users collection if it dosen't already exist
      _firstore
          .collection('users')
          .doc(userCredential.user!.uid.toString())
          .set({
        'uid': userCredential.user!.uid.toString(),
        'email': userCredential.user!.email.toString()
      }, SetOptions(merge: true));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
