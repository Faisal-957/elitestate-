import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PropertyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /////////////// add function////////////////////////////
  Future<void> addProperty(PropertyModel propertyModel) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection("properties").doc().set(propertyModel.toMap());
  }

  //////////////fetching data ///////////////////////
  Stream<List<PropertyModel>> fetchingProperties() {
    final data = _firestore
        .collection("properties")
        .orderBy("createdAt", descending: true)
        .snapshots();
    return data.map((snapshot) {
      return snapshot.docs.map((doc) {
        return PropertyModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
