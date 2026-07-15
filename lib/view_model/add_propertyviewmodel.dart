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
  }) async {
    if (title.isEmpty ||
        location.isEmpty ||
        price.isEmpty ||
        bedrooms.isEmpty ||
        bathrooms.isEmpty ||
        area.isEmpty) {
      throw Exception("Please fill all fields");
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
    );

    await addProperty(property);
  }

  Future<void> deleteProperty(String propertyId) async {
    await _service.deletproperty(propertyId);
    notifyListeners();
  }

  Stream<List<PropertyModel>> myPropertiesStream(String ownerId) {
    return _service.fetchMyProperties(ownerId);
  }
}
