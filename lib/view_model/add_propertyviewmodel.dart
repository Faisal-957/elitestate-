import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/services/property_service.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';

class PropertyViewModel extends ChangeNotifier {
  final PropertyService _service = PropertyService();

  bool isLoading = false;

  Future<void> addProperty(PropertyModel property) async {
    isLoading = true;
    notifyListeners();

    await _service.addProperty(property);

    isLoading = false;
    notifyListeners();
  }

  Future<void> submitNewProperty({
    required String title,
    required String location,
    required String price,
    required String bedrooms,
    required String bathrooms,
    required String area,
    required String description,
    required String ownerId,
    required String ownerName,
    required String ownerPhone,
    required List<String> imageUrls,
  }) async {
    if (title.isEmpty ||
        location.isEmpty ||
        price.isEmpty ||
        bedrooms.isEmpty ||
        bathrooms.isEmpty ||
        area.isEmpty) {
      throw Exception("Please fill all fields");
    }

    if (imageUrls.isEmpty) {
      throw Exception("Please add at least one picture");
    }

    final property = PropertyModel(
      title: title,
      location: location,
      price: double.parse(price),
      bedrooms: int.parse(bedrooms),
      bathrooms: int.parse(bathrooms),
      area: double.parse(area),
      description: description,
      ownerId: ownerId,
      ownerName: ownerName,
      ownerPhone: ownerPhone,
      images: imageUrls,
    );

    await addProperty(property);
  }

  Future<void> deleteProperty(String propertyId) async {
    await _service.deletproperty(propertyId);
    notifyListeners();
  }
  ////////////////// my properties fatch/////////////

  Stream<List<PropertyModel>> myPropertiesStream(String ownerId) {
    return _service.fetchMyProperties(ownerId);
  }

  ////////////////// update property //////////////////
  Future<void> updateProperty({
    required String propertyId,
    required String title,
    required String location,
    required double price,
    required int bedrooms,
    required int bathrooms,
    required double area,
    required String description,
    required List<String> imageUrls,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('properties')
          .doc(propertyId)
          .update({
            'title': title,
            'location': location,
            'price': price,
            'bedrooms': bedrooms,
            'bathrooms': bathrooms,
            'area': area,
            'description': description,
            'images': imageUrls,
          });
      notifyListeners();
    } catch (e) {
      debugPrint("Update Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
