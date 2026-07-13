import 'package:elitestate/core/services/property.dart';
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
}
