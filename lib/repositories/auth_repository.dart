import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': email,
          'uid': userCredential.user!.uid,
          'favoriteMovies': [],
        });
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
