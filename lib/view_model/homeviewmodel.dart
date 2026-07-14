import 'package:elitestate/core/services/property_service.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';

class Homeviewmodel extends ChangeNotifier {
  final PropertyService _propertyService = PropertyService();
  final TextEditingController searchController = TextEditingController();

  late final Stream<List<PropertyModel>> propertiesStream;
  String searchQuery = "";

  Homeviewmodel() {
    propertiesStream = _propertyService.fetchingProperties();
    searchController.addListener(() {
      searchQuery = searchController.text.trim().toLowerCase();
      notifyListeners();
    });
  }

  List<PropertyModel> filterProperties(List<PropertyModel> properties) {
    if (searchQuery.isEmpty) return properties;
    return properties.where((property) {
      return property.title.toLowerCase().contains(searchQuery) ||
          property.location.toLowerCase().contains(searchQuery);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
