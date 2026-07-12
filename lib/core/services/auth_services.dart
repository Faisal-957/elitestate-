import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // signinn//
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //signup//
  Future<UserCredential> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: password);

    final uid = userCredential.user!.uid;
    await firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      "uid": uid,
    });
    return userCredential;
  }

  //logout//
  Future<void> signOut() async {
    await auth.signOut();
  }

  //reset password//
  Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await firestore.collection('users').doc(auth.currentUser!.uid).get();
  }
}
