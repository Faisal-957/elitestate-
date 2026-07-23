import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/services/property_service.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PropertyViewModel extends ChangeNotifier {
  final PropertyService _service = PropertyService();
  int activeindex = 0;

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

  Future<void> updateProperty({
    required String propertyId,
    required String title,
    required String location,
    required double price,
    required int bedrooms,
    required int bathrooms,
    required double area,
    required String description,
  }) async {
    try{
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
        });
    notifyListeners();
    }catch(e){debugPrint("Update Error: $e");}finally {
    // Stop Loading - IMPORTANT
    isLoading = false;
    notifyListeners();
  }
  }

  void changeImageIndex(int index) {
    activeindex = index;
    notifyListeners();
  }
  ////////////////// image pickert///////////////

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];
  Future<void> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages = images;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  } // Remove single image

  void removeImage(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  //Clear all images
  void clearImages() {
    selectedImages.clear();
    notifyListeners();
  }
  /////////////// profile image picker//////////

  XFile? profileImage;

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        profileImage = image;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Profile image error: $e");
    }
  }
}
