import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PropertyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProperty(PropertyModel property) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('properties').doc(property.id).set({
      'id': property.id,
      'title': property.title,
      'location': property.location,

      'price': property.price,
      'bedrooms': property.bedrooms,
      'bathrooms': property.bathrooms,
      'area': property.area,
      'isFavorite': property.isFavorite,
      'ownerId': uid,
      'ownerName': property.ownername,
    });
  }
}
