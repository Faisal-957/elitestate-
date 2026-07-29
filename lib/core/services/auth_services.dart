import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/models/userModel.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // SIGN IN
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // SIGN UP
  Future<UserCredential> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    String? profileImageUrl,
  }) async {
    // Create Firebase Auth user
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: password);

    // Get Firebase UID
    final uid = userCredential.user!.uid;

    // Create UserModel
    final userModel = UserModel(
      id: uid,
      name: name,
      email: email,
      profileImageUrl: profileImageUrl,
    );

    // Save UserModel in Firestore
    await firestore.collection('users').doc(uid).set(userModel.toMap());

    return userCredential;
  }

  // GET USER DATA
  Future<UserModel?> getUserData() async {
    final uid = auth.currentUser?.uid;

    if (uid == null) {
      return null;
    }

    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return UserModel.fromMap(doc.data()!, doc.id);
  }

  // UPDATE PROFILE IMAGE
  Future<void> updateProfileImage(String profileImageUrl) async {
    final uid = auth.currentUser?.uid;

    if (uid == null) {
      return;
    }

    await firestore.collection('users').doc(uid).update({
      'profileImageUrl': profileImageUrl,
    });
  }

  // UPDATE PHONE NUMBER
  Future<void> updatePhoneNumber(String phone) async {
    final uid = auth.currentUser?.uid;

    if (uid == null) {
      return;
    }

    await firestore.collection('users').doc(uid).update({'phone': phone});
  }

  // LOGOUT
  Future<void> signOut() async {
    await auth.signOut();
  }

  // RESET PASSWORD
  Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  // CURRENT USER ID
  String? get currentUserId => auth.currentUser?.uid;
}
