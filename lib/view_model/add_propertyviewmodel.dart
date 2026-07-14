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

  Future<void> deleteProperty(String propertyId) async {
    await _service.deletproperty(propertyId);
    notifyListeners();
  }
}
